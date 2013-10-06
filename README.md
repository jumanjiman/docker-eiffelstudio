# EiffelStudio IDE inside a Fedora container

## About

This container is available [in the Docker Index](https://index.docker.io/u/jumanjiman/eiffelstudio/).

In order to use `jumanjiman/eiffelstudio`,
you need to have Docker [installed on your machine](http://www.docker.io/gettingstarted/#anchor-0).

In this container:

- EiffelStudio 7.3 GPL  http://www.eiffelstudio.com/
- Fedora 19 base image is from https://index.docker.io/u/mattdm/fedora/

## Recommended usage

Run the container interactively, mounting `/tmp`
from your host OS insider the container at `/tmp`. The mount
ensures that any work you do inside the container is available
in the host OS.

`docker run -i -t -v /tmp:/tmp jumanjiman/eiffelstudio`

## Cleanup

To throw away this container, run:

    docker rmi jumanjiman/eiffelstudio

To throw away cached copies of containers you no longer use:

    docker rm $(docker ps -a -q)

## To-do

Extend the Dockerfile to create an Ubuntu image based on instructions
at http://www.eiffelroom.org/article/installing_eiffelstudio_on_ubuntu

## License

GPL. See LICENSE in this repo.
