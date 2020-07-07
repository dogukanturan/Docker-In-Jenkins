FROM  jenkins/jenkins:lts
MAINTAINER Dogukan Turan <turandogu@outlook.com>
USER root

RUN apt-get update -y && \
    apt-get -y install apt-transport-https \     
    ca-certificates \     
    apt-utils \
    curl \     
    vim \ 
    nano \
    gnupg2 \     
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \   
        "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
        $(lsb_release -cs) \
        stable"

RUN apt-get update && \
    apt-get -y install docker-ce
    
RUN curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/    local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
RUN groupadd -g 999 docker
RUN usermod -aG staff,docker jenkins

USER jenkins

EXPOSE 8080