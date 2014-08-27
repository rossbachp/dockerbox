# Java Dockerfile


This repository contains **Dockerfile** of [Java](https://www.java.com/) for [Docker](https://www.docker.io/)'s [personal build](https://index.docker.io/u/rossbachp/java7/) published to the public [Docker Registry](https://index.docker.io/).


## Dependencies

* [dockerfile/ubuntu](http://dockerfile.github.io/#/ubuntu)


## Installation

1. Install [Docker](https://www.docker.io/).

2. Download [my java 7 build](https://index.docker.io/u/rossbachp/java7/) or from public [Docker Registry](https://index.docker.io/): `docker pull rossbachp/java7`

   (alternatively, you can build an image from Dockerfile: `docker build -t="rossbachp/java7" -e JAVAVERSION=7 github.com/docker-images/java`)


## Usage

    docker run -it --rm rossbachp/java7

### Run `javac`

    echo "public class Main { public static void main(String[] args) { System.out.println(\"Hello Java Docker World\") ;}}" >Main.java
    docker run -it --rm -v `pwd`:/data rossbachp/java7 javac *.java

### Run `java`

    docker run -it --rm rossbachp/java7 java -version
    docker run -it --rm -v `pwd`:/data rossbachp/java7 java Main
