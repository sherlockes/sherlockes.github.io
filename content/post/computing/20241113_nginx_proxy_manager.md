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
- "nginx"
draft: false
weight: 5
---
Hace tiempo que estoy dándole vueltas a montar un proxy inverso para mis servicios locales. Hoy me he decidido a montarlo con Nginx Proxy Manager.
<!--more-->
Antes de nada tengo que definir mis condiciones particulares
- Dominio creado en DonDominio
- Servidor local montado sobre un minipc corriendo Ubuntu Server
- Aplicación Docker y Docker-compose instalada y configurada
- Router ZTE F6640

### Creando un subDominio
El primer paso es crear un sub dominio o redirección de tipo A "*.tu_servidor.tudominio.com" que deberemos redireccionar a la ip de nuestro servidor.

![image-01]

En mi caso, [DonDominio] tiene la utilidad [DonDNS] que, mediante una pequeña aplicación que instalaremos en nuestro servidor y una llave API personal de usuario, es posible actualizar la IP de una redirección a medida que la IP pública de nuestro servidor vaya cambiando. Las instrucciones para un servidor linux están perfectamente descritas en su [documentación].

### Abriendo los puertos en el router
Para la configuración y funcionanmiento del proxy necesitaremos tener abiertos los puertos 80,81 y 443 y redireccionados a la IP local de nuestro servidor casero. Esto lo haremos desde la página de configuración del router. Una vez terminemos con la configuración, se puede cerrar al puerto 81. Nginx Proxy Manager seguirá funcionando con normalidad.

[image-02]

> Cada router tiene una forma distinta de hacerlo, en mi caso tengo un router ZTE F6640 y se puede acceder mediante el menú "Internet - Security - Port Forwarding"

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
- Lanzamos el contenedor a través de `docker-compose up -d`
- Accedemos a través del navegador al puerto 81 del servidor donde lo hayamos instalado
- Accedemos mediante usuario "admin@example.com" y password "changeme"
- Cambiamos las credenciales por defecto

Así accedemos directamente al panel de control de Nginx Proxy Manager

[image-03]


### Configuración del Host
Ya estamos listos para crear nuestra primera redirección. Para un servidor http de nginx que tenemos instalado en nuestro servidor local con IP 192.168.10.211 y al que accedemos mediante el puerto 8080 tenemos que crear un nuevo "Proxy Host" si queremos acceder a el desde fuera de nuestro domicilio mediante la dirección "nginx.tu_servidor.tudominio.com" realizaremos lo siguiente.

- Accedemos al menú "Proxy Hosts"
- Añadimos uno nuevo "Add Proxy Host"
- En el campo "Domain Names": nginx.tu_servidor.tudominio.com
- El campo "Scheme" queda como "http"
- En el campo "Forward Hostname/IP": 192.168.10.211
- En el campo "Forward Port": 8080
- Activamos la opción "Block Common Exploits"
- Guardamos los cambios

[image-04]

Con esto ya tendremos un nuevo host añadido

[image-05]

Podemos acceder a el mediante `http://ngin.tu_servidor.tudominio.com`

El siguiente paso en configurar el acceso seguro a la redirección. Para esto editamos el Proxy Host que habíamos creado.

- Seleccionamos la pestaña SSL
- Pulsamos sobre el cuadro "SSL Certificate"
- Solicitamos n nuevo certificado SSL

[image-06]

- Marcamos "Force SSL", "HSTS Enabled", "HTTP/2 Support" y "HSTS Subdomanins"
- Introducimos la dirección de correo
- Aceptamos los términos
- Guardamos los cambios

Ahora ya podemos acceder al host mediante `https://ngin.tu_servidor.tudominio.com`

### Enlaces de interés
- [Cursos de desarrollo - Nginx proxy manager](https://cursosdedesarrollo.com/2022/01/nginx-proxy-manager-o-la-manera-sencilla-de-manejar-acceso-a-tus-servicios-docker/)

[documentación]: https://dondominio.dev/es/dondns/docs/linux/
[DonDNS]: https://dondominio.dev/es/dondns/
[DonDominio]: https://www.dondominio.com
[guía de instalación de Nginx Proxy Manager]: https://nginxproxymanager.com/guide/

[image-01]: /images/20241113_nginx_proxy_manager_01.jpg
[image-02]: /images/20241113_nginx_proxy_manager_02.jpg
[image-03]: /images/20241113_nginx_proxy_manager_03.jpg
[image-04]: /images/20241113_nginx_proxy_manager_04.jpg
[image-05]: /images/20241113_nginx_proxy_manager_05.jpg
[image-06]: /images/20241113_nginx_proxy_manager_06.jpg
