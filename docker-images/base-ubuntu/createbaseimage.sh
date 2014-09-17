#!/bin/bash

if [ ! -x  /usr/sbin/debootstrap ]; then
    echo = Install debootstrap tool
    sudo apt-get install -y debootstrap
fi

if [ ! -x /usr/local/sbin/mkimage.sh ]; then
    echo = Install mkimage

    sudo sh -xc 'curl https://raw.githubusercontent.com/docker/docker/master/contrib/mkimage.sh  > /usr/local/sbin/mkimage.sh'
    sudo chmod 755 /usr/local/sbin/mkimage.sh
    sudo mkdir /usr/local/sbin/mkimage
fi

if [ ! -x /usr/local/sbin/mkimage/debootstrap ]; then
  echo = Install docker debootstrap

  sudo sh -xc 'curl https://raw.githubusercontent.com/docker/docker/master/contrib/mkimage/debootstrap > /usr/local/sbin/mkimage/debootstrap'
   sudo chmod 755 /usr/local/sbin/mkimage/debootstrap
fi

sudo mkdir -p /opt/ubuntu
cd /opt/ubuntu
sudo mkimage.sh -t rossbachp/ubuntu:14.04 debootstrap --include=ubuntu-minimal --components=main,universe trusty
