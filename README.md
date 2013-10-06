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

## Inspection

After you enter the container using the `docker run ...` command above,
you can look around at the environment.

Who are you inside the container?

    bash-4.2$ whoami
    eiffel

    bash-4.2$ getent passwd eiffel
    eiffel:x:1000:1000::/home/eiffel:/bin/bash

What directory are you in?

    bash-4.2$ pwd
    /tmp

    bash-4.2$ echo $HOME
    /tmp

Why `/tmp`? Why the `eiffel` user?

* One should never compile code as root, so
  the `eiffel` user provides an unprivileged account.

* You cannot use your own account inside the container
  because the user accounts *inside* a container are
  completely different (isolated) from your host accounts.

* If you use the Fedora version of this container,
  you probably want to use the tooling to build RPMs.
  `rpmbuild` creates files and directories in the location
  specified by the `%{_topdir}` macro, which is `$HOME`
  by default:

  ```
  bash-4.2$ grep -i home /usr/lib/rpm/macros
  %_topdir                %{getenv:HOME}/rpmbuild
  ```

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
