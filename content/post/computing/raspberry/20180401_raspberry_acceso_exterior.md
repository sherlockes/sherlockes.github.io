---
title: "Raspberry Acceso desde el exterior"
date: "2018-04-10"
creation: "2018-04-10"
description: "Como acceder a nuestra Raspberry desde fuera de casa."
thumbnail: "images/20180410_raspberry_noip.jpg"
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
Ya tenemos nuestro servidor prácticamente montado, ahora necesitamos que cualquiera desde fuera de nuestra red pueda acceder al mismo.  Esto presenta dos problemas, el redireccionamiento de router a la raspberry y la ip dinámica que nos asigna el proveedor de servicios de internet.

Por un lado, para dirigir el tráfico que llega a nuestro router en busca de nuestro servidor tendremos que abrir el puerto 80 para la ip local que tiene adjudicada la Raspberry, en mi caso la 192.168.1.202.  Esto lo realizaremos desde la configuración del router accediendo al panel de administración web en la dirección 192.168.1.1.  No merece la pena el esfuerzo de dar más explicaciones de los pasos concretos a realizar pues cada router es distinto

Por otro lado necesitamos saber que dirección ip pública tiene adjudicada nuestro router en cada momento para poder acceder desde el exterior a este.  Para ello yo utilizo un servicio de dns dinámico como es [No-ip](https://www.noip.com/) para que continuamente compruebe la ip pública de router y la relaccione con un nombre de dominio fijo.
