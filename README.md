# docker-nginx-matomo
A docker image with nginx and [Matomo](https://matomo.org/).

## Pull from docker hub

To pull this image from the [docker hub](https://hub.docker.com/r/auchri/docker-nginx-matomo/), use to following command:

`docker pull auchri/docker-nginx-matomo`

## Building from source

To build from source you need to clone the git repo and run docker build:

```
git clone https://github.com/auchri/docker-nginx-matomo.git
docker build -t auchri/docker-nginx-matomo:latest .
```

## Running

To run the container with docker-compose, create a `docker-compose.yml` with the following content:

```
version: '3.7'

volumes:
  matomo_database_data:

services:
  matomo_database:
    image: mariadb
    restart: unless-stopped
    volumes:
      - matomo_database_data:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=your-secret-root-password
      - MYSQL_PASSWORD=your-secret-password
      - MYSQL_DATABASE=matomo
      - MYSQL_USER=matomo

  matomo:
    image: auchri/docker-nginx-matomo
    restart: unless-stopped
    ports:
      - '80:80'
```

and execute `docker-compose up -d` on the same folder as the docker-compose-file is.

After that, you can access Matomo on port 80.

### Installation

At the first time you access Matomo, you have to enter the database credentials and create an admin user.
Use `matomo_database` as mysql host, `matomo` as database username and name and use `your-secret-password` as the database password.

## Upgrading

After replacing the container, you have to access the database credentials again. But you can use the existing data, so you don't need to set everything up again.
