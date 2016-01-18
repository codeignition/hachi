define :_setup_user do
  app_user  = node.apps[:user]
  app_group = node.apps[:group]
  gid       = params[:gid] || 2000
  uid       = params[:uid] || 2000

  group app_group do
    gid gid
    not_if "grep #{app_group} /etc/group"
  end

  user app_user do
    shell "/bin/bash"
    group app_group
    uid uid
    home node.apps[:location]
    manage_home true
    home node.apps.location
    not_if "grep #{app_user} /etc/passwd"
  end
end