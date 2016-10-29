FROM ubuntu

MAINTAINER Yannic Wilkening

RUN mkdir ~/.ssh
RUN touch ~/.ssh/known_hosts
RUN chmod 600 ~/.ssh/known_hosts

RUN mkdir ~/test
ADD ./id_rsa ~/test/
RUN cat ~/test/id_rsa

ADD ./id_rsa .ssh/
RUN ls -l ~/.ssh/
RUN chmod 600 ~/.ssh/id_rsa

RUN apt-get update && apt-get install -y \
  nodejs \
  build-essential \
  git

RUN ssh-keyscan iot.iavtech.net >> ~/.ssh/known_hosts
RUN git clone git@iot.iavtech.net:smartParking

RUN rm -rf ~/.ssh/id_rsa

RUN npm install ~/smartParking/01_Crossbar 

EXPOSE 8080