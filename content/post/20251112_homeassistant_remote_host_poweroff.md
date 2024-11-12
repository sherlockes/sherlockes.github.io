---
title: "Apagado remoto de un equipo desde Home Assistant"
date: "2024-11-12"
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
Resumen de introducción
<!--more-->

``` yaml
switch:
  - platform: wake_on_lan
    name: dever
    mac: 84:47:09:24:9e:fc
    host: 192.168.10.211
    turn_off:
      service: shell_command.turn_off_dever

shell_command:
  turn_off_dever: ssh -i /config/ssh/id_rsa -o UserKnownHostsFile=/config/ssh/known_hosts sherlockes@192.168.10.211 'sudo poweroff'
```

![image-01]

### Enlaces de interés
- [enlace](www.sherblog.pro)

[link]: https://www.google.es

[image-01]: /images/20251112_homeassistant_remote_host_poweroff_01.jpg



