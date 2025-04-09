---
title: "Enviar enlaces desde telegram a hoarder y readeck mediante n8n"
date: "2025-04-09"
creation: "2025-04-04"
description: "Como enviar enlaces desde Telegram al mismo tiempo a los servidores de favoritos Hoarder y Readeck"
thumbnail: "images/20250404_n8n_tg_hoarder_readeck_00.jpg"
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
La forma más sencilla de guardar un favorito es reenviarlo a un canal de [Telegram] pero la organización allí es compleja. Vamos a crear una automatización en [n8n] que reenvíe estos enlaces a nuestras instalaciones de [Hoarder] y [Readeck].
<!--more-->
Hoarder y Readeck son gestores de marcadores de código abierto para organizar contenido web. Hoarder permite guardar enlaces, imágenes y más, con etiquetado automático basado en IA y un enfoque en autohospedaje. Readeck, se centra en simplicidad y privacidad, ofreciendo una interfaz limpia para guardar y clasificar artículos, imágenes o videos con etiquetas y notas. Ambos priorizan el control del usuario sobre sus datos, diferenciándose de opciones comerciales al ser personalizables, autohospedados y locales. Hoarder destaca por su versatilidad; Readeck, por su facilidad de uso.

Todavía no tengo claro con cual me voy a quedar así que estoy probando los dos durante una temporada. Ambos ofrecen una API a través de la cual se les pueden lanzar consultas y peticiones de forma automatizada.

Una vez más nos vamos a apoyar en [n8n] para realizar una automatización, en este caso la del guardado de favoritos.

### Para que nos va a servir esta plantilla:
Dispongo de un canal personal de [Telegram] en el que me guardo los enlaces interesantes que quiero guardar o leer en otro momento. La idea es que [n8n] se encargue de leer los nuevos enlaces añadidos a este canal y los envíe, a través de la correspondiente API a las instalaciones de [Hoarder] y [Readeck].

### Como funciona
- Puesto que mi servidor conde corre [n8n] no está siempre encendido, será un "Schedule Trigger" el que se encargue cada cierto tiempo si hay algún contenido nuevo en el canal de [Telegram] donde guardo los enlaces. Esta petición se realiza mediante "http request" y la API de [Telegram].
- A continuación, un bloque de código se encarga de filtrar todo lo que no sean hipervínculos.
En este momento el flujo se parte en dos de forma que se realizan procesos paralelos y similares para [Hoarder] y [Readeck].
- Se accede mediante la API correspondiente a una lista con todos los enlaces guardados en el servicio correspondiente.
- Un bloque de código se encarga de filtrar la lista de hipervínculos obtenidos de [Telegram] anteriormente de forma que sólo sigan adelante los que no estén ya guardados en el servicio.
- Finalmente, otro nodo "Http Request" se encarga de hacer uso de la API del servicio para guardar el enlace en el servicio correspondiente.

![image-01]

### Instrucciones de configuración
La plantilla hace uso de las variables de entorno que tengo declaradas en el archivo "docker-compose.yml" de [n8n] mediante un archivo ".env" externo. Estas son las variables que utilizo:
``` txt
# Telegram Bot Token Sherlink
TG_SHERLINK_BOT_TOKEN=4523891492:AAFBPE2TS4h8r2sNd7F4t8u7mQmd4AVzRuJow

# Id Telegram Channel Sherlink
TG_SHERLINK_ID=-1002349285684

# Readeck server
READECK_SERVER=http://readeck.midomain.com
READECK_API_KEY=xxxxxxxxxxxxx

# Hoarder server
HOARDER_SERVER=http://hoarder.midomain.com
HOARDER_API_KEY=xxxxxxxxxxxxxx
```

He realizado esta plantilla en la versión 1.85.4 de [n8n]


### Enlaces de interés
- [enlace](www.sherblog.pro)

[Hoarder]: https://hoarder.app
[Telegram]: https://telegram.org
[Readeck]: https://readeck.org

[image-01]: /images/20250404_n8n_tg_hoarder_readeck_01.jpg



