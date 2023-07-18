---
title: "Raspberry y Docker"
date: "2018-04-12"
description: "Una nueva forma de instalar servicios, mediante contenedores y Docker."
thumbnail: "images/20180501_raspberry_docker.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Raspberry"
tags:
  - "desarrollo"
draft: false
weight: 15
---
### Manejando contenedores con Docker

Instalar Docker\\
<code>
sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common

sudo curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -

sudo echo "deb [arch=armhf] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
     $(lsb_release -cs) stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list

sudo apt update
sudo apt install docker-ce
sudo systemctl enable docker
sudo systemctl start docker
</code>

añadir tu usuario al grupo de docker\\
```sudo gpasswd -a ${USER} docker```

eliminar todos los contenedores con un solo comando\\
```docker rm $(docker ps -a -q)```
```docker rm $(docker container ls -a -q)```

arrancar un contenedor\\
```docker run --name NOMBRE -p PUERTO_INTERNO:PUERTO_EXTERNO -d nginx```

### Instalando Wordpress







---
Enlaces\\
  * [UGeek - Instalar Docker en Raspbian](https://ugeek.github.io//instalar-docker-en-raspberry/)
  * [Rekkeb - Eliminar todos contenedores](https://rekkeb.wordpress.com/2015/03/19/docker-elimina-todos-los-contenedores-con-un-solo-comando)
  * [Jsurf - MariaDB for Raspberry Pi](https://hub.docker.com/r/jsurf/rpi-mariadb/)
  * [UpCloud - Install WordPress with Docker](https://www.upcloud.com/support/wordpress-with-docker/)
