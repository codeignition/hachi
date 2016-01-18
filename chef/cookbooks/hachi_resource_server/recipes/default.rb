package 'apache2'

remote_file '/home/vagrant/libapache2-mod-auth-openidc_1.8.7-1ubuntu1.trusty.1_amd64.deb' do
  source 'https://github.com/pingidentity/mod_auth_openidc/releases/download/v1.8.7/libapache2-mod-auth-openidc_1.8.7-1ubuntu1.trusty.1_amd64.deb'
  owner 'vagrant'
  group 'vagrant'
  action :create
end