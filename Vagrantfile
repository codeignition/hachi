hachi_script = <<SCRIPT
sudo su vagrant
sudo apt-get install -y git-core build-essential sqlite3 libsqlite3-dev autoconf node nginx
git clone https://github.com/rbenv/rbenv.git /home/vagrant/.rbenv
echo 'export PATH="/home/vagrant/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source /home/vagrant/.bashrc
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install 2.2.3
rbenv global 2.2.3
export PATH=/home/vagrant/.rbenv/versions/2.2.3/bin:$PATH;
gem install bundler
gem install foreman
cd /home/vagrant
git clone https://github.com/codeignition/hachi.git && cd /home/vagrant/hachi
mkdir -p shared/log shared/pids shared/sockets
bundle install
bundle exec rake db:drop db:migrate
bundle exec rake assets:precompile
sudo mkdir -p /etc/nginx/ssl/
sudo cp -r /vagrant/vagrant_config/nginx* /etc/nginx/ssl/
sudo cp -r /vagrant/vagrant_config/default /etc/nginx/sites-enabled/
ps ax | grep studio | awk '{print $1}' | xargs -n1 kill
RAILS_ENV=development foreman start &
sudo service nginx restart
SCRIPT

Vagrant.configure(2) do |config|
    config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
end
  config.vm.define 'hachi' do |hachi|
    hachi.ssh.insert_key = 'true'
    hachi.vm.box = "opscode-ubuntu-14.04"
    hachi.vm.provision "shell", inline: hachi_script, privileged: false
    hachi.vm.network "forwarded_port", guest: 80, host: 8081
    hachi.vm.network "forwarded_port", guest: 443, host: 8082
    hachi.vm.network "private_network", ip: "192.168.33.10"
  end
end

