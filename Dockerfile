### Ubooquity
### Pull base image
FROM resin/rpi-raspbian:wheezy
MAINTAINER Sven Hartmann <sid@sh87.net>

### Install Applications DEBIAN_FRONTEND=noninteractive  --no-install-recommends
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
RUN echo "deb-src http://mirrordirector.raspbian.org/raspbian/ wheezy main contrib non-free rpi" | tee --append /etc/apt/sources.list
RUN apt-get update -y --force-yes && apt-get upgrade -y --force-yes && apt-get dist-upgrade -y --force-yes && apt-get clean

### Set locale to UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
RUN locale-gen en_US en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
RUN dpkg-reconfigure locales

### Update
RUN apt-get install -y apt-utils
RUN apt-get install -y openssh-server supervisor git
RUN apt-get install -y python python-crypto python-pycurl python-imaging python-pip python-tornado python-zmq python-psutil
RUN apt-get install -y zip unzip
RUN apt-get install -y dpkg-dev
RUN apt-get install -y screen nano htop bmon wget curl
RUN mkdir -p /var/run/sshd
RUN chmod 755 /var/run/sshd
RUN mkdir -p /var/log/supervisor
RUN apt-get clean

### Install Java 8 and JNA
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get update -y
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get install -y --force-yes oracle-java8-installer
RUN apt-get install -y --force-yes oracle-java8-set-default
RUN mkdir /tmp/jna-4.0.0 && \
	cd /tmp/jna-4.0.0 && \
	wget --no-check-certificate 'https://maven.java.net/content/repositories/releases/net/java/dev/jna/jna/4.0.0/jna-4.0.0.jar' && \
	wget --no-check-certificate 'https://maven.java.net/content/repositories/releases/net/java/dev/jna/jna-platform/4.0.0/jna-platform-4.0.0.jar' && \
	cd /tmp/jna-4.0.0 && \
	cd /usr/share/java && \
	[ -f jna.jar ] && rm jna.jar || \
	cp /tmp/jna-4.0.0/*.jar . && \
	ln -s jna-4.0.0.jar jna.jar && \
	ln -s jna-platform-4.0.0.jar jna-platform.jar && \
	java -jar jna.jar

### Install Ubooquity
RUN cd /
RUN wget http://vaemendis.net/ubooquity/downloads/Ubooquity-1.7.6.zip && unzip Ubooquity-1.7.6.zip -d UbooquityInstall

### Exposed config volume
VOLUME /config

### Add config files
ADD ./files/start.sh /start.sh
RUN chmod +x /start.sh
ADD ./files/supervisord.conf /supervisord.conf

### Expose default Ubooquity port
EXPOSE 8085
### Make start script executable and default command
ENTRYPOINT ["/start.sh"]
