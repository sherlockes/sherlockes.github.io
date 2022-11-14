---
title: "Microbit desde cero con niños"
date: "2022-10-24"
creation: "2022-10-24"
description: "Mi experiencia usando la Microbit con niños desde los primeros pasos"
thumbnail: "images/20221024_microbit_desde_cero_00.jpg"
disable_comments: true
authorbox: false
toc: True
mathjax: false
categories:
- "computing"
tags:
- "microbit"
draft: true
weight: 5
---
Aquí está lo que esta siendo el proceso y experiencia de uso del aprendizaje al manejo de la [Microbit] con niños de primaria.
<!--more-->
### Dia 00 (Motivación y kit de inicio)
Después de escuchar a Juan Febles en su [episodio 167] de Podcastlinux sobre las bondades de esta placa me he decidido a comprar este [kit] con la versión 2.2 de la placa para introducir a los niños en el mundo de la programación y la electrónica. Una inversión de 35€ no puede ser la frontera para intentarlo.

![image-01]

A priori parece que contiene todo lo que voy a necesitar durante una temporada para introducirnos en este entorno.

### Día 01 (Primer fracaso)
La idea es utilizar la placa junto con el Ipad por lo desde este enlace ([Microbit - Mobile apps]) nos envía al sitio para descargar la aplicación para IOS ([Microbit - App store]). Claramente se puede ver en la web como es necesaria la versión 9 de IOS de la aplicación.

Empezamos en la web de [Microbit] y, aunque la web se puede traducir al castellano, el vídeo de emparejado sólo está en inglés con subtítulos en inglés.

{{< youtube 2uFuW8kA_lw  >}}

Instalamos la aplicación para ipad pero, aunque es posible llevar a cabo el emparejado de la placa via bluetooth, se exige al menos la versión 13 de IOS para un correcto funcionamiento. La aplicación de crear código se arrastra y no soy capaz de hacer que funcione en un tiempo razonable. Abortamos la misión y restauro la placa a su estado original tal y como se muestra en [Microbit - Out of the box experience].

> Un par de conclusiones del primer día efectivo. Por un lado, el tema de pulsar los dos botones delanteros y posteriormente pulsar el trasero y volverlo a soltar para el emparejado no resulta intuitivo para un niño de primaria. Por otro, con los dos chicos (7 y 4 años) al mismo tiempo va a ser complicado...

### Día 02 (Primera toma de contacto)
Nos olvidamos del ipad para trabajar en Linux Mint con un navegador completo y [Makecode], para hacer el primer tutorial disponible y recomendado para nuevos usuarios.

![image-02]

La interfaz es clara y sencilla de utilizar. Estos tutoriales guiados, aunque tienen una extraña mezcla de castellano e inglés, son fáciles de seguir para los niños y en unos pocos minutos está el corazón parpadeando en los led de la Microbit a pesar de que no estén acostumbrados al trabajo con ratón y teclado. Seguramente la parte más complicada para los niños que todavía no han tenido contacto con sistemas operativos de pc es el hecho y concepto de guardar el archivo en una ubicación y luego copiarlo a la Microbit.

> Desgraciadamente, usando Linux Mint como sistema operativo y Vivaldi como navegador no funciona la opción de transferir el archivo directamente a la Microbit desde [Makecode]. Espero se corrija con alguna actualización.

En este primer día con la programación de bloques hacemos tres tutoriales, el ya comentado del corazón parpadeante, uno para mostrar textos y un tercero para dibujar una cara u otra en la matriz de leds de la Microbit en función del botón que se pulse.

![image-03]

El niño de 8 años está encantado, tanto por "trabajar" en un ordenador de mayores como por ver que lo que dibuja en la pantalla luego se puede tocar en la pequeña placa que hemos llamado "El cerebro del robot".

### Enlaces de interés
- [enlace](www.sherblog.pro)



[Episodio 167]: https://podcastlinux.com/posts/podcastlinux/167-Podcast-Linux/
[kit]: https://www.amazon.es/gp/product/B0B11R2BT1
[Makecode]: https://makecode.microbit.org
[Microbit]: https://microbit.org
[Microbit - App store]: https://apps.apple.com/gb/app/micro-bit/id1092687276
[Microbit - Mobile apps]: https://microbit.org/get-started/user-guide/mobile/
[Microbit - Out of the box experience]: https://microbit.org/get-started/user-guide/out-of-box-experience

[image-01]: /images/20221024_microbit_desde_cero_01.jpg
[image-02]: /images/20221024_microbit_desde_cero_02.jpg
[image-03]: /images/20221024_microbit_desde_cero_03.jpg


