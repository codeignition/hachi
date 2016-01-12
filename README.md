Hachi
=====

Instructions
------------

1. Setup for Development (Mac OS X)
 - Clone the repository
 - Install Ruby 2.2.3 - [See instructions to install Ruby using RVM](https://rvm.io/rvm/install)
 - Install the dependencies using the following command

   ```
   bundle install
   ```
 - Run the migrations using the following command

   ```
   rake db:migrate
   ```
  - Install vagrant
    Install `vagrant` by following installation instructions at http://docs.vagrantup.com/v2/installation/

    Once vagrant is installed, add the ubuntu14 box by running following command

    ```
    vagrant box add ubuntu14 http://cloud-images.ubuntu.com/vagrant/trusty/trusty-server-cloudimg-amd64-juju-vagrant-disk1.box
    ```
    Doing `vagrant up` should bring up your dev environment.
  - ssh into the vagrant box by running `vagrant ssh`
  - Install apache2 using the following command

    ```
    sudo apt-get install apache2
    ```
  - Download and install `mod-auth-openidc 1.8.7` for Ubuntu 14.04 Trusty

    ```
    wget https://github.com/pingidentity/mod_auth_openidc/releases/download/v1.8.7/libapache2-mod-auth-openidc_1.8.7-1ubuntu1.trusty.1_amd64.deb
    sudo dpkg -i libapache2-mod-auth-openidc_1.8.7-1ubuntu1.trusty.1_amd64.deb
    sudo a2enmod auth_openidc
    sudo service apache2 restart
    ```
  - Edit the `auth_openidc.conf` configuration file located in `/etc/apache2/mods-enabled` directory.
    Note: replace the corresponding values with what you have obtained 

    ```
    OIDCOAuthClientID ce3c8b2228c8f2dcd2bac6efbc31b5644b39c676eabe6bec04c93a49a9fc6154
    OIDCOAuthClientSecret 1c6c19ba03edb81f6a69ef4f4522e35adf066691b730ee9cff4a33e1f7c15d89
    OIDCOAuthIntrospectionEndpoint https://<hachi-rails-server-ip-address>:<port>/oauth/token/info
    OIDCOAuthIntrospectionEndpointMethod GET
    OIDCOAuthRemoteUserClaim    resource_owner_id
    OIDCOAuthTokenExpiryClaim expires_in_seconds
    OIDCOAuthSSLValidateServer Off
    OIDCOAuthIntrospectionTokenParamName    access_token
    ```
  - Edit the `000-default.conf` configuration file located in `/etc/apache2/sites-enabled` directory

    ```
     <Location />
                Authtype oauth20
                Require valid-user
                LogLevel debug
     </Location>
    ```
2. Running tests
   - Ensure that you have the development environment setup - See Step 1
   - Run the specs by using the following command

     ```
     bundle exec rake
     ```

3. To run the application, use the following command

    ```
    RAILS_SSL=true bin/rails server -b 0.0.0.0 --port=3000
    ```

4. Authorization Flow for mod_auth_openidc
   
   - Register a new client application by visiting the following URL and
     clicking on `New Application` button
    
     ```
     https://localhost:3000/oauth/applications
     ```
   - Obtain the authorization code by clicking on the `Authorize` button
   - Obtain the `access_token` by executing the following command
    
     ```
     curl -F grant_type=authorization_code \
          -F client_id=9b36d8c0db59eff5038aea7a417d73e69aea75b41aac771816d2ef1b3109cc2f \
          -F client_secret=d6ea27703957b69939b8104ed4524595e210cd2e79af587744a7eb6e58f5b3d2 \
          -F code=fd0847dbb559752d932dd3c1ac34ff98d27b11fe2fea5a864f44740cd7919ad0 \
          -F redirect_uri=urn:ietf:wg:oauth:2.0:oob \
          -X POST http://localhost:3000/oauth/token
     ```
     Replace the `client_id`, `client_secret` and `code` with your
corresponding `client_id`, `client_secret` and `authorization_code` obtained
in the last steps
    - Gain access to the resource server using the following command
      
      ```
      curl 192.168.33.10 -H 'Authorization: Bearer 618f34a8a7b312c1b1ad8c5cd9d1313d81185ce9d82acebe9692b65a30bc1014'
      ```
      Replace the access token with the access token that you have
obtained from the last step
