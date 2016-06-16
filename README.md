[![Build Status](https://travis-ci.org/decomplect-io/docker-rails-development.svg?branch=master)](https://travis-ci.org/decomplect-io/docker-rails-development)
# Supported tags and respective `Dockerfile` links

-	[`v0.0.1` (*v0.0.1/Dockerfile*)](https://github.com/decomplect-io/docker-rails-development/blob/v0.0.1/Dockerfile)
-	[`v0.0.1-postgresql` (*v0.0.1-postgresql/Dockerfile*)](https://github.com/decomplect-io/docker-rails-development/blob/v0.0.1-postgresql/Dockerfile)

# Docker container for Rails development

- Based on Ubunty trusty (14.04) docker image
- Installs Ruby 2.3 and Nodejs 6.x
- Creates a user called rails
- Sets up a volume at /home/rails/app where you can point your app
- Any service such as PostgreSQL or Redis is expected to be linked. No services are installed in this container.

# Using this container with Docker Compose on a Rails + Postgresql application:

- Define a `docker-compose.yml` file in the root directory of your rails application:

```yml
version: '2'
services:
  db:
    image: postgres
    environment:
      - POSTGRES_PASSWORD=postgres
  web:
    image: decomplect/rails-development:v0.0.1-postgresql
    environment:
      - DATABASE_URL=postgresql://postgres:postgres@db/sample-rails-docker_development
      - TEST_DATABASE_URL=postgresql://postgres:postgres@db/sample-rails-docker_test
      - RAILS_ENV=development
    command: bundle install && bundle exec rails s -p 3000 -b '0.0.0.0'
    volumes:
      - .:/home/rails/app
    ports:
      - "3000:3000"
    depends_on:
      - db
```

- Define a `config/database.yml` like so:

```yml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: 5

development:
  <<: *default
  database: sample-rails-docker_development
  url: <%= ENV['DATABASE_URL'] %>

test:
  <<: *default
  database: sample-rails-docker_test
  url: <%= ENV['TEST_DATABASE_URL'] %>
```

-  Run `docker-compose up`.

- Run the following init commands in the context of the `web` container:

```bash
$ docker-compose exec web bundle exec rake db:create db:migrate
```

- That's it. The app should be running now!

# License

MIT License

Copyright (c) 2016-Present Decomplect Software LLP

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
