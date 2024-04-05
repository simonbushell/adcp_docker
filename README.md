# ADCP Docker
### Introduction
[Autodock Crankpep (ADCP)](https://ccsb.scripps.edu/adcp/) is an *in silico* peptide docking engine for the popular [Autodock](https://autodock.scripps.edu/) suite. ADCP is somewhat deprecated and difficult to install on modern systems, not least because it isn't Python 3 compatible, but remains a very useful, open and scalable tool for *in silico* peptide screening. This repository contains the necessary files that I used to build a Docker container which contains a fully working implementation of ADCP.

The container itself can be pulled from Dockerhub at [https://hub.docker.com/r/simonbushell/adcp_docker](https://hub.docker.com/r/simonbushell/adcp_docker)

This container can be run interactively using data files on mounted volumes. To mount the current directory and run the container (Mac OS and *nix systems):

```
docker run -it -v $(PWD):/data simonbushell/adcp_docker:v1.0 bash
```
This will open up an interactive bash shell within the container with your current directory mounted at /data. The container also contains the [ADCP tutorial files](https://ccsb.scripps.edu/adcp/download/1063/) at ```/ADCP_tutorial_data```

This repository also contains a docker-compose file where the volume can be stated explicitly. Edit the ```docker-compose.yml``` to include your desired volume (ie. under ```volumes```). Run the following comand in the same directory as the ```docker-compose.yml``` file
```
docker-compose run --service-ports myapp bash
```

### Building 
If you wish to build your own copy of this container, run the following in the same directory as the Dockerfile. This directory will also need to contain a zip copy of the tutorial files ([ADCP_tutorial_data.zip](https://ccsb.scripps.edu/adcp/download/1063/)), and the ```tmpinstall.dat``` file, to build properly.
```
docker build -t your-image-name .
```
```tmpinstall.dat``` is a modified form of the install.py file for ADFR. It removes the prompt where it asks whether it asks the user to choose between the ACADEMIC or COMMERCIAL version of ADFR (some components of ADFR require a licence for commerical use). This prompt causes issues duing the container build process, and so will install the **academic** version (which contains the MSMS component for molecular surface calculation) as default. Please ensure you obtain a licence if you are using in a commercial setting. 
