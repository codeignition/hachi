Hachi
=====

Instructions
------------

1. Setup for Development (Mac OS X)
  - Clone the repository
  - Install Ruby 2.2.3 - [See instructions to install Ruby using RVM](https://rvm.io/rvm/install)
  - Install vagrant
    Install `vagrant` by following installation instructions at http://docs.vagrantup.com/v2/installation/

    Once vagrant is installed, add the ubuntu14 box by running following command

    ```
    vagrant box add ubuntu14 http://cloud-images.ubuntu.com/vagrant/trusty/trusty-server-cloudimg-amd64-juju-vagrant-disk1.box
    ```
    Doing `vagrant up` should bring up your dev environment`

2. Auth Flow
  - Register the Seed User as follows:
    - Visit `https://192.168.33.10/`
    - Click on `Register`
    - In the `email field`, enter the email as `seed_user@example.com` and click on `Sign Up`
    - In order to register the user, use the link confirmation email from the development logs
      - ssh into the vagrant machine using `vagrant ssh hachi_auth_provider`
      - `cd` into Hachi Directory using `cd /home/vagrant/hachi`
      - see the logs using `tail -100f log/development.log`
      in order to get the authorization code
  - Get the authorization code as follows:
    - Visit `https://192.168.33.10/oauth/authorize?client_id=seed_test_app&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code`
    - Click on `Authorize`
    - Fetch the Authorization Code

  - Fetch the access token for the Seed User using the following command

    ```
    curl -k  -F grant_type=authorization_code \
             -F client_id=seed_test_app \
             -F client_secret=seed_test_app \
             -F code=4543dede2419bf6f784eda156ef7d44f1a85fd42c54e0c3662459bce352a471c \
             -F redirect_uri=urn:ietf:wg:oauth:2.0:oob \
             -X POST https://192.168.33.10/oauth/token
    ```

  - Gain access to the resource server using the following command
    ```
    curl 192.168.33.11 -H 'Authorization: Bearer replace_your_access_token_here_without_quotes'
    ```