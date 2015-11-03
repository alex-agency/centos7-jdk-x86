FROM centos:centos7
MAINTAINER Alex

# Variables
ENV USER_PASSWD  password
ENV ROOT_PASSWD  password

# Add user
RUN yum -y update && \
    yum -y install sudo && \
    yum clean all && rm -rf /tmp/* && \
    useradd user -m && \
    echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    echo "root:$ROOT_PASSWD" | chpasswd && \
    su user echo "user:$USER_PASSWD" | chpasswd
ENV HOME /home/user
WORKDIR /home/user

RUN yum -y update && \
    yum -y install wget tar bzip2 dbus \
    firefox*i686 libXtst-devel.i686 gtk2.i686 gtk2-engines.i686 gtk2-devel.i686 && \
    yum clean all && rm -rf /tmp/* && \
    touch /var/lib/dbus/machine-id && dbus-uuidgen > /var/lib/dbus/machine-id

# JDK x86
ENV JDK_URL http://download.oracle.com/otn-pub/java/jdk/8u65-b17/jdk-8u65-linux-i586.rpm
RUN wget -c --no-cookies  --no-check-certificate  --header \
"Cookie: oraclelicense=accept-securebackup-cookie" $JDK_URL -O jdk.rpm && \
    rpm -i jdk.rpm && rm -fv jdk.rpm
# Firefox x86 Java plugin
RUN alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so libjavaplugin.so \
    /usr/java/latest/jre/lib/i386/libnpjp2.so 200000

# Eclipse Luna x86
ENV ECLIPSE_URL http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads\
/release/mars/1/eclipse-jee-mars-1-linux-gtk.tar.gz
RUN wget $ECLIPSE_URL && \
    tar -zxvf `echo "${ECLIPSE_URL##*/}"` -C /usr/ && \
    ln -s /usr/eclipse/eclipse /usr/bin/eclipse && \
    rm -f `echo "${ECLIPSE_URL##*/}"`

# Default user
USER user
