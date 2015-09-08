FROM       hasufell/gentoo-amd64-paludis:latest
MAINTAINER Julian Ospald <hasufell@gentoo.org>

# global flags
RUN echo -e "*/* acl bash-completion ipv6 kmod openrc pcre readline unicode \
zlib pam ssl sasl bzip2 urandom crypt tcpd java \
-acpi -cairo -consolekit -cups -dbus -dri -gnome -gnutls -gtk -gtk2 -gtk3 \
-ogg -opengl -pdf -policykit -qt3support -qt5 -qt4 -sdl -sound -systemd \
-truetype -vim -vim-syntax -wayland -X" \
	>> /etc/paludis/use.conf

# per-package flags
# check these with "cave show <package-name>"
RUN mkdir /etc/paludis/use.conf.d && \
	echo -e "sys-devel/gcc gcj \
\ndev-java/oracle-jdk-bin -awt \
\ndev-java/oracle-jre-bin -awt" \
	>> /etc/paludis/use.conf.d/java.conf

RUN mkdir /etc/paludis/keywords.conf.d && \
	echo -e "dev-java/oracle-jdk-bin ~amd64 \
\ndev-java/oracle-jre-bin ~amd64 \
\nvirtual/jdk ~amd64 \
\nvirtual/jre ~amd64 \
\ndev-java/* ~amd64" \
	>> /etc/paludis/keywords.conf.d/java.conf

COPY jdk-8u60-linux-x64.tar.gz /usr/portage/distfiles/

RUN chgrp paludisbuild /dev/tty && \
	cave resolve -z dev-java/oracle-jdk-bin virtual/jdk -x

# update world with our USE flags
RUN chgrp paludisbuild /dev/tty && cave resolve -c world -x
