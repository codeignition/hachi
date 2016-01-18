define :_puma do

  app_name       = params[:name]
  app_user       = node.apps[:user]
  app_group      = node.apps[:group]
  ruby_type      = node.ruby_type

  directory "/etc/puma/" do
    owner app_user
    group app_group
    mode 00744
    action :create
  end

  directory "/var/run/#{app_name}" do
    owner app_user
    group app_group
    mode 00755
    action :create
  end

  directory "/var/log/#{app_name}" do
    owner app_user
    group app_group
    mode 00744
    action :create
  end

template "/etc/puma/#{app_name}.rb" do
    source "puma/puma.rb.erb"
    owner app_user
    group app_group
    mode "400"
    variables(app: app_name,
              app_dir: node.apps[:location],
              ruby_type: ruby_type
             )
    notifies :restart, "service[puma]", :delayed
  end

  template "/etc/init/puma.conf" do
    source "apps/puma.conf.erb"
    owner app_user
    group app_group
    mode "00775"
    variables(app_name: app_name,
              app_user: app_user,
              app_group: app_group,
              ruby_location: node[ruby_type][:bin]
             )
    notifies :restart, "service[puma]", :delayed
  end

  service "puma" do
    action :enable
    supports :status => true, :start => true, :stop => true, :restart => true
    provider Chef::Provider::Service::Upstart
  end
end
