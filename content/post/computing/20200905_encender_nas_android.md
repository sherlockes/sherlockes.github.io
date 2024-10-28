---
title: "Encender el Nas desde el teléfono"
date: "2020-09-05"
creation: "2020-09-05"
description: "Aquí describo el método que empleo para encender el NAS cuando no estoy cerca del botón de encendido del mismo."
thumbnail: "images/20200905_encender_nas_android_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "productividad"
  - "sherver"
tags:
  - "synology"
  - "zerotier"
draft: false
weight: 5
---
Tener el NAS encendido todo el día puede ser un gasto innecesario. El mío se enciende de forma automática las horas necesarias para las copias de seguridad y lo enciendo de forma remota desde mi teléfono si lo necesito de forma puntual fuera de este horario.
<!--more-->
Hay veces en las que necesito hacer uso del NAS cuando estoy fuera de casa. Para encenderlo hago uso del método "wakeonlan" desde mi teléfono Android y usando como puente la Raspberry.

## Configuración del NAS
Como ya he comentado en otras ocasiones, trabajo con un DS216+II de Synology y actualmente estoy con la versión 6.2 de DSM. para permitir el encendido remoto del NAS se debera activar la opción "Habilitar WOL en LAN" que podremos encontrar dentro del panel de control, Hardware y alimentación, Recuperación de energía.

![Image_01]

Del NAS además necesito saber la dirección MAC del mismo. Uso linux y para estas labores es muy práctico [nmap] ya que con la simple instrucción `sudo nmap -sP -n ip_del_nas` puedo obtener la dirección MAC de un equipo a partir de su IP.

![Image_02]

## Configuración de la Raspberry
Deberá tener activado el servidor ssh. En caso de que utilices la Raspberry en modo "Headless" sin teclado ni monitor ya lo tendrás activado, si la usas en modo escritorio quizás no, para activarlo...

- Ejecuta `sudo raspi-config` en la terminal
- Selecciona "Interfacing Options"
- Selecciona "SSH"
- Marca "Yes"
- Marca "Ok"
- Selecciona "Finish"

Por su sencillez, uso Zerotier como túnel de comunicación para cuando deseo trabajar con ella desde fuera de casa. La instalación y configuración la la traté en un [Post]({{<relref"/post/computing/20190314_zerotier.md">}}) anterior. La instalación y configuración son sólo dos líneas, la primera para inatalar ZeroTier en la Raspberry y la segunda para añadir esta a la res privada que deberemos haber creado en [My ZeroTier].

```
curl -s https://install.zerotier.com/ | sudo bash
sudo zerotier-cli join 78898a1265hfg34b
```

Para lanzar el comando "wakeonlan" que despierte al NAS uso la aplicación [Etherwake], su instalación es tan sencilla como `sudo apt install etherwake`

## Configuración de Android
Esta claro que en el teléfono deberá estar instalado Zerotier con la misma red virtual en la que se haya incluido la Raspberry. En el momento de la utilización deberá estar activa la conexión de Zerotier.

Para lanzar el comando desde el teléfono uso la aplicación [SSH Button]. En primer lugar crearemos un nuevo botón donde...

![Image_03]

- Label: Nombre que pondremos al botón
- Command: Comando que lanzará, en nuestro caso `wakeonlan MAC`
- SSH hostname: Dirección IP de la Raspberry
- SSH username: Nombre de usuario para acceder a la Raspberry
- SSH pasword: Contraseña pra el usuario de arriba
- Use private Key: No tocar, de momento nos apañamos con el nombre de usuario
- Sel Private Key: No tocar, de momento nos apañamos con el nombre de usuario
- SSH port: Puerto que la Raspberry tiene configurado para SSH

Con esto ya tenemos todo configurado y encender el NAS en remoto deberá ser tan sencillo como habilitar la red de ZeroTier y pulsar en el botón del comando. Yo me he creado pun par de botones, uno para cuando estoy dentro de la misma red que el NAS y otro para cuando estoy fuera. Quizás esto se pueda mejorar, pero ya para otro día...

![Image_04]

[Image_01]: /images/20200905_encender_nas_android_01.jpg
[Image_02]: /images/20200905_encender_nas_android_02.jpg
[Image_03]: /images/20200905_encender_nas_android_03.jpg
[Image_04]: /images/20200905_encender_nas_android_04.jpg

[Etherwake]: https://packages.debian.org/stable/net/etherwake
[nmap]: https://nmap.org
[SSH Button]: https://play.google.com/store/apps/details?id=com.pd7l.sshbutton&hl=en_US
[My ZeroTier]: https://my.zerotier.com/network
