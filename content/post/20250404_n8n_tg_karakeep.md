---
title: "Enviar enlaces desde telegram a hoarder y readeck mediante n8n"
date: "2026-01-05"
creation: "2025-04-04"
description: "Como enviar enlaces desde Telegram al mismo tiempo a los servidores de favoritos Hoarder y Readeck"
thumbnail: "images/20250404_n8n_tg_karakeep_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "n8n"
draft: true
weight: 5
---
La forma más sencilla de guardar un favorito es reenviarlo a un canal de [Telegram] pero la organización allí es compleja. Vamos a crear una automatización en [n8n] que reenvíe estos enlaces a nuestra instalación de [Karakeep].
<!--more-->
[Karakeep] es un gestor de marcadores de código abierto para organizar contenido web que permite guardar enlaces, imágenes y más, con etiquetado automático basado en IA y un enfoque en autohospedaje. Prioriza el control del usuario sobre sus datos, diferenciándose de opciones comerciales al ser personalizables, autohospedados y locales.

Una vez más nos vamos a apoyar en [n8n] para realizar una automatización, en este caso la del guardado de favoritos.

### Para que nos va a servir esta plantilla:
Dispongo de un canal personal de [Telegram] en el que me guardo los enlaces interesantes que quiero guardar o leer en otro momento. La idea es que [n8n] se encargue de leer los nuevos enlaces añadidos a este canal y los envíe, a través de la correspondiente API a la instalación de [Karakeep].

{{< n8n_workflow src="/workflows/telegram_karakeep.json" >}}

### Enlace con Karakeep
En un principio usé el nodo "http request" pero después di con el nodo de la comunidad de n8n [n8n-nodes-karakeep] que permite añadir las credenciales de [karakeep] a la instancia de [n8n] y de esta forma hacer el proceso mucho más sencillo. 

### Como funciona
- Puesto que mi servidor conde corre [n8n] no está siempre encendido, será un "Schedule Trigger" el que se encargue cada cierto tiempo si hay algún contenido nuevo en el canal de [Telegram] donde guardo los enlaces. Esta petición se realiza mediante "http request" y la API de [Telegram].
- A continuación se extrae una lista de url's con los enlaces incluidos en los nuevos mensajes.
- Para cada uno de los enlaces, se normaliza y busca coincidencias en la base de datos de karakeep.
- En caso de existir coincidencias se pasa al siguiente enlace, si no hay coincidencias se guarda en [Karakeep] y se informa del guardado mediante un mensaje de Telegram.

![image-01]

### Instrucciones de configuración
La plantilla hace uso de las variables de entorno que tengo declaradas en el archivo "docker-compose.yml" de [n8n] mediante un archivo ".env" externo. Estas son las variables que utilizo:
``` txt
# Telegram Bot Token Sherlink
TG_SHERLINK_BOT_TOKEN=**********:*************************************

# Id Telegram Channel Sherlink
TG_SHERLINK_ID=-*************
```

He realizado esta plantilla en la versión 1.123.5 de [n8n]


### Enlaces de interés
- [n8n-nodes-karakeep](https://github.com/technovangelist/n8n-nodes-karakeep)

[Karakeep]: https://karakeep.app/
[n8n]: https://n8n.io
[n8n-nodes-karakeep]: https://github.com/technovangelist/n8n-nodes-karakeep
[Telegram]: https://telegram.org

[image-01]: /images/20250404_n8n_tg_hoarder_readeck_01.jpg



