define :_install_deb do

  app_name           = params[:name]
  init_service       = params[:init_service]
  temp_file_location = Chef::Config[:file_cache_path]
  artifact_name      = app_name.gsub("_","-")

  _get_artifact_version app_name do
    artifact_name artifact_name
  end

  build_number = node[app_name]["version"]
  latest_deb_location = "http://#{node[:source_uri]}/#{artifact_name}/#{artifact_name}_#{build_number}_all.deb"

  remote_file "#{temp_file_location}/#{artifact_name}_#{build_number}_all.deb" do
    source latest_deb_location
    not_if "dpkg -s #{artifact_name} | grep Version| grep #{build_number}"
  end

  dpkg_package "#{artifact_name}_remove" do
    package_name artifact_name
    action :remove
    not_if "dpkg -s #{artifact_name} | grep Version| grep #{build_number}"
  end

  dpkg_package "#{artifact_name}_install" do
    package_name artifact_name
    source "#{temp_file_location}/#{artifact_name}_#{build_number}_all.deb"
    not_if "dpkg -s #{artifact_name} | grep Version| grep #{build_number}"
    notifies :restart, "service[#{init_service}]", :delayed
  end

  execute 'remove deb files' do
    command "rm -rf #{temp_file_location}/#{artifact_name}_#{build_number}_all.deb"
  end
end