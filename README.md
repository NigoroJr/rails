# README

## Setting up the environment

* Create config/initializers/secret_token.rb with the following content

        Nigorojr::Application.config.secret_key_base = 'SECRET_TOKEN'

    where SECRET_TOKEN is the key generated by

        rake secret

* Add users to database and create appropriate file stated in `database.yml`
  that contains the password
