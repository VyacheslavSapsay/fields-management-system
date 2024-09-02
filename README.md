# FieldsManagementSystem

This is a Rails-7/Ruby-3.3.4 app.

### Running app with Docker

1. `docker compose build`
2. `docker compose up`
3. `docker compose run rails rails db:create`
4. `docker compose run rails rails db:migrate`

Access the app at <http://localhost:3000/>.

## Running test

1. `docker compose up`
1. `docker compose run rails rails db:create RAILS_ENV=test`
1. `docker compose run rails rails db:migrate RAILS_ENV=test`
1. `docker compose run rails rspec`

## Check rubocop linter:

1. `docker compose run rails rubocop`
