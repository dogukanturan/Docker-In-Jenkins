# Docker in Jenkins (in Docker)


Docker-compose file that installs jenkins running on docker and allows us to connect to docker with those jenkins via socket.

## Prerequisites
- Docker 
- Docker Compose

## Usage | TL;DR 

    $ docker run -d --name jenkins-on-docker -p 8080:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker -v /usr/local/bin/docker-compose:/usr/local/bin/docker-compose -v jenkins-data:/var/jenkins_home -v jenkins-docker-certs:/certs/client dturan/jenkins-on-docker:latest

To run the container, you need to enter the command below into your terminal.
    $ docker-compose up -d
    
If the Jenkins image is not on your system, it may take some time to run the container for the first time. Then, you can check whether the container is up or not with the following command in the same directory.
    $ docker-compose ps

## Dockerfile

    FROM jenkins/jenkins:lts
    LABEL MAINTAINER Dogukan Turan <turandogu@outlook.com>
    USER root
    RUN apt-get -y update
    RUN apt-get -y install \
        vim \
        nano \
        iputils-ping
    RUN rm -rf /var/lib/apt/lists/*

## docker-compose.yml

    version: '3.8'
    services:
      jenkins:
        build:
          context: ./
          dockerfile: Dockerfile
        ports:
          - 8080:8080
          - 50000:50000
        volumes:
          - /var/run/docker.sock:/var/run/docker.sock
          - /usr/bin/docker:/usr/bin/docker
          - /usr/local/bin/docker-compose:/usr/local/bin/docker-compose
          - jenkins-data:/var/jenkins_home
          - jenkins-docker-certs:/certs/client
        container_name: jenkins-on-docker
    volumes:
      jenkins-data:
      jenkins-docker-certs:
