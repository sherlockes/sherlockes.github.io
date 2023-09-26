---
title: "Instalación de Moodle en Raspberry Pi"
date: "2020-02-15"
description: "La forma que he usado para crear un servidor de Moodle a partir de una modesta Raspberry Pi 3 Model B."
thumbnail: "images/20200215_raspberry_moodle_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "raspberry"
tags:
  - "moodle"
draft: false
weight: 5
---
El desarrollo...
Recientemente he probado [Moodle] como plataforma para publicar cursos y me ha parecido una plataforma extremadamente potente. Aquí no voy a desgranar las posibilidades del mismo sino más bien el proceso de como he montado la plataforma sobre una [Raspberry Pi 3 Model B] gracias a [MoodleBox].
<!--more-->

### Instalación de Moodle
Sin duda alguna, la forma más sencilla de instalar [Moodle] en una Raspberry es mediante el uso de [moodleBox] ya que la propia distribución nos crea un servidor de Moodle sobre una distribución de Raspbian Lite listo para funcionar. Tan sencillo como grabar la [imagen] descargada en una MicroSd y arrancar la Raspberry.

### Conexión mediante Wifi
Tras arrancar la Raspberry, seleccionaremos la red wifi "MoodleBox" en el dispositivo desde el que nos queremos conectar, usando como contraseña "moodlebox" para conectarnos a la red que la propia Raspberry está generando. Una vez conectado accederemos desde el navegador a "http://moodlebox.home" para acceder al portal de Moodle. Si la Raspberry está conectada a internet a través de ethernet, esta hará de router y los dispositivos conectados a la red wifi "MoodleBox" tambien tendrán acceso a internet a través de la propia Raspberry.

### Conexión mediante ethernet
Para poder acceder mediante cable ethernet al portal de Moodle de nuestra raspberry antes tenemos que modificar con un editor de texto y privilegios de administrador el archivo "hosts" de nuestro pc.

- En windows está ubicado en "c:\windows\system32\drivers\etc\hosts"
- En linux está ubicado en "\etc\hosts"

En este archivo deberemos añadir las siguientes líneas
```
# MoodleBox connection via Ethernet
# MoodleBox must get an ip address via dhcp
192.168.1.201 moodlebox.home  moodlebox
```

donde "192.168.1.201" es la ip que el router le ha asignado a la raspberry.

> Si no sabes como averiguar la IP de tu raspberry te remito al [post](https://sherblog.pro/raspberry-red-y-wifi/) en que tengo descrito como hacerlo tanto en windows como en linux.

Con este cambio realizado ya podremos aceder a la dirección "http://moodlebox.home/" desde nuestro navegador para acceder al portal de Moodle.

### Conexión mediante ssh
Por defecto, la ip de la Raspberry no es estática, lo cual supone que, dependiendo de la asignación del router, en un arranque posterior puede adquirir una ip distinta. Para evitarlo tendremos que conectarnos via ssh a la Raspberry (De la que ahora sabemos la ip tal y como hemos visto en el apartado anterior) y modificar el archivo “/etc/dhcpcd.conf” modificando las siguientes líneas:

```
# Example static IP configuration:
interface eth0
static ip_address=192.168.1.201/24
#static ip6_address=fd51:42f8:caae:d92e::ff/64
static routers=192.168.1.1
static domain_name_servers=192.168.1.1 8.8.8.8

```

donde 192.168.1.1 es la ip de nuestro router y 192.168.1.201 la ip de la Raspberry.

Para poder realizar esta modificación nos deberemos conectar via ssh

- En windows usando [Putty] con "modlebox" de usuario y "Moodlebox4$" de pass
- En linux mediante "ssh moodlebox@192.168.1.201" y "Moodlebox4$" de pass

### Conexión desde internet
[MoodleBox] está pensado para que la Raspberry esté colocada en clase y los alumnos se conecten a ella via wifi, al termino de la clase, la Raspberry se apaga y va al bolsillo del profesor. ¿Pero, que pasa si queremos dejar la Raspberry en casa del profesor y que los alumnos accedan a ella desde sus propias casas? La operación es un poco más laboriosa, pero perfectamente funcional siguiendo los siguientes pasos:

- En primer lugar necesitamos **crear un DNS dinámico** que apunte a la dirección IP publica de nuestro router a pesar de que esta pueda variar. Personalmente utilizo el servicio gratuito [Noip] en el que crearemos un "Hostname" (Se pueden crear hasta tres de forma gratuita) que apunte a la Ip pública de nuestro router. En mi caso he creado "locasporlaquimica.ddns.net" tal y como se puede ver en la siguiente imagen.

![imagen_01]

Con esto no vale, ya que en el momento que cambie la dirección pública del router alguien se lo tendrá que decir a Noip. Para esto, los routers actuales tienen la opción de configurar varios servicios de servidores dinámicos de nombres desde el panel de control.

![imagen_03]

- Es **necesario redireccionar** el tráfico de internet que llegue a nuestro router a través del puerto 80 (http) a la ip de nuestra raspberry para lo que tendremos que abrir el puerto 80 desde el panel de control de nuestro router. Cada fabricante es un mundo pero, como referencia del resultado, en mi "Orange LiveBox Fibra" queda tal que así.

![imagen_02]

- Hay que cambiar el nombre de dominio para que [MoodleBox] sea visible desde [internet] con el nombre que en micaso es "locasporlaquimica.ddns.net" para lo que hay que modificar "moodlebox" por "locasporlaquimica.ddns.net" en unos cuantos archivos.

	- En la última línea de "/etc/hosts"
	- En "/etc/hostname"
	- En la directiva "server_name" de "/etc/nginx/sites-available/default" Config NGinx
	- En las variables "domain" y "local" de "/etc/dnsmasq.conf"
	- En "/var/www/moodle/config.php" en la variable de conf "wwwroot"
	
Tras esto debe reiniciarse la raspberry y acceder a la dirección http://locasporlaquimica.ddns.net/admin/tool/replace/index.php para hacer las modificaciones en la base de datos de Moodle mediante la utilidad de reemplazo de cadenas.

Y con esto la instalación de [Moodle] sobre la Raspberry ya debería ser visible desde internet.

[ethernet]: https://moodlebox.net/en/help/how-to-access-the-moodlebox-via-ethernet/
[imagen]: https://moodlebox.net/en/help/download-the-disk-image/
[internet]: https://moodlebox.net/en/help/access-from-internet/
[Moodle]: https://moodle.org/?lang=es
[MoodleBox]: https://moodlebox.net/en/
[Noip]: https://www.noip.com/
[Putty]: https://www.putty.org/
[Raspberry Pi 3 Model B]: https://www.raspberrypi.org/products/raspberry-pi-3-model-b/

[imagen_01]: /images/20200215_raspberry_moodle_01.jpg
[imagen_02]: /images/20200215_raspberry_moodle_02.jpg
[imagen_03]: /images/20200215_raspberry_moodle_03.jpg
