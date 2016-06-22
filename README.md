# docker-nginx-piwik
A docker image with nginx and piwik.

## Pull from docker hub

To pull this image from the docker hub, use to following command:

`docker pull auchri/docker-nginx-piwik`

## Building from source

To build from source you need to clone the git repo and run docker build:

```
git clone https://github.com/auchri/docker-nginx-piwik.git
docker build -t auchri/docker-nginx-piwik:latest .
```

## Running

To run the container, you have to provide an mysql server.

`docker run -d --link my-database-host:database --name piwik auchri/docker-nginx-piwik`

After that, you can access piwik on port 80.

## Installation

At the first time you access piwik, you have to enter the database credentials and create an admin user.
use `database` as the mysql host.

## Upgrading

After replacing the container, you have to access the database credentials again. But you can use the existing data, so you don't need to set everything again.
