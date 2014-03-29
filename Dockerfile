FROM ubuntu:12.04

MAINTAINER Tyler Hall <tylerwhall@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y openjdk-6-jre-headless git-core vim-tiny curl

ENV GERRIT_HOME /home/gerrit

RUN useradd -m gerrit
USER gerrit
RUN curl http://gerrit-releases.storage.googleapis.com/gerrit-2.8.3.war -o $GERRIT_HOME/gerrit.war
RUN java -jar $GERRIT_HOME/gerrit.war init --batch -d $GERRIT_HOME
ADD start-gerrit.sh $GERRIT_HOME/start-gerrit.sh
VOLUME ["/home/gerrit"]

EXPOSE 8080 29418
CMD ["/home/gerrit/start-gerrit.sh"]
