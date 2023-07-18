---
title: "Raspberry Montaje y ssh"
date: "2021-04-28"
creation: "2018-04-01"
description: "Primera fase con el montaje, la creación de la imagen y la habilitación del acceso ssh"
thumbnail: "images/raspberry_logo.png"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Raspberry"
tags:
  - "desarrollo"
draft: false
weight: 5
---
### Montaje y acceso ssh
Ya tengo todo lo que creo que necesito.  Una [Raspberry], una [tarjeta micro sd], una [fuente de alimentación] y un [cable de red].  Total 59€ de inversión inicial que supongo no se quedarán ahí.

<!--more-->

Rápidamente me vengo arriba y entro el la web de Raspberry Pi para ver como empezar con el cacharro, ya que estos días desde que lo pedí todo hasta que me ha llegado no me he preocupado de nada.  Primer jarro de agua fría, ya que veo que necesito un ratón, un teclado y un cable hdmi según la [guía oficial] de Raspberry.  Pero antes de que sumerja en una profunda frustración navego un poco por la red y veo que es posible configurarla sin monitor ni teclado tal y como se explica en [Innerzaurus] o en [Algoentremanos].  Hay esperanza de poder seguir adelante sin gastar más dinero.

Bueno, ya estamos metidos en el fregado...

* Descargamos [Raspberry Pi OS] (La versión Lite que pesa menos y no necesitamos entorno gráfico)
* Para Windows descargamos [SD Card Formatter] para formatear la tarjeta de memoria
* Para Windows descargamos [Win32 Disk Imager] para grabar la imagen en la tarjeta
* Para Linux Mint descargamos [Balena Etcher]

> Recientemente, la fundacion Raspberry ha creado una utilidad para directamente descargar la ultima imagen de la distribución que deseemos y tostarla sobre la tarjeta sd o usb, es posible descargarla desde https://www.raspberrypi.org/downloads/ Una alternativa mucho más sencilla y rapida a descargar, descomprimir, formatear y escribir.

Con la fuente de alimentación ha venido una pequeña caja transparente y unos disipadores para los microcontroladores, faena de cirujano para montar todo y ya está el hardware preparado.

* Para Windows
  * Se descomprime la imagen de Rasbian (Winzip, Winrar...)
  * Se formatea la tarjeta de memoria con SD Card Formatter
  * Se graba la imagen en la tarjeta con Win32 Disk Imager
* Para Linux Mint
  * Se graba la imagen directo desde el zip con Etcher
* En el directorio raiz hay que crear un archivo "ssh" sin extensión en la carpeta "boot"

![Imagen_01]

> En el caso de Windows, una altermativa al uso de SD Card Formatter y Win32 Disk Imager es usar Rufus, un software gratuito con una versión portable que puedes descargar desde http://rufus.akeo.ie y hacemos los los pasos en uno creando un disco de arranque con una imagen DD a partir de la imagen descargada.

Al intentar crear el archivo "ssh" que habilita el terminal para poder manejar la Raspberry en remoto me encuentro con el primer problema, y es que al intentar crear el archivo me dice que la tarjeta está protegida contra la escritura.  No se si es problema del lector de tarjetas, del adaptador de SD a MicroSD o del propio windows pero el caso es que monto la MicroSD en un lector de tarjetas usb y me deja crear el archivo sin ningún problema.

Ya está todo listo para conectar la Raspberry al router mediante el cable de red, introducir la tarjeta de memoria y conectarle la fuente de alimentación.  No se cuanto tiempo hay que esperar para que el sistema arranque, pero como voy escribiendo al tiempo que hago las cosas, soy lo suficientemente lento para que el sistema haya arrancado cuando estoy listo para dar el siguiente paso.  Ahora necesito otras utilidades para seguir adelante, una para averiguar la dirección ip con la que se ha conectado la Raspberry a la red local y para conectarme mediante ssh.

* En Windows
  * Para averiguar la ip utilizo [PortScan]
  * Para conectarme mediante ssh uso [Putty]
* En Linux Mint
  * Para averiguar la ip utilizo nmap
    1. Averiguar la la ip del pc desde el qe estamos trabajando 'Hostname -I'
    1. Instalar la aplicación "nmap"'sudo apt install nmap'
    1. Listar todas las ip's activas de la red 'sudo nmap -sn 192.168.1.0/24'
  * Para conectarme mediante ssh uso la terminal
  
> Junto con nmap resulta muy interesante las instalación de "nast" y obtener todas las IP de la red local junto con su MAC gracias al comando "sudo nast -m"

![Imagen_02]

Averiguo que la Raspberry se ha conectado a la ip 192.168.1.118 y ya puedo arrancar Putty y logarme con el usuario "pi" y el password "raspberry" o bien en linux abrir el terminal y ejecutar el comando 'ssh pi@192.168.1.118'.  Ya estamos inmersos en la terminal y podemos entrar en la configuración mediante la siguiente línea de comandos.

`sudo raspi-config`

* Cambiamos la contraseña para el usuario "pi"
* Cambiamos la codificación al castellano (ES_ ES.UTF8)
* Cambiamos la hora a la de Madrid

```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install rpi-update
sudo rpi-update
```

Y hasta aquí el primer día, apagamos la Raspberry y mañana más...

[Algoentremanos]: http://algoentremanos.com/raspberry-pi-2-raspberry-pi-b-como-configurar-tu-nueva-raspberry-pi-sin-teclados-o-pantallas-extra
[Balena Etcher]: https://www.balena.io/?ref=etcher
[cable de red]: https://www.amazon.es/gp/product/B001U3ZRBS/ref=oh_aui_detailpage_o00_s01?ie=UTF8&psc=1
[fuente de alimentación]: https://www.amazon.es/gp/product/B01DDFFOYK/ref=oh_aui_detailpage_o00_s01?ie=UTF8&psc=1
[guía oficial]: https://www.raspberrypi.org/learning/hardware-guide
[Innerzaurus]: https://www.innerzaurus.com/diy/raspberry-pi/configurar-una-raspberry-pi-sin-monitor-ni-teclado
[PortScan]: http://www.the-sz.com/products/portscan
[Putty]: http://www.putty.org
[Raspberry]: https://www.amazon.es/gp/product/B01CD5VC92/ref=oh_aui_detailpage_o00_s01?ie=UTF8&psc=1
[Raspberry Pi OS]: https://www.raspberrypi.org/software/operating-systems/
[SD Card Formatter]: https://www.sdcard.org/downloads/formatter_4
[tarjeta micro sd]: https://www.amazon.es/gp/product/B013UDL58E/ref=oh_aui_detailpage_o00_s00?ie=UTF8&psc=1
[Win32 Disk Imager]: https://sourceforge.net/projects/win32diskimager

[Imagen_01]: /images/20180401_raspberry_montaje_ssh_01.jpg
[Imagen_02]: /images/20180401_raspberry_montaje_ssh_02.jpg
