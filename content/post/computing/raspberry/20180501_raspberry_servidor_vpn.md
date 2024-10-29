---
title: "Raspberry Servidor VPN"
date: "2018-04-11"
creation: "2018-04-11"
description: "No te das cuenta de lo útil que es hasta que no utilizas la Raspberry con el servidor vpn."
thumbnail: "images/20180501_raspberry_vpn.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Raspberry"
tags:
  - "desarrollo"
draft: false
weight: 15
---
### Instalando un servidor VPN

Una de las grandes funcionalidades que nos puede ofrecer nuestra Raspberry Pi es como servidor VPN el cual tiene dos finalidades fundamentales.

* Acceder de forma segura a nuestra red local desde fuera de ella
* Conseguir una navegación segura en redes wifi públicas

```
sudo apt update
sudo apt upgrade
curl -L https://install.pivpn.io | bash
```

Para los detalles de las opciones de configuración durante la instalación tan sólo hay que visitar la web de [El Atareao](https://www.atareao.es/tutorial/raspberry-pi-primeros-pasos/acceder-a-la-red-local-desde-fuera) donde lo explica pormenorizadamente.

Tras la instalación y reiniciar la Raspberry hay que crear un nuevo cliente mediánte el comando

```
pivpn add
```

Nos pedirá un nombre de usuario y contraseña y generará un archivo \*ovpn en la carpeta "ovpns" dentro del "home" de nuestro usuario.  Sólo resta copiar este archivo al terminal desde el que nos queremos conectar y usar el nombre de usuario y contraseña que hemos seleccionado.
