Hachi
=====

Instructions
------------

1. Setup for Development (Mac OS X)
 - Clone the repository
 - Install Ruby 2.2 - [See instructions to install Ruby using RVM](https://rvm.io/rvm/install)
 - Install the dependencies using the following command

   ```
   bundle install
   ```
 - Run the migrations using the following command

   ```
   rake db:migrate
   ```

2. Running tests
   - Ensure that you have the development environment setup - See Step 1
   - Run the specs by using the following command

     ```
     bundle exec rake
     ```

3. To run the application, use the following command

    ```
    bundle exec rails server
    ```
