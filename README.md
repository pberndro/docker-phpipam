# phpIPAM Dockerfile

This is a Dockerfile for [phpIPAM](http://phpipam.net/) the open-source web IP address management based on Debian Jessie.
The image runs with apache2 webserver and php5 inside.

It will:

* Install debian jessie as base system.
* Install apache2 and php5 with all required modules.
* Download the latest phpIPAM release from github.com

## Building

```
docker build -t phpipam .
```

## Setup

```
Here are some instructions to setup phpIPAM with the databse
```

## Database

```
The MySQL database is required to run phpIPAM and is not included into the docker image.
todo: config options/file to set database connection params.

```

## Run the image

```
docker run -itd -p 0.0.0.0:8080:80 --name ipam phpipam
...
```
