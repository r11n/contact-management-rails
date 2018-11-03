# Contact Management System

Users can sign-up using company emails(only domains allowed by admin eg: if `company1.com`, `company2.com` are the allowed domains then users can only sign-up with those domains only). Users can create groups to manage contacts with support to alter the status of group. User can create any number of contacts with in group.

## Setup instructions

- make sure `postgresql` is insalled in your system and running.

- Run bundler `bundle install`.

- create `database.yml` in `config` folder enter your credentials and database configuration.
  - sample configuration

  ```yml
  default: &default
    adapter: postgresql
    encoding: unicode
    username: db_username
    password: db_password
    pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

  development:
    <<: *default
    database: contact-management_development

  test:
    <<: *default
    database: contact-management_test

  production:
    <<: *default
    database: contact-management_production
    username: contact-management
    password: <%= ENV['CONTACT-MANAGEMENT_DATABASE_PASSWORD'] %>
  ```

- Run `rails db:create` or `rake db:create` to create database.
- Run `rails db:migrate` or `rake db:migrate` to complete any pending migrations.
-  Run `rails db:seed` or `rake db:seed` to seed the database with a sample admin user in order to create allowed domains.

## Version information

- Rails `5.2.1`