# Apache Tomcat 8 optimized images

This repository contains **Dockerfile** of [Apache Tomcat 8](https://tomcat.apache.org/).


It use a [Docker](https://www.docker.com/)'s [personal build](https://registry.hub.docker.com/u/rossbachp/apache-tomcat8/) published to the public [Docker Registry](https://registry.hub.docker.com/).

## Design

This docker apache tomcat images supports production and development. A lot of other tomcat docker images exist, but the only support development or not use the newest version or bundle an open jdk. We want build a nicer one. Send us your missing features!

**Goals**
* use minimal ubuntu and java8 base images (work in progress)
* inject libs and wars as volumes (data container)
* deploy the manager app and generate password at start
* clean up installation and remove examples and unused `*.bat`, .. files.
* squash footprint and clean up build artefacts
* use a nicer access log pattern :-)
* use a cleanup server.xml without comments
  * use separate executor
  * setup HTTP (8080) and AJP (8009) connectors and expose ports
  * currently not support APR Connectors or configure other then standard NIO
* reuse existing cool ideas from other nice guys. Many thanks;)

You can deploy your own webapps and tomcat extended library with local volumens or better with a docker data container.

![Apache Tomcat 8 docker image design](design-tomcat8-images.png)

## Found the tomcat docker images

Currently the apache tomcat8 images are available as automatic docker hub build and a squash version.

* [docker hub build](https://registry.hub.docker.com/u/rossbachp/apache-tomcat8/)
* [optimized squash  build](https://registry.hub.docker.com/u/rossbachp/tomcat8/) (s. build.sh)

## Dependencies

* [ubuntu](https://registry.hub.docker.com/u/_ubuntu)
* [Dockerbox java8 image: rossbachp/java8 source ](https://github.com/rossbachp/dockerbox/tree/master/docker-images/java8)
* [rossbachp/java8 images ](https://registry.hub.docker.com/u/rossbachp/java8)
* [Apache Tomcat 8 Download ](https://archive.apache.org/dist/tomcat/tomcat-8)
* [squashing-docker article](http://jasonwilder.com/blog/2014/08/19/squashing-docker-images/)

## Installation

1. Install [Docker](https://www.docker.com/).
2. Download [rossbachp/java8](https://registry.hub.docker.com/u/rossbachp/java8): `docker pull rossbachp/java8`
3. Download [rossbachp/tomcat8](https://registry.hub.docker.com/u/rossbachp/tomcat8): `docker pull rossbachp/tomcat8` or [rossbachp/apache-tomcat8](https://registry.hub.docker.com/u/rossbachp/apache-tomcat8): `docker pull rossbachp/apache-tomcat8` or

## Usage

    docker run -it --rm -P rossbachp/apache-tomcat8
    docker run -it --rm -P rossbachp/tomcat8

### Run _tomcat8_ with a sample _hello world_

    mkdir -p hello
    cd hello
    echo "Hello Docker Tomcat World" >index.jsp
    jar -cf ../hello.war .
    cd ..
    docker run --name=tomcat8 -d -p 8080:8080 -v `pwd`:/webapps rossbachp/tomcat8
    curl http://127.0.0.1:8080/hello/index.html

### Run _tomcat8_ with a sample _hello world_ at a data container

    mkdir -p hello
    cd hello
    echo "Hello Docker Tomcat World" >index.jsp
    jar -cf ../hello.war .
    cd ..
    vi Dockerfile

**Dockerfile**

    FROM busybox
    MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

    RUN mkdir /webapps
    ADD hello.war /webapps/hello.war

    VOLUME ["/webapps"]

    CMD /bin/sh

**Running**

    docker build -t="rossbachp/hello-app".
    docker run -it --name=hello-app rossbach/hello-app ls /webapps
    docker run --name=tomcat8 -d -p 8080:8080 --volumes-from hello-app rossbachp/tomcat8
    curl http://127.0.0.1:8080/hello/index.html

**deploy with your system parameters**

    docker run -it --rm --env CATALINA_OPTS="-Ddb.user=admin -Ddb.password=secret" -v `pwd`/webapps:/webapps -v `pwd`/libs:/libs rossbachp/tomcat8

**use your own JVM_ROUTE**

    docker run -it --rm --env TOMCAT_JVM_ROUTE=tomcat79 -p 7980:8080 -p 7909:8009 -v `pwd`/webapps:/webapps rossbachp/tomcat8

**stop tomcat**

    docker stop --time=10 tomcat8

  - This send _SIGTERM_ and after 10 seconds sends _SIGKILL_, if tomcat process is not stopped before.

### tomcat docker images ENV parameter

| Parameter | Default | Comment |
|-----------|---------|---------|
| `JAVA_MAXMEMORY`| `256`| setup jvm max memory|
| `TOMCAT_MAXTHREADS`| `250`| setup max executor threads|
| `TOMCAT_MINSPARETHREADS`|  `4` |setup min spare executor threads|
| `TOMCAT_HTTPTIMEOUT`| `20000` | setup http connector timeout |
| `TOMCAT_JVM_ROUTE`| `tomcat80`| support session sticky ness suffix|
| `TOMCAT_JVM_ROUTE`| `tomcat80`| support session sticky ness suffix|
| `TOMCAT_PASS` | random generated | admin password |
| `CATALINA_OPTS` | s. `tomcat.sh` | tomcat start parameter |
| `JAVA_OPTS` | s. `tomcat.sh` | spezial java start/stop parameter |

### get _tomcat container IP and ports_

    $ DOCKER_HOST_IP=$(docker inspect -f '{{.NetworkSettings.IPAddress}}'
    $ docker inspect -f '{{ range $key, $value := .NetworkSettings.Ports }}{{ $key }}='"${DOCKER_HOST_IP}:"'{{ (index $value 0).HostPort }} {{ end }}‘ tomcat8 | tr " " "\n"
    8080/tcp=172.17.0.30:8080
    8009/tcp=172.17.0.30:8009


### Run `list all deployed apps`

    $ DOCKER_HOST_IP=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' tomcat8)
    $ curl --user "admin:password" http://${DOCKER_HOST_IP}:8080/manager/text/list
    OK - Listed applications for virtual host localhost
    /manager:running:0:manager

The admin password can be extract from logs:

    $ docker logs tomcat8 | head
    => Creating and admin user with a random password in Tomcat
    => Done!
    ========================================================================
    You can now configure to this Tomcat server using:

        admin:H4t4bbyZxjNh

    ========================================================================
    Checking *.war in /webapps
    Checking tomcat extended libs *.jar in /libs

or set at your password at container starts:

    docker run -d --name=tomcat8 --env TOMCAT_PASS=password rossbachp/tomcat8

### debug tomcat with nsenter

Install [nsenter](https://github.com/jpetazzo/nsenter):

    sudo docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter

Tail tomcat app or access logs

    sudo docker-enter tomcat8 tail -f /opt/tomcat/logs/catalina-2014-08-27.log
    sudo docker-enter tomcat8 tail -f /opt/tomcat/logs/access-2014-08-27.log


or

    sudo docker logs tail tomcat8

Run jstat

    sudo docker-enter tomcat8 su tomcat --shell /bin/bash -c 'jstat -gc 1 5000'

More space for research:

* run jonsole?
  * add jmx port and expose
  * secure
* load jolokia and monitor via http

## manually build, squash and push

    sudo bash
    cd /tmp
    docker build -t="rossbachp/tomcat8" .
    ID=$(docker inspect -f '{{ .Id }}' rossbachp/tomcat8)
    docker save $ID > tomcat8.tar
    sudo docker-squash -verbose -i tomcat8.tar -o tomcat8-squash.tar -t rossbachp/tomcat8:squash
    cat tomcat8-squash.tar | docker load
    rm tomcat8.tar
    rm tomcat8-squash.tar

or simple use the ``./build.sh` or with cleanup `./build.sh --rmi`

### Push to docker hub registry

    docker login
    docker push rossbachp/tomcat8:latest
    docker push rossbachp/tomcat8:<DATE TAG>

### Links

* [squashing-docker article](http://jasonwilder.com/blog/2014/08/19/squashing-docker-images/)
* [github squashing-docker](https://github.com/jwilder/docker-squash)

## Option for better logging

  - Use a volume for logging `sudo docker run --rm -t -v /var/log/tomcat8:/opt/tomcat/logs rossbachp/tomcat8` and delegate it to logstash-forwarder or rsyslog.
  - Use only stdout/stderr or file output handler
  - Don't let make file rotation, compression and archive control from outside

The current configured logging need a better solutions!

  - [Docker logstash](https://denibertovic.com/post/docker-and-logstash-smarter-log-management-for-your-containers/)
  - [syslog-docker](http://jpetazzo.github.io/2014/08/24/syslog-docker/)
  - [SyslogValve](https://github.com/magwas/SyslogValve)
  - [tomcat-slf4j-logback](https://github.com/grgrzybek/tomcat-slf4j-logback)
  - [Logback appenders](http://logback.qos.ch/manual/appenders.html)
  - [Graylog2 Logger](http://graylog2.org/resources/gelf)
  - [logback-gelf](https://github.com/Moocar/logback-gelf)
    - Only supports UDP
    - Java Implementation
    - Test TCP GELF: `echo -e '{"version": "1.1","host":"example.org","short_message":"A short message that helps you identify what is going on","full_message":"Backtrace here\n\nmore stuff","level":1,"_user_id":9001,"_some_info":"foo","_some_env_var":"bar"}\0' | nc -w 1 my.graylog.server 12201`
        - See send _null character_ at end of your multiline messages!

At your application you can use beter directly use syslog but how we configure syslog host?:

```xml
<appender name="SYSLOG" class="ch.qos.logback.classic.net.SyslogAppender">
        <syslogHost>localhost</syslogHost>
        <facility>LOCAL6</facility>
        <suffixPattern>app: %logger{20} %msg</suffixPattern>
</appender>
```

  - Use DNS link name at `/etc/hosts` with new writable docker >= 1.2 feature
    - `@{syslog.PrivateIpAddress} syslog`
    - [docker-leaving-immutable-infrastructure](http://devops.com/blogs/docker-leaving-immutable-infrastructure-2/)
    - Logback can read OS Env vars, that means docker link argument works!

## Other nice tomcat docker images

  * [ ConSol docker-appserver](https://github.com/ConSol/docker-appserver)
  * [tutum docker  tomcat images](https://github.com/tutumcloud/tutum-docker-tomcat)
Many thanks for that.

## Todo
  * setup better logging
  * setup JMX and monitoring
  * support APR Connector
  * support SSL
  * setup your own server.xml
  * integrate a check api
    * use [coda hale metrics](http://metrics.codahale.com/)
    * build my own checker
    * test nagios checks
  * more samples
    * JDBC sample with fig setup
    * auto scaling apache/mod_jk ectd sample

##
Have fun with this tomcat images and give feedback!

Peter
