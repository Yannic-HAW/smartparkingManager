FROM ubuntu

MAINTAINER Yannic Wilkening

RUN apt-get update && apt-get install -y \
  nodejs \
  npm \
  build-essential \
  git

RUN mkdir /root/.ssh
RUN touch /root/.ssh/known_hosts
RUN chmod 600 /root/.ssh/known_hosts

ADD ./id_rsa /root/.ssh/
RUN chmod 600 /root/.ssh/id_rsa

RUN ssh-keyscan iot.iavtech.net >> /root/.ssh/known_hosts
RUN git clone git@iot.iavtech.net:smartParking

RUN rm -rf /root/.ssh/id_rsa

RUN ls -l */
RUN cd */smartParking/01_Crossbar; npm install;

WORKDIR */smartParking/01_Crossbar
CMD ["npm", "start"]

EXPOSE 8080