# build your own docker _ubuntu_ base image

  * use master mkimage.sh from docker
  * use debootstrap
  
After install at your host you can use _mkimage.sh_ at `/usr/local/sbin` to bootstrap os's!

Install and run
```bash
$ vargant ssh
$ sudo /bin/bash
$ mkdir /opt/ubuntu
$ cp createbaseimage.sh /opt/ubuntu
$ cd /opt/ubuntu
$ chmod +x createbaseimage.sh
$ ./createbaseimage.sh
$ docker images | grep rossbachp/ubuntu
rossbach/ubuntu             14.04                19ab99bb1211        About an hour ago   179.4 MB
```

Run commands with the your own base images
```bash
$ docker run -it -rm rossbach/ubuntu:14.04 /bin/bash
$ cat /etc/lsb-release 
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=14.04
DISTRIB_CODENAME=trusty
DISTRIB_DESCRIPTION="Ubuntu 14.04.1 LTS"
```

Modify after you read this:

  * [docker baseimages](https://docs.docker.com/articles/baseimages/)
  * [debootstrap man](http://manpages.debian.org/cgi-bin/man.cgi?sektion=8&query=debootstrap&apropos=0&manpath=sid&locale=en)

Good luck,
[Peter](mailto:peter.rossbach@bee42.com)
