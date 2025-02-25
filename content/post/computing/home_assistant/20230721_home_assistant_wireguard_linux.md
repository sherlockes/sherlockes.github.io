---
title: "Configurar Wireguard de Home Assistant en cliente linux"
date: "2025-02-25"
creation: "2023-07-21"
description: "Como conectar a la vpn de nuestro servidor de Wireguar en Home Assistant desde un cliente en linux."
thumbnail: "images/20230721_home_assistant_wireguard_linux_00.png"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
- "home assistant"
tags:
- "wireguard"
- "bash"
draft: false
weight: 5
---
Por su sencillez y efectividad, tengo instalado el servidor de [Wireguard] como un complemento de [Home Assistant]. Esta es la forma de como he configurado un cliente linux para conectarse a la vpn desde el exterior de mi red local.
<!--more-->
### Acceso ssh a Home Assistant
Antes de seguir adelante, hay que tener instalado "Terminal & SSH", el addon oficial de [Home Assistant] para acceder via ssh a nuestra instalación de [Home Assistant] y el servidor de [Wireguard] que nos va a posibilitar la conexión vpn hacia el mismo.

![image-02] ![image-03]

Además dota a nuestro servidor domótico de una terminal a la que podemos acceder desde el propio navegador

![image-01]

> Una peculiaridad de mi instalación es que muestra dos IP's por lo que el servidor de ssh lo he tenido que configurar en el puerto 222. De esta forma, mediante una ip y el puerto 222 acederemos a HA y mediante la otra ip y el puerto 22 accederemos a la máquina donde está instalado el contenedor.

Para poder acceder al servidor de [Home Assistant] via ssh sin tener que introducir todas las veces la contraseña configuramos la clave público-privada copiando la llave de nuestra máquina cliente.

```
ssh-copy-id -p 222 -i ~/.ssh/id_rsa root@192.168.10.38
```

> Si la llave del equipo está generada previamente sólo hay que copiarla, en caso contrario habrá que generarla primero.

### Creando un nuevo cliente de conexión
Ahora ya podemos desde la máquina remota en la que queremos instalar la vpn para lo cual añadimos un nuevo perfil de conexión en la configuración del addon de [Home Assistant] dentro del los "peers".

```yaml
- name: Thinkpad
  addresses:
    - 172.27.66.5
  allowed_ips: []
  client_allowed_ips: []
```

Al reiniciar el plugin se creará un nuevo cliente de conexión con un archivo de configuración dentro del directorio "/ssl/wireguard/Thinkpad/client.conf" del servidor de [Home Asistant] que a continuación copiaremos a nuestra máquina cliente.

### Instalando Wireguard en en cliente
Gracias a un post de [AlexPro] resulta sencillo configurar [Wireguard] en la máquina linux desde la que queremos acceder a nuestro servidor sin mas que seguir estos pasos.

- Instalar [Wireguard]
- Instalar resolvconf
- Copiar el archivo de configuración al directorio "/etc/wireguard"
- Arrancar la conexión

```bash
sudo apt install wireguard
sudo apt install resolvconf
```

Para copiar el archivo de configuración hay que afinar un poco con el comando

```bash
sudo scp -P 222 root@192.168.10.38:/ssl/wireguard/Thinkpad/client.conf /etc/wireguard/mivpn.conf 
```

> Atención que con este comando estamos copiando vía scp a través del puerto 222 (La "P" tiene que ser mayúscula) el archivo "client.conf" desde el servidor de Wireguard hasta la máquina donde hemos instalado el cliente. Nos pedirá la contraseña del usuario de la máquina cliente donde estamos ejecutando el comando y posteriormente la de "root" del servidor ssh de Home Assistant que hemos configurado en el correspondiente Addon.

Arrancaremos la conexión mediante el comando `sudo wg-quick up mivpn` y la cerraremos con `sudo wg-quick down mivpn`, aunque no son comandos complicados puede llegar a ser un poco latoso tener que escribir todo el comando por lo que lo vamos a simplificar mediante un par de Alias.

### Establecer alias para iniciar o cerrar la conexión
Tal y como tengo apuntado en mi chuleta personal, para la creación de estos dos alias, uno para el encendido y otro para el apagado, seguiremos los siguientes pasos.

- Comprobar si existe el archivo ~/.bash_aliases
- Editar el archivo ~/.bashrc si no existe el anterior
- Añadir el nuevo alias de encendido -> alias vpnon='sudo wg-quick up mivpn'
- Añadir el nuevo alias de apagado -> alias vpnoff='sudo wg-quick down mivpn'
- Habilitar los cambios -> source ~/.bashrc

> Cuidado con las comillas al copiar los comandos, deben ser las simples verticales.

Con esto, la fricción se ha reducido bastante aunque todavía nos queda el inconveniente de que tenemos que introducir la contraseña del usuario cada vez que ejecutemos el alias puesto que en su interior alberga un "sudo"

### Evitando la contraseña en el alias
Para que el sistema no nos pida la contraseña de nuestro usuario cada vez que ejecutamos cualquiera de los dos alias que hemos creado anteriormente ejecutaremos el comando `sudo visudo` y añadiremos al final la siguiente línea

```bash
tu_usuario ALL=(ALL) NOPASSWD: /usr/bin/wg-quick
```

Ya sólo hay que reiniciar el equipo, o simplemente la sesión del usuario, y podremos ejecutar en un terminal el comando `vpnon` sin que se ñ¡nos pida ninguna contraseña y con ello arrancar la conexión vpn hacia el servidor inatalado en la máquina de [Home Assistant].

### Enlaces de interés
- [Ostechnix - Command without sudo](https://ostechnix.com/run-particular-commands-without-sudo-password-linux/)
- [StackOverflow - Scp with especific port](https://stackoverflow.com/questions/10341032/scp-with-port-number-specified)
- [StackExchange - Copy files via ssh](https://unix.stackexchange.com/questions/106480/how-to-copy-files-from-one-machine-to-another-using-ssh)
- [Linuxize - Change ssh port](https://linuxize.com/post/how-to-change-ssh-port-in-linux/)
- [LinuxHandBook - Sudo without password](https://linuxhandbook.com/sudo-without-password/)

[Home Assistant]: https://www.home-assistant.io
[Wireguard]: https://www.wireguard.com
[AlexPro]: https://alexpro.sytes.net/cliente-wireguard-linux/

[image-01]: /images/20230721_home_assistant_wireguard_linux_01.jpg
[image-02]: /images/20230721_home_assistant_wireguard_linux_02.jpg
[image-03]: /images/20230721_home_assistant_wireguard_linux_03.jpg
