# Java JRE 8 Dockerfile


This repository contains **Dockerfile** of [Java](https://www.java.com/) for [Docker](https://www.docker.io/)'s [personal build](https://index.docker.io/u/rossbachp/jre8/) published to the public [Docker Registry](https://index.docker.io/).


## Dependencies

* [dockerfile/ubuntu](http://dockerfile.github.io/#/ubuntu)
* [Download Oracle JRE](http://www.oracle.com/technetwork/java/javase/downloads/index.html)  the server-jre-8u20-linux-x64.tar.gz save at downloads and edit Dockerfile

## Installation

1. Install [Docker](https://www.docker.io/).

2. Download [my jre8 build](https://index.docker.io/u/rossbachp/jre8/) or from public [Docker Registry](https://index.docker.io/): `docker pull rossbachp/jre8`

   (alternatively, you can build an image from Dockerfile: `docker build -t="rossbachp/jre8" github.com/docker-images/jre8`)


## Usage

    docker run -it --rm rossbachp/jre8

### Run `javac`

    echo "public class Main { public static void main(String[] args) { System.out.println(\"Hello Java Docker World\") ;}}" >Main.java
    docker run -it --rm -v `pwd`:/data rossbachp/jre8 javac *.java

### Run `java`

    docker run -it --rm rossbachp/jre8 java -version
    docker run -it --rm -v `pwd`:/data rossbachp/jre8 java Main
