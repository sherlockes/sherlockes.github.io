---
title: "Configurar Nginx Proxy Manager en Ubuntu server"
date: "2024-11-13"
creation: "2024-11-13"
description: "Descripción"
thumbnail: "images/20241113_nginx_proxy_manager_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "docker"
draft: true
weight: 5
---
Resumen de introducción
<!--more-->
Antes de nada tengo que definir mis condiciones particulares
- Dominio creado en DonDominio
- Servidor local montado sobre un minipc corriendo Ubuntu Server
- Aplicación Docker y Docker-compose instalada y configurada



### Creando un subDominio
El primer paso es crear un sub dominio o redirección de tipo A "*.tu_servidor.tudominio.com" que deberemos redireccionar a la ip de nuestro servidor.

![image-01]

En mi caso, [DonDominio] tiene la utilidad [DonDNS] que, mediante una pequeña aplicación que instalaremos en nuestro servidor y una llave API personal de usuario, es posible actualizar la IP de una redirección según la IP pública de nuestro servidor. Las instrucciones para un servidor linux están perfectamente descritas en su documentación.

### Abriendo los puertos en el router
Para el proxy necesitaremos tener abiertos los puertos 80,81 y 443 y redireccionados a la IP local de nuestro servidor casero. Esto lo haremos desde la página de configuración del router


SEGUIR AQUÍ



### Instalando nginx proxy manager
Para la instalación del proxy inverso necesitamos tener instalado Docker y Docker-compose tan simple como seguir la [guía de instalación de Nginx Proxy Manager] con este sencillo "docker-compose.yml"

``` yaml
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
```


### Enlaces de interés
- [Cursos de desarrollo - Nginx proxy manager](https://cursosdedesarrollo.com/2022/01/nginx-proxy-manager-o-la-manera-sencilla-de-manejar-acceso-a-tus-servicios-docker/)

[documentación]: https://dondominio.dev/es/dondns/docs/linux/
[DonDNS]: https://dondominio.dev/es/dondns/
[DonDominio]: https://www.dondominio.com
[guía de instalación de Nginx Proxy Manager]: https://nginxproxymanager.com/guide/

[image-01]: /images/20241113_nginx_proxy_manager_01.jpg



