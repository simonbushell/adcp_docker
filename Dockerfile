FROM alpine:3.15

RUN apk add --no-cache \
    tar \
    vim \
    libstdc++ \
    libsm-dev \
    libxrender \
    libxext-dev \
    libxml2 \
    libgomp \
    gzip \
    gcompat \
    python2 \
    wget \
    bash

WORKDIR /tmp

# ADD ADFRsuite_x86_64Linux_1.0.tar.gz /tmp/ 
# TODO: Move all these files to subdirectory
RUN wget https://ccsb.scripps.edu/adfr/download/1038/ -O /tmp/ADFRsuite_x86_64Linux_1.0.tar.gz 
RUN tar -xzvf /tmp/ADFRsuite_x86_64Linux_1.0.tar.gz
RUN wget https://raw.githubusercontent.com/simonbushell/adfr_docker/main/tmpinstall.dat
RUN wget https://ccsb.scripps.edu/adcp/download/1063/ -O /tmp/ADCP_tutorial_data.zip
RUN unzip /tmp/ADCP_tutorial_data.zip -d /

RUN mv tmpinstall.dat /tmp/ADFRsuite_x86_64Linux_1.0/Tools/install.py

RUN mkdir -p /adfr/

WORKDIR /tmp/ADFRsuite_x86_64Linux_1.0
ADD install.sh /tmp/ADFRsuite_x86_64Linux_1.0

# Make sure install.sh is executable
RUN chmod +x install.sh

# Run the install script
RUN ./install.sh -d /adfr -c 0
WORKDIR /
ENV PATH /adfr/bin:$PATH


