package 'apache2'
package 'libhiredis0.10'
package 'libcurl3'
package 'libjansson4'

remote_file '/home/vagrant/libapache2-mod-auth-openidc_1.8.7-1ubuntu1.trusty.1_amd64.deb' do
  source 'https://github.com/pingidentity/mod_auth_openidc/releases/download/v1.8.7/libapache2-mod-auth-openidc_1.8.7-1ubuntu1.trusty.1_amd64.deb'
  owner 'vagrant'
  group 'vagrant'
  action :create
end

dpkg_package 'mod-auth-openidc' do
  package_name 'mod-auth-openidc'
  provider Chef::Provider::Package::Dpkg
  source '/home/vagrant/libapache2-mod-auth-openidc_1.8.7-1ubuntu1.trusty.1_amd64.deb'
end
