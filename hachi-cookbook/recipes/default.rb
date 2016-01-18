#
# Cookbook Name:: hachi
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'apt'
include_recipe 'git::default'

app_user                         = node.apps[:user]
app_group                        = node.apps[:group]

app_environment_variables = {}

git node.apps.location do
  repository "https://github.com/codeignition/hachi.git"
  revision "HEAD"
  action :sync
end

rails_app "hachi" do
  environment_variables app_environment_variables
  init_service "puma"
end


template "#{node.apps[:location]}/hachi/config/secrets.yml" do
  source "apps/secret.yml.erb"
  variables(env_variable: app_environment_variables)
  owner app_user
  group app_group
  notifies :restart, "service[puma]", :delayed
 end
