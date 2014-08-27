#
# Java Dockerfile
#
# https://github.com/rossbachp/dockerbox/docker-images/java8
#

# Pull base image.
FROM dockerfile/ubuntu

ENV JAVAVERSION 8

# Install Java.
RUN \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java${JAVAVERSION}-installer

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["bash"]
