# EiffelStudio IDE in a Docker container

## About

This container is available [in the Docker Index](https://index.docker.io/u/jumanjiman/eiffelstudio/).

In order to use `jumanjiman/eiffelstudio`,
you need to have Docker [installed on your machine](http://www.docker.io/gettingstarted/#anchor-0).

In this container:

- EiffelStudio 7.3 (GPL version) from http://www.eiffelstudio.com/
- Fedora 20 base image from https://index.docker.io/u/mattdm/fedora/
- A modern version of Git
- [tito](https://github.com/dgoodwin/tito) for building RPMs
- All dependencies needed for the above to be self-sufficient

This Docker container enables you to safely experiment with
EiffelStudio in an isolated environment that does not
impact the packages on your host. The container is completely
self-sufficient and isolated from your host OS. You can
[throw away the container](https://github.com/jumanjiman/docker-eiffelstudio/tree/readme#cleanup)
when you're done experimenting.

I built this container so that I can quickly build
[wd](https://github.com/jumanjiman/wd) on any host that has Docker installed.

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

## Known issues

### Why does this Git repo include a tarball of EiffelStudio?

One can use `apt-get` to install the GPL version of EiffelStudio on
Ubuntu (see http://www.eiffelroom.org/article/installing_eiffelstudio_on_ubuntu),
but there is currently no curlable way to retrieve the bits on Fedora.
IOW, I had to manually grab the tarball at the moment.
If you have a better approach, please let me know via a
[new issue](https://github.com/jumanjiman/docker-eiffelstudio/issues/new)
or a pull request.

### I see an error when starting the container

When I run the container, I get this error:

    lxc-start: No such file or directory - stat(/proc/<pid>/root/dev//console)

I don't know yet why this appears, but it seems to have
no effect on the container itself.

## License

The version of EiffelStudio in this container is GPL (unspecified variant).
See LICENSE.eiffelstudio in this repo for governance.

**Note**: If you compile source code with this container,
your binaries include GPL code and therefore are licensed under the GPL.
If you want your binaries to have any other license,
purchase a commercial license for EiffelStudio from http://eiffel.com.

All other files in this Git repo are licensed under the MIT license.
That means you can use this Dockerfile and scripts to
create a private container with
your commercially-licensed copy of EiffelStudio.
See LICENSE.mit in this repo for governance.
