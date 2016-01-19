Hachi
=====

Instructions
------------

1. Setup for Development and Checking the Auth Flow (Mac OS X)
  - Clone the repository
  - Install Ruby 2.2.3 - [See instructions to install Ruby using RVM](https://rvm.io/rvm/install)
  - Install vagrant
    Install `vagrant` by following installation instructions at http://docs.vagrantup.com/v2/installation/

    Once vagrant is installed, Run the following command

    ```
    vagrant up
    ```
    Doing `vagrant up` should bring up your environment for testing the auth flow`

2. Auth Flow
  - Register the Seed User as follows:
    - Visit `https://192.168.33.10/`
    - Click on `Register`
    - In the `email field`, enter the email as `seed_user@example.com` and click on `Sign Up`
    - In order to register the user, use the link confirmation email from the development logs
      `tail -100f logs/development.log`
      to get the authorization code
  - Fetch the access token for the Seed User using the following command

    ```
    curl -k  -F grant_type=authorization_code \
             -F client_id=seed_test_app \
             -F client_secret=seed_test_app \
             -F code=replace_your_authorization_code_here \
             -F redirect_uri=urn:ietf:wg:oauth:2.0:oob \
             -X POST https://192.168.33.10/oauth/token
    ```

  - Gain access to the resource server using the following command
    ```
    curl 192.168.33.11 -H 'Authorization: Bearer replace_your_access_token_here_without_quotes'
    ```
    This will display the index.html hosted and protected behind apache server
