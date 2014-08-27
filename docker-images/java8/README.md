# Java Dockerfile


This repository contains **Dockerfile** of [Java](https://www.java.com/) for [Docker](https://www.docker.io/)'s [personal build](https://index.docker.io/u/rossbachp/java8/) published to the public [Docker Registry](https://index.docker.io/).


## Dependencies

* [dockerfile/ubuntu](http://dockerfile.github.io/#/ubuntu)


## Installation

1. Install [Docker](https://www.docker.io/).

2. Download [my java 8 build](https://index.docker.io/u/rossbachp/java8/) or from public [Docker Registry](https://index.docker.io/): `docker pull rossbachp/java7`

   (alternatively, you can build an image from Dockerfile: `docker build -t="rossbachp/java8" github.com/docker-images/java8`)


## Usage

    docker run -it --rm rossbachp/java8

### Run `javac`

    echo "public class Main { public static void main(String[] args) { System.out.println(\"Hello Java Docker World\") ;}}" >Main.java
    docker run -it --rm -v `pwd`:/data rossbachp/java8 javac *.java

### Run `java`

    docker run -it --rm rossbachp/java8 java -version
    docker run -it --rm -v `pwd`:/data rossbachp/java8 java Main
