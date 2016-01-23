FROM       hasufell/gentoo-amd64-paludis:latest
MAINTAINER Julian Ospald <hasufell@gentoo.org>


##### PACKAGE INSTALLATION #####

# copy paludis config
COPY ./config/paludis /etc/paludis

# install java set
COPY jdk-8u72-linux-x64.tar.gz /usr/portage/distfiles/
RUN chgrp paludisbuild /dev/tty && cave resolve -c java \
	-F dev-java/oracle-jdk-bin -x

# update world with our USE flags
RUN chgrp paludisbuild /dev/tty && cave resolve -c world -x

# update etc files... hope this doesn't screw up
RUN etc-update --automode -5

################################

