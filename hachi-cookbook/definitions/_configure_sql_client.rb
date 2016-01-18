define :_configure_sql_client do
  app      = params[:name]
  ruby_type= node.ruby_type
  database_type = params[:database_type]
  run_migration = params[:run_migration]

  case database_type
    when "mysql"
      mysql_client 'default' do
        action :create
      end
    when "postgresql"
      include_recipe "postgresql_wrapper::client"
  end

  db_detail = data_bag_item(database_type, app)[node.chef_environment]
  raise "update databag with #{app} database" if db_detail.nil?
  Chef::Log.info("seting db host to #{db_detail["host"]}")

  template "#{node.apps[:location]}/#{app}/config/database.yml" do
    source "apps/database.yml.erb"
    owner node.apps[:user]
    group node.apps[:group]
    mode "400"
    variables db_detail
    cookbook 'library'
    action :create
    notifies :run, "execute[db_migrate_#{app}]", :immediately
  end

  env = Hash[params[:environment_variables].merge("RAILS_ENV" => "production").map{|key, value| [ key.to_s, value.to_s ]}]
  execute "db_migrate_#{app}" do
    action :nothing
    user node.apps[:user]
    group node.apps[:group]
    cwd "#{node.apps[:location]}/#{app}"
    command "PATH=#{node[ruby_type][:bin]}:$PATH bundle exec rake db:migrate"
    environment env
    not_if { run_migration == false}
  end
end