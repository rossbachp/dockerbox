#
# Java JRE Dockerfile
#
# https://github.com/rossbachp/dockerbox/docker-images/jre8
# http://wiki.ubuntuusers.de/Java/Installation/Oracle_Java/Java_8#source-1
#

# Pull base image.
FROM ubuntu:14.04
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

ENV JAVAVERSION 20

ADD downloads/server-jre-8u${JAVAVERSION}-linux-x64.tar.gz /opt/Oracle_Java

# Install JRE and clean up 
RUN \
  update-alternatives --install "/usr/bin/java" "java" "/opt/Oracle_Java/jdk1.8.0_${JAVAVERSION}/bin/java" 1 && \
  update-alternatives --install "/usr/bin/javac" "javac" "/opt/Oracle_Java/jdk1.8.0_${JAVAVERSION}/bin/javac" 1 && \
  update-alternatives --install "/usr/bin/jar" "jar" "/opt/Oracle_Java/jdk1.8.0_${JAVAVERSION}/bin/jar" 1 && \
  update-alternatives --install "/usr/bin/jps" "jps" "/opt/Oracle_Java/jdk1.8.0_${JAVAVERSION}/bin/jps" 1 && \
  update-alternatives --set "java" "/opt/Oracle_Java/jdk1.8.0_${JAVAVERSION}/bin/java"  && \
  update-alternatives --set "javac" "/opt/Oracle_Java/jdk1.8.0_${JAVAVERSION}/bin/javac" && \ 
  update-alternatives --set "jar" "/opt/Oracle_Java/jdk1.8.0_${JAVAVERSION}/bin/jar"  && \
  update-alternatives --set "jps" "/opt/Oracle_Java/jdk1.8.0_${JAVAVERSION}/bin/jps"

RUN \
  rm -rf /usr/share/doc /usr/share/man
  
# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["bash"]
