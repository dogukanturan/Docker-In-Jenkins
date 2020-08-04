FROM  jenkins/jenkins:lts

LABEL MAINTAINER Dogukan Turan <turandogu@outlook.com>

USER root

RUN apt-get -y update
    
RUN apt-get -y install \
    vim \ 
    nano \
    iputils-ping

RUN rm -rf /var/lib/apt/lists/*