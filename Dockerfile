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
RUN yum -y install gcc gdb

# Install RPM development tools.
# https://github.com/dgoodwin/tito
RUN yum -y install tito

# Install useful CLI tools.
RUN yum -y install git
RUN yum -y install vim-enhanced
RUN yum -y install bash-completion

# Install EiffelStudio dependencies.
RUN yum -y install gtk2-devel.x86_64
RUN yum -y install libXtst-devel.x86_64
RUN yum -y install pangox-compat

# Install EiffelStudio.
# http://docs.eiffel.com/book/eiffelstudio/eiffelstudio-linux
ADD Eiffel73_gpl_92766-linux-x86-64.tar.bz2 /usr/local/
ADD profile.d /etc/profile.d/
ADD start.sh  /usr/local/bin/

# Remove yum metadata.
RUN yum clean all

# Use an unprivileged user inside the container.
RUN useradd eiffel
USER eiffel

# Start in /tmp by default.
ENV HOME /tmp
WORKDIR /tmp

# Export environment variables for EiffelStudio
# and start bash.
ENTRYPOINT /usr/local/bin/start.sh
