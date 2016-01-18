define :_nginx do
  app_name  = params[:name]
  app_user  = node.apps[:user]
  app_group = node.apps[:group]

  include_recipe "nginx"

  template "/etc/nginx/conf.d/#{params[:name]}.conf" do
    source "nginx/nginx_#{node.nginx.forward_type}_forward.conf.erb"
    owner app_user
    group app_group
    mode "400"
    variables(
              app_name: params[:name],
              ipaddress: node.ipaddress
      )
    notifies :reload, "service[nginx]"
  end

  execute "own nginx dir" do
    command "chown -R #{app_user}:#{app_group} /var/lib/nginx/"
    notifies :restart, "service[nginx]"
  end
end
