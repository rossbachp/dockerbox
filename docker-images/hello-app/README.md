# Start a simple docker java webapp data container

## run tomcat with container

template='{{ range $key, $value := .NetworkSettings.Ports }}{{ $key }}={{ (index $value 0).HostPort }} {{ end }}'
docker inspect --format="${template}" tomcat8

```bash
$ docker run -it --name=hello-app rossbachp/hello-app ls
$ docker run -it --rm --name=tomcat8 --volumes-from hello-app:ro -P rossbachp/tomcat8
=> Creating and admin user with a random password in Tomcat
=> Done!
========================================================================
You can now configure to this Tomcat server using:

    admin:WxtMFEiM96gp

========================================================================
Checking *.war in /webapps
Linking /webapps/hello.war --> /opt/tomcat/webapps/hello.war
Checking tomcat extended libs *.jar in /libs
Using CATALINA_BASE:   /opt/tomcat
Using CATALINA_HOME:   /opt/tomcat
Using CATALINA_TMPDIR: /opt/tomcat/temp
Using JRE_HOME:        /usr
Using CLASSPATH:       /opt/tomcat/bin/bootstrap.jar:/opt/tomcat/bin/tomcat-juli.jar
Using CATALINA_PID:    /opt/tomcat/temp/tomcat.pid
28-Aug-2014 20:11:38.149 INFO [main] org.apache.coyote.AbstractProtocol.init Initializing ProtocolHandler ["http-nio-8080"]
28-Aug-2014 20:11:38.206 INFO [main] org.apache.tomcat.util.net.NioSelectorPool.getSharedSelector Using a shared selector for servlet write/read
28-Aug-2014 20:11:38.210 INFO [main] org.apache.coyote.AbstractProtocol.init Initializing ProtocolHandler ["ajp-nio-8009"]
28-Aug-2014 20:11:38.212 INFO [main] org.apache.tomcat.util.net.NioSelectorPool.getSharedSelector Using a shared selector for servlet write/read
28-Aug-2014 20:11:38.214 INFO [main] org.apache.catalina.startup.Catalina.load Initialization processed in 1043 ms
28-Aug-2014 20:11:38.274 INFO [main] org.apache.catalina.core.StandardService.startInternal Starting service Catalina
28-Aug-2014 20:11:38.274 INFO [main] org.apache.catalina.core.StandardEngine.startInternal Starting Servlet Engine: Apache Tomcat/8.0.11
28-Aug-2014 20:11:38.316 INFO [localhost-startStop-1] org.apache.catalina.startup.HostConfig.deployWAR Deploying web application archive /opt/tomcat/webapps/hello.war
28-Aug-2014 20:11:38.852 INFO [localhost-startStop-1] org.apache.catalina.startup.HostConfig.deployWAR Deployment of web application archive /opt/tomcat/webapps/hello.war has finished in 535 ms
28-Aug-2014 20:11:38.856 INFO [localhost-startStop-1] org.apache.catalina.startup.HostConfig.deployDirectory Deploying web application directory /opt/tomcat/webapps/manager
28-Aug-2014 20:11:38.893 INFO [localhost-startStop-1] org.apache.catalina.startup.HostConfig.deployDirectory Deployment of web application directory /opt/tomcat/webapps/manager has finished in 37 ms
28-Aug-2014 20:11:38.936 INFO [main] org.apache.coyote.AbstractProtocol.start Starting ProtocolHandler ["http-nio-8080"]
28-Aug-2014 20:11:38.947 INFO [main] org.apache.coyote.AbstractProtocol.start Starting ProtocolHandler ["ajp-nio-8009"]
28-Aug-2014 20:11:38.950 INFO [main] org.apache.catalina.startup.Catalina.start Server startup in 735 ms
```

## Controller shell
```bash
$template='{{ range $key, $value := .NetworkSettings.Ports }}{{ $key }}={{ (index $value 0).HostPort }} {{ end }}'
docker inspect --format="${template}" tomcat8
8009/tcp=49171 8080/tcp=49172
$ curl http://127.0.0.1:49172/hello/index.html
Hello Docker Tomcat World
## See password at tomcat log output
$ curl --user "admin:WxtMFEiM96gp" http://127.0.0.1:49172/manager/text/list
OK - Listed applications for virtual host localhost
/manager:running:0:manager
/hello:running:0:hello
```
