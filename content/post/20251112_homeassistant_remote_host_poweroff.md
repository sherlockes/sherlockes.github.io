---
title: "Apagado remoto de un equipo desde Home Assistant"
date: "2024-11-16"
creation: "2024-11-12"
description: "Como he implementado un botón para encender y apagar un servidor remoto desde Home Assistant"
thumbnail: "images/20251112_homeassistant_remote_host_poweroff_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "home assistant"
tags:
- "ssh"
- "linux"
draft: true
weight: 5
---
Tengo un pequeño servidor local con [Ubuntu server] que quiero poder encender y apagar de forma remota. Así es como lo he conseguido un interruptor en mi panel de control de [Home Assistant].
<!--more-->
### Encendido remoto
Gracias al [WoL] el encendido remoto de un equipo es realmente sencillo. Lo primero es acceder a la bios del equipo y habilitar el "Wake On LAN". Cada fabricante lo tiene escondido en un menú diferente así que las capturas de pantalla seguramente no sirvan de ayuda.

> Además de WoL, si vas a usar el equipo como servidor, resulta imprescindible habilitar también desde la Bios en encendido automático para que el equipo vuelva a arrancar tras un corte de corriente.

Con esto, todavía no es posible arrancar el equipo mediante WoL ya que las distribuciones basadas en Debian requieren una configuración posterior de la interface de red. Empezaremos listando las interfaces de red para conocer el nombre y ver cual corresponde a la que tenemos activa.
``` bash
ip link show
```
El comando produce la siguiente salida:
``` bash
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000 link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp1s0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether 54:47:11:24:9d:fb brd ff:ff:ff:ff:ff:ff
3: enp2s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000 link/ether 54:43:0e:2a:9e:fc brd ff:ff:ff:ff:ff:ff
4: wlp0s20f3: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether b0:dc:ef:ca:9d:65 brd ff:ff:ff:ff:ff:ff
```
De lo anterior podemos deducir que la interface de red activa es "enp2s0" y pasaremos a analizarla con ethtool. Si no tenemos instalada la aplicación la instalaremos con ~sudo apt install ethtool~ y lanzaremos el análisis.
``` bash
sudo ethtool enp2s0
```

La salida que, en mi caso ha dado es la siguiente y en ella podemos ver como la opción "Wake-on" esta deshabilitada (disabled):
``` bash
PHYAD: 0
Transceiver: external
MDI-X: Unknown
Supports Wake-on: pumbg
Wake-on: d
Link detected: yes
```

Podemos habilitar WoL en el modo "magic packet" mediante el comando ~ethtool -s enp2s0 wol g~ y obtendremos la confirmación de que este modo se ha habilitado.
``` bash
  #+begin_src txt
    PHYAD: 0
    Transceiver: external
    MDI-X: Unknown
    Supports Wake-on: pumbg
    Wake-on: g
    Link detected: yes
```

Resulta que este método funciona pero no es persistente y después de un reinicio se desactiva el WOL por lo que hay que crear un script que lo active en cada reinicio del servidor.

 - Crear archivo "wol" ~sudo nano /etc/network/if-up.d/wol~

``` bash
  #!/bin/bash
  ethtool -s enp2s0 wol g
```
 - Permiso de ejecución ~sudo chmod +x /etc/network/if-up.d/wol~
 - Para ejecutar en cada reinicio editamos el crontab de root ~sudo crontab -e~ y añadimos la siguiente línea:
``` bash
@reboot /etc/network/if-up.d/wol	 
```
Ahora y tenemos el equipo listo para encenderlo de forma remota desde [Home Assistant]. Utilizaremos la integración [Wake on LAN] capaz de enviar un "magic packet" a un equipo remoto para encenderlo sin más necesidades que la MAC y la IP local de dicho equipo.

> Mediante el comando ~ip link show~ no sólo hemos visto el nombre de la interface de red, también podemos conocer la MAC de la misma.

Ahora necesitamos añadir un "switch" en el archivo "configuration.yaml" de [Home Assistant] mediante las siguientes línes:

```yaml
switch:
  - platform: wake_on_lan
    name: uber
    mac: 54:43:0e:2a:9e:fc
    host: 192.168.10.211
```
Añadimos el "switch" a nuestro panel de [Home Assistant] y listo para encender el servidor remoto.
![image-01]

### Apagado remoto
Llegados a este punto tenemos un equipo remoto que queremos apagar y un equipo donde tenemos instalado [Home Assistant]

En primer lugar necesitamos que para ejecutar el comando ~poweroff~ en el equipo remoto no se solicite contraseña. Seguimos los siguientes pasos

- Accedemos al equipo remoto mediante ssh ~ssh usuario@ip_remoto~
- Ejecutamos  en el equipo remoto ~sudo visudo~
- Añadimos la siguiente línea
``` bash
mi_usuario ALL=NOPASSWD:/sbin/poweroff
```

A continuación accedemos a la terminal de [Home Assistant] que deberemos tener instalada mediante el complemente [Advanced SSH & Web Terminal]

- Generamos una llave ssh ~ssh-keygen~ en el directorio "/config/ssh/id_rsa" y sin ningún tipo de contraseña
- Nos logeamos como superusuario ~sudo -i~
- Copiamos la "ssh-key" al equipo remoto ~ssh-copy-id -i /config/ssh/id_rsa.pub usuario@ip_remoto~

Ya sólo falta crear un "shell_command" y vincularlo al apagado del "switch" en el archivo "configuration.yaml" de [Home Assistant].


``` yaml
switch:
  - platform: wake_on_lan
    name: dever
    mac: 84:47:09:24:9e:fc
    host: 192.168.10.211
    turn_off:
      service: shell_command.turn_off_dever

shell_command:
  turn_off_dever: ssh -i /config/ssh/id_rsa -o StrictHostKeyChecking=no sherlockes@192.168.10.211 'sudo poweroff'

```



### Enlaces de interés
- [Ask Ubuntu](https://askubuntu.com/questions/191257/how-could-i-shutdown-a-remote-host-in-my-network-thru-ssh-with-a-local-host)
- [Home Assistant - Wake on LAN](https://www.home-assistant.io/integrations/wake_on_lan/)
- [Community HA - Remote shell command](https://community.home-assistant.io/t/running-a-shell-command-from-home-assistant-to-remote-linux-pc/135221/74)

[Advanced SSH & Web Terminal]: https://github.com/hassio-addons/addon-ssh
[Home Assistant]: https://www.home-assistant.io
[Ubuntu server]: https://ubuntu.com/download/server
[Wake on LAN]: https://www.home-assistant.io/integrations/wake_on_lan/
[WoL]: https://es.wikipedia.org/wiki/Wake_on_LAN

[image-01]: /images/20251112_homeassistant_remote_host_poweroff_01.jpg



