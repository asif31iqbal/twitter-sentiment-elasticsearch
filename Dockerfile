# start with a base image
FROM ubuntu:14.04

MAINTAINER Greg Martin <gregcmartin@gmail.com>

# initial update
RUN apt-get clean -q
RUN apt-get update -q
# install wget, java, and mini-httpd web server
RUN apt-get install -yq wget
RUN apt-get install -yq default-jre-headless
#RUN apt-get install -yq mini-httpd

# install elasticsearch
RUN cd /tmp && \
    wget -nv https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.0.0/elasticsearch-2.0.0.tar.gz && \
    tar zxf elasticsearch-2.0.0.tar.gz && \
    rm -f elasticsearch-2.0.0.tar.gz && \
    mv /tmp/elasticsearch-2.0.0 /opt/elasticsearch

# install kibana
RUN cd /tmp && \
    wget -nv https://download.elastic.co/kibana/kibana/kibana-4.1.2-linux-x64.tar.gz && \
    tar zxf kibana-4.1.2-linux-x64.tar.gz && \
    rm -f kibana-4.1.2-linux-x64.tar.gz && \
    mv /tmp/kibana-4.1.2-linux-x64 /opt/kibana


# start elasticsearch
CMD /opt/elasticsearch/bin/elasticsearch & /opt/kibana/bin/kibana

# expose ports
EXPOSE 9200 5601
