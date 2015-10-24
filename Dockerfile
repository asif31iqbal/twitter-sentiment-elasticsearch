# start with a base image
FROM ubuntu:14.04

MAINTAINER Greg Martin <gregcmartin@gmail.com>

# initial update
RUN apt-get clean -q
RUN apt-get update -q

# install wget, java, and mini-httpd web server
RUN apt-get install -yq wget
RUN apt-get install -yq default-jre-headless
RUN apt-get install -yq mini-httpd

# install elasticsearch
RUN cd /tmp && \
    wget -nv https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.3.tar.gz && \
    tar zxf elasticsearch-1.7.3.tar.gz && \
    rm -f elasticsearch-1.7.3.tar.gz && \
    mv /tmp/elasticsearch-1.7.3 /opt/elasticsearch

# install kibana
RUN cd /tmp && \
    wget -nv https://download.elastic.co/kibana/kibana/kibana-4.1.2-linux-x64.tar.gz && \
    tar zxf kibana-4.1.2-linux-x64.tar.gz && \
    rm -f kibana-4.1.2-linux-x64.tar.gz && \
    mv /tmp/kibana-4.1.2-linux-x64 /opt/kibana
    

# start elasticsearch
CMD /opt/elasticsearch/bin/elasticsearch -Des.logger.level=OFF & /opt/kibana

# expose ports
EXPOSE 5601
