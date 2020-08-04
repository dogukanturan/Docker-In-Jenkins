# Docker in Jenkins (in Docker)


Jenkins'i Docker araclığı ile container olarak çalıştıran ve çalıştığı docker sunucusuna, docker socket ve compose'u bağlayan docker-compose file.  


## Gereksinimler

Belirtilen docker container'ının çalıştırılması için gerekenler;

- Docker
- Docker Compose


## Kullanım | TL;DR 

    $ docker run -d --name jenkins-on-docker -p 8080:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker -v /usr/local/bin/docker-compose:/usr/local/bin/docker-compose -v jenkins-data:/var/jenkins_home -v jenkins-docker-certs:/certs/client dturan/jenkins-on-docker:latest

Jenkins'i ayağa kaldırmak için projenin bulunduğu adrese terminal ile bağlanıp, aşağıdaki docker komutunun çalıştırılması gerekmektedir.

    $ docker-compose up -d
    
Jenkins image sisteminizde yoksa ilk başlatmada biraz zaman alabilir daha sonra container'ın ayakta olup olmadığını yine aynı dizinde aşağıdaki komut ile kontrol edebilirsiniz.

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
