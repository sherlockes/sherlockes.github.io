---
title: "Raspberry red y wifi"
date: "2018-04-02"
description: "Configurando en nuestra Raspberry Pi la Ip estáica dentro de nuestra red local y la red wifi"
thumbnail: "images/raspberry_logo.png"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Raspberry"
tags:
  - "Desarrollo"
draft: false
weight: 12
---
### Configurar red y wifi

Es interesante que la Raspberry arranque siempre con la misma dirección ip de red si queremos con ella automatizar algún servicio.  Para ello, en primer lugar hay que editar el archivo "/etc/dhcpcd.conf" mediante la instrucción <code>sudo nano /etc/dhcpcd.conf</code> e introduciremos al final las siguientes líneas (dependiendo de la configuración de la red y del router.

```
interface eth0

static ip_address=192.168.1.202/24
static routers=192.168.1.1
static domain_name_servers=192.168.1.1
```

  * Guardamos el archivo => Ctrl + o
  * Salimos del editor nano => Ctrl + x
  * Reiniciamos la Raspberry => sudo reboot
  * Nos logamos de nuevo a través de la nueva ip
  * Comprobamos que ha funcionado => ip a

Ahora vamos a intentar ir un paso más allá y configurar la conexión a la red a través del módulo integrado wifi que trae la Raspberry 3.  Para configurar la red inalámbrica hay que editar el archivo "/etc/wpa_supplicant/wpa_supplicant.conf"

```
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
```

y añadimos las siguientes líneas deacuerdo a la red wifi que nos queremos conectar.

```
network={
    ssid="elnombredetured"
    psk="elpassworddetured"
}
```

Ahora volvemos a editar el archivo "etc/dhcpcd.conf" y añadimos al final las siguientes líneas

```
interface wlan0

static ip_address=192.168.0.2/24
static routers=192.168.0.1
static domain_name_servers=192.168.0.1
```

  * Guardamos el archivo => Ctrl + o
  * Salimos del editor nano => Ctrl + x
  * Apagamos la Raspberry => sudo shutdown
  * Quitamos la alimentación de las Raspberry
  * Quitamos el cable de red
  * Conectamos de nuevo la alimentación
  * Nos logamos de nuevo a través de la misma ip que antes
  * Comprobamos que ha funcionado => ip a

Pues nada, ya tenemos la Raspberry con las conexiones de red configuradas para poder funcionar con o sin cable conectado al router.
