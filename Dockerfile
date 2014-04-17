# EiffelStudio on Fedora
# http://www.eiffelstudio.com/

# https://index.docker.io/u/mattdm/fedora/
FROM mattdm/fedora:f20

# http://jumanjiman.github.io/
MAINTAINER Paul Morgan

# Update the base image.
#RUN yum -y update

# Work around https://bugzilla.redhat.com/show_bug.cgi?id=1066983
RUN yum -y remove vim-minimal; yum clean all

# Install compiler collection and debugger.
# Install RPM development tools.
# https://github.com/dgoodwin/tito
RUN yum -y install gcc gdb tito git vim-enhanced bash-completion \
    which tar \
    ; yum clean all

# Install EiffelStudio dependencies.
RUN yum -y install gtk2-devel.x86_64 libXtst-devel.x86_64 pangox-compat; yum clean all

# Install EiffelStudio.
# http://docs.eiffel.com/book/eiffelstudio/eiffelstudio-linux
ADD profile.d /etc/profile.d/
ADD start.sh  /usr/local/bin/
ADD http://ftp.eiffel.com/pub/download/13.11/Eiffel_13.11_gpl_93542-linux-x86-64.tar.bz2 /tmp/
RUN tar xvjf /tmp/Eiffel_13.11_gpl_93542-linux-x86-64.tar.bz2 -C /usr/local/
RUN rm -f /tmp/Eiffel_13.11_gpl_93542-linux-x86-64.tar.bz2

# Use an unprivileged user inside the container.
RUN useradd eiffel
USER eiffel

# Start in /tmp by default.
ENV HOME /tmp
WORKDIR /tmp

# Export environment variables for EiffelStudio
# and start bash.
ENTRYPOINT /usr/local/bin/start.sh
