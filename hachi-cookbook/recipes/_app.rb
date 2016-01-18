
include_recipe 'nginx'
include_recipe "git::default"
git "/opt/hachi" do
  repository "https://github.com/codeignition/hachi.git"
  revision "HEAD"
  user 'vagrant'
  group 'vagrant'
  action :sync
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
  rails do
    database 'sqlite3:///db.sqlite3'
    secret_token 'd78fe08df56c9'
    migrate true
  end
  ['/opt/hachi','/opt/hachi/shared', '/opt/hachi/shared/log', '/opt/hachi/shared/pids', '/opt/hachi/shared/sockets'].each do |path|
    directory path do
      user 'vagrant'
      group 'vagrant'
      mode '0755'
      recursive true
    end
  application_puma
  end
  execute 'start puma' do
    user 'vagrant'
    group 'vagrant'
    cwd '/opt/hachi'
    environment 'PATH' => "/opt/ruby_build/builds/opt/hachi/bin/:#{ENV['PATH']}"
    command 'foreman start &'
  end
  template "/etc/nginx/conf.d/hachi.conf" do
    source "nginx/nginx.conf.erb"
    mode "400"
    user 'vagrant'
    group 'vagrant'
    variables(
      app_name: "hachi",
      ipaddress: node.ipaddress
    )
    notifies :reload, "service[nginx]"
  end
end
