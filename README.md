## Docker container for Rails development

- Inherits from [2.2-slim](https://github.com/docker-library/ruby/blob/a6202f065bc6d5562703eed454e3479359234750/2.2/slim/Dockerfile)
- Install nodejs 6.x and build-essential
- Creates a user called rails
- Sets up a volume at /home/rails/app where you can point your app
- Any service such as PostgreSQL or Redis is expected to be linked. No services are installed in this container.

## TODO

- Example of usage