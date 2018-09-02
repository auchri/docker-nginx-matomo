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

To run the container with docker-compose:

TODO: Insert docker-compose example file here

After that, you can access piwik on port 80.

## Installation

At the first time you access piwik, you have to enter the database credentials and create an admin user.
use `database` as the mysql host.
use `piwik` as database-name, db_username and db_password

## Upgrading

After replacing the container, you have to access the database credentials again. But you can use the existing data, so you don't need to set everything up again.
