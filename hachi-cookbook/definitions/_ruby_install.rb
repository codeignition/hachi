define :ruby_install do
  directory "/opt/deb_packages" do
    mode 00755
  end

  # remote_file "/opt/deb_packages/ruby-#{params[:version]}.deb" do
  #   source "/vagrant/ruby-#{params[:version]}.deb"
  #   mode '0755'
  #   action :create
  # end
  dpkg_package "ruby" do
    source "/vagrant/ruby-#{params[:version]}.deb"
    action :install
  end
end
