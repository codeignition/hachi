define :rails_app do

  app_name = params[:name]
  app_user = node.apps[:user]
  app_group = node.apps[:group]
  init_service = params[:init_service]

  _setup_user app_name

  _nginx app_name
  _puma app_name

  git node.apps.location do
    repository "https://github.com/codeignition/hachi.git"
    revision "HEAD"
    user 'hachi'
    group 'hachi'
    action :sync
    notifies :restart, "service[#{init_service}]", :delayed
  end

  application '/opt/hachi' do
    ruby_runtime '/opt/hachi' do
      provider :ruby_build
      version '2.2.3'
    end
    ruby_gem 'bundler'
    ruby_gem 'foreman'
    bundle_install do
      deployment true
      without %w{development test}
    end
  end

  execute "chown source code ownership to #{app_user}" do
    command "chown -R #{app_user}.#{app_group} #{node.apps.location}"
  end

  template "/etc/default/#{app_name}.conf" do
    source "apps/app.conf.erb"
    owner app_user
    group app_group
    variables :environment_variables => params[:environment_variables]
    notifies :restart, "service[#{init_service}]", :delayed
    only_if { params[:environment_variables] }
  end
end
