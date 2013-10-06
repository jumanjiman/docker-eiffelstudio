#!/bin/bash

# EiffelStudio needs environment variables.
source /etc/profile.d/eiffelstudio.sh

# You can run this container like:
# docker run -i -t -e HOME=/home/<username> -v /home:/home jumanjiman/docker-eiffelstudio 
[[ -n $HOME ]] || export HOME=/tmp/
cd $HOME

# Start an interactive bash session.
/bin/bash -i -l
