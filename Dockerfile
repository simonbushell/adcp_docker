FROM alpine:3.15

# Install necessary packages
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
    bash

WORKDIR /tmp

# Add your tar file to the container
ADD ADFRsuite_x86_64Linux_1.0.tar.gz /tmp/
ADD tmpinstall.dat /tmp
ADD ADCP_tutorial_data.zip /tmp
RUN unzip /tmp/ADCP_tutorial_data.zip -d /

RUN mv tmpinstall.dat /tmp/ADFRsuite_x86_64Linux_1.0/Tools/install.py



# Create directory where the software will be installed
RUN mkdir -p /adcp/

#Extract the tar file
#RUN tar -xzvf ./ADFRsuite_x86_64Linux_1.0.tar.gz

# Assuming the directory created by tar extraction is named ADFRsuite_x86_64Linux_1.0
# Adjust if the actual directory name differs
WORKDIR /tmp/ADFRsuite_x86_64Linux_1.0
ADD ./ADFRsuite_x86_64Linux_1.0/install.sh /tmp/ADFRsuite_x86_64Linux_1.0

# Make sure install.sh is executable
RUN chmod +x install.sh

# Run the install script
RUN ./install.sh -d /adcp -c 0
WORKDIR /adcp
ENV PATH /adcp/bin:$PATH


