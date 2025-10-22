---
title: "Usando un tunel ssh para aceder a un servidor remoto"
date: "2025-10-22"
creation: "2020-10-08"
descrption: "Usando un tunel ssh para aceder a un servidor remoto"
thumbnail: "/images/20201008_usando_tunel_ssh_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "linux"
tags:
  - "ssh"
  - "zerotier"
draft: false
weight: 5
---
Esta vez me encuentro con que tengo que acceder a la configuración de un router remoto, no tengo acceso a través de ssh pero  en la red del mismo tengo "infiltrada" una Raspberry con Zerotier.
<!--more-->
Me encuentro en la necesidad de modificar la configuración de un router remoto del que me separan unos cuantos kilómetros y el único as que tengo en la manga es una raspberry que tengo que tengo conectada a el y agregada a mi red privada de zerotier.

Hace unos día leí un post de [atareao] en el que se trataba el uso de túneles ssh y, aunque no se comentó específicamente el tema, me puso en la pista de como resolver mi problema con una sola línea de código donde el primer "80" corresponde al puerto local del dispositivo sobre el que se está ejecutando el comando y el segundo el que queremos redirigir.

```
sudo ssh -L 80:<ip_del_router>:80 usuario_raspberry@<ip_zerotier_de_raspberry>
```
La ejecuto en una terminal de Mint, contraseña del superusuario de Mint, contraseña del usuario de la Raspberry en Zerotier y...

... parece que simplemente se la logado en la raspberry con Zerotier pero si abro el navegador de Mint y accedo a "localhost" o la dirección http://127.0.0.1 y ...

![Image_01]

Ya tengo la página de configuración del router remoto desde el explorador local usando la raspberry como máquina intermedia creando un tunal ssh.

> Es posible que si no puedes usar "sudo" tengas problemas para abrir el puerto 80 del dispositivo desde el que estás ejecutando el comando (Tal y como me ha ocurrido a mi al ejecutarlo desde Termux para android), en ese caso la solución más sencilla pasa por cambiar el primer 80 por un puerto más alto como 8080 y luego acceder a http://127.0.0.1:8080

[Image_01]: /images/20201008_usando_tunel_ssh_01.jpg

[atareao]: https://www.atareao.es/ubuntu/tuneles-ssh/
