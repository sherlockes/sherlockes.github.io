---
title: "Modificando Pi-hole desde Home assistant"
date: "2022-01-01"
creation: "2025-05-13"
description: "Como añadir y quitar dominios de la lista negra de Pi-hole desde Home Assistant"
thumbnail: "images/20250513_home_assistant_pihole_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "home assistant"
tags:
- "bash"
- "pihole"
draft: true
weight: 5
---
No cabe duda de que [Pi-hole] es una utilidad brutal para la gestión de publicidad pero su [integración] con [Home Assistant] deja mucho que desear, ya que el único control que ofrece es la deshabilitación de la utilidad completa.
<!--more-->
### Que buscamos?
La finalidad es bastante sencilla, simplemente un interruptor en [Home Assistant] mediante el cual activemos o no el filtrado de una serie de dominios por parte de [Pi-hole]

> En mi caso lo utilizo para que los niños no puedan acceder a Youtube unos días y horas determinados.

Antes de seguir adelante, tener en cuenta que [Pi-hole] y [Home Assistant] están corriendo en dos máquinas distintas, sendas Raspberry, una con Raspbian y otra con HAOS. Es más, están corriendo en redes distintas, pero esto no es un problema gracias a [Zerotier].

### La estrategia
Puesto que la [integración] de [Pi-hole] para [Home Assistant] no lo permite, vamos a modificar el listado de dominios a filtrar desde la línea de comandos mediante un script que se ejecutará en la máquina que tiene [Pi-hole] pero que será lanzado mediante un interruptor o automatización en la máquina que corre [Home Assistant].

### Los Scripts
Vamos a partir de un archivo "youtube_blocklist.txt" en el que se incluirán todos los servidores que necesitamos filtrar. De esta forma, añadir o quitar un servidor es tan sencillo como editar este archivo. Pepe

``` bash
youtube.com
www.youtube.com
m.youtube.com
youtubei.googleapis.com
youtube.googleapis.com
ytimg.com
yt3.ggpht.com
```

#### Bloquear los dominios "youtube_block.sh"
Esta parte es sencilla, crearemos un archivo "youtube_block.sh" al que dotaremos de permisos de ejecución y con el siguiente contenido:

``` bash
#!/bin/bash
DOMAINS=$(cat ~/youtube_blocklist.txt)
pihole deny $DOMAINS
```

Cuando se ejecute el script todos los dominios que aparezcan en el listado serán bloqueados

#### Desbloquear los dominios "youtube_unblock.sh"
Desde la versión 6 de [Pi-hole] esto se ha complicado un poco y es que ya no permite eliminar el bloqueo a dominios desde la línea de comandos. La forma de atacar este problema es mediante la modificación directa de la base de datos donde [Pi-hole] guarda los dominios bloqueados.

``` bash
#!/bin/bash
DB="/etc/pihole/gravity.db"
while read domain; do
    sqlite3 "$DB" "DELETE FROM domainlist WHERE type=1 AND domain = '$domain';"
done < /home/pi/youtube_blocklist.txt

# Recargar listas
pihole reloadlists
```

> Esto requiere que "sqlite3" esté instalada en la máquina que corre [Pi-hole] y que el script anterior se ejecute con privilegios de administrador.

### Lanzar los scripts desde Home Assistant
Ya tenemos pues los Scripts que van a añadir o quitar los dominios del filtrado, ahora tenemos que poder ejecutarlos desde nuestra máquina con [Home Assistant].

A continuación accedemos a la terminal de [Home Assistant] que deberemos tener instalada mediante el complemento [Advanced SSH & Web Terminal]

- Generamos una llave (En caso de que no la hayamos creado anteriormente) ssh `ssh-keygen` en el directorio "/config/ssh/id_rsa" y sin ningún tipo de contraseña
- Nos logeamos como superusuario `sudo -i`
- Copiamos la "ssh-key" al equipo remoto `ssh-copy-id -i /config/ssh/id_rsa.pub usuario@ip_remoto`

Ya sólo falta crear un "shell_command" dentro del archivo de configuración "configuration.yaml"

``` yaml
shell_command:
  co_youtube_block: ssh -i /config/ssh/id_rsa -o StrictHostKeyChecking=no pi@192.168.191.205 './youtube_block.sh'
  co_youtube_unblock: ssh -i /config/ssh/id_rsa -o StrictHostKeyChecking=no pi@192.168.191.205 'sudo ./youtube_unblock.sh'
```

En este momento y tras un reinicio ya podemos lanzar los comandos de consola desde [Home Assistant]. Ahora crearemos un nuevo

AYUDANTE

``` yaml
alias: co_youtube_block
description: ""
triggers:
  - trigger: state
    entity_id:
      - input_boolean.co_youtube_block
    to: "on"
    id: activar
  - trigger: state
    entity_id:
      - input_boolean.co_youtube_block
    to: "off"
    id: desactivar
conditions: []
actions:
  - choose:
      - conditions:
          - condition: trigger
            id:
              - activar
        sequence:
          - action: shell_command.co_youtube_block
            metadata: {}
            data: {}
      - conditions:
          - condition: trigger
            id:
              - desactivar
        sequence:
          - action: shell_command.co_youtube_unblock
            metadata: {}
            data: {}
mode: single
```



![image-01]

### Enlaces de interés
- [enlace](www.sherblog.es)

[Advanced SSH & Web Terminal]: https://github.com/hassio-addons/addon-ssh
[Home Assistant]: https://www.home-assistant.io
[integración]: https://www.home-assistant.io/integrations/pi_hole/
[Pi-hole]: https://pi-hole.net
[Zerotier]: /instalación-y-configuración-de-zerotier/


[image-01]: /images/20250513_home_assistant_pihole_01.jpg



