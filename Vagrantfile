hachi_script = <<SCRIPT
sudo su vagrant
sudo apt-get update
sudo apt-get install -y git-core build-essential sqlite3 libsqlite3-dev autoconf node nginx
git clone https://github.com/rbenv/rbenv.git /home/vagrant/.rbenv
echo 'export PATH="/home/vagrant/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source /home/vagrant/.bash_profile
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install 2.2.3
rbenv global 2.2.3
export PATH=/home/vagrant/.rbenv/versions/2.2.3/bin:$PATH;
gem install bundler
gem install foreman
cd /home/vagrant
rm -rf hachi
git clone https://github.com/codeignition/hachi.git
cd /home/vagrant/hachi
mkdir -p shared/log shared/pids shared/sockets
bundle install
bundle exec rake db:drop db:migrate db:seed
bundle exec rake assets:precompile
sudo mkdir -p /etc/nginx/ssl/
sudo cp -r /vagrant/vagrant_config/nginx* /etc/nginx/ssl/
sudo cp -r /vagrant/vagrant_config/default /etc/nginx/sites-enabled/
ps ax | grep puma | awk '{print $1}' | xargs -n1 kill
RAILS_ENV=development foreman start &
sudo service nginx restart
SCRIPT

hachi_resource_server_script = <<SCRIPT
sudo apt-get update
sudo apt-get install -y apache2 libjansson4 libhiredis0.10 libcurl3
wget https://github.com/pingidentity/mod_auth_openidc/releases/download/v1.8.7/libapache2-mod-auth-openidc_1.8.7-1ubuntu1.trusty.1_amd64.deb
sudo dpkg -i libapache2-mod-auth-openidc_1.8.7-1ubuntu1.trusty.1_amd64.deb
sudo a2enmod auth_openidc
sudo service apache2 restart
sudo cp /vagrant/vagrant_config/hachi_resource_server/auth_openidc.conf /etc/apache2/mods-enabled/.
sudo cp /vagrant/vagrant_config/hachi_resource_server/auth_openidc.conf /etc/apache2/mods-enabled/auth_openidc.conf
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  config.vm.define 'hachi_auth_provider' do |hachi_auth_provider|
    hachi_auth_provider.ssh.insert_key = 'true'
    hachi_auth_provider.vm.box = "opscode-ubuntu-14.04"
    hachi_auth_provider.vm.provision "shell", inline: hachi_script, privileged: false
    hachi_auth_provider.vm.network "forwarded_port", guest: 80, host: 8081
    hachi_auth_provider.vm.network "forwarded_port", guest: 443, host: 8082
    hachi_auth_provider.vm.network "private_network", ip: "192.168.33.10"
  end

  config.vm.define 'hachi_resource_server' do |hachi_resource_server|
    hachi_resource_server.ssh.insert_key = 'true'
    hachi_resource_server.vm.box = "opscode-ubuntu-14.04"
    hachi_resource_server.vm.provision "shell", inline: hachi_resource_server_script, privileged: false
    hachi_resource_server.vm.network "forwarded_port", guest: 80, host: 8083
    hachi_resource_server.vm.network "private_network", ip: "192.168.33.11"
  end
end
