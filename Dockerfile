FROM ubuntu:16.04

#
# BASE PACKAGES
#
RUN apt-get update && apt-get install -y sudo software-properties-common python-software-properties && rm -rf /var/lib/apt/lists/* && \
    sudo apt-get update && \
    sudo apt-get -y install apt-utils wget curl bzip2 build-essential zlib1g-dev git vim && \
    sudo apt-get -y install zip unzip python python-pip python-crypto python-pycurl

#
# PIP
#
RUN pip install --upgrade pip

#
# WORKDIR, EXPOSE, a.s.o
#
WORKDIR /opt/python/web/
ENV PATH /opt/python/web:$PATH
EXPOSE 8000

#
# RUN
#
CMD ["bash", "/opt/python/web/run.sh"]