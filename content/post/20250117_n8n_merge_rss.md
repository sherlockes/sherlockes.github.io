---
title: "Unir Rss y enviar a Telegram mediante n8n"
date: "2025-01-17"
creation: "2025-01-17"
description: "Como obtener la info de de varios rss y enviar un resumen combinado a Telegram"
thumbnail: "images/20250117_n8n_merge_rss_00.jpg"
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
Combinar varios rss y enviar el resultado filtrado a Telegram sin apenas escribir código es coser y cantar gracias a n8n.
<!--more-->
Aquí dejo la plantilla que he enviado a n8n.

## Para que nos va a servir esta plantilla:
Nos servirá para combinar varias fuentes de Rss, curar el contenido y enviar el resultado a un canal de Telegram donde será fácil de consultar.

## Como funciona:
- Partimos de dos fuentes rss de los que básicamente nos interesa extraer el título, enlace y fecha de publicación. Periódicamente, el flujo de trabajo va a consultar ambas fuentes y mediante expresiones regulares y algo de javascript se editarán varios campos hasta quedarnos con los deseados en el formato adecuado.
- Una vez formateadas las fuentes las combinaremos mediante el nodo "Merge"
- Puesto que el flujo de trabajo se va a ejecutar dos veces al día, despreciaremos los elementos que tengan más de dos días de antigüedad. Esto se realizará gracias a un nodo "Filter".
- Un nodo "Sort" será el encargado de ordenar los elementos por fecha de publicación para que nos aparezcan primero los más recientes.
- Para crear una lista plana en formato "Markdown" a partir de la serie de elementos resultantes vamos a usar una pequeña función en Javascript (Esta función deberá escapar los caracteres espaciales para que sean correctamente interpretados.
- Finalmente se enviará la lista al canal correspondiente mediante un nodo "Telegram"

## Instrucciones de configuración
- Cuando abramos el flujo de trabajo por primera vez deberemos configurar la credencial de Telegram.
- En los nodos "Rss" insertaremos las url de las fuentes que vamos a consultar.
- En el nodo "Sort" podemos modificar la antigüedad máxima de los elementos que vamos a enviar. Es necesario tener en cuenta que Telegram tiene una longitud máxima de mensaje.
- Finalmente, incluiremos en el nodo "Telegram" la identificación del canal donde vamos a enviar los mensajes.

The rest of the information is available at  [sherblog.es](https://sherblog.es/de-strava-a-google-sheets-gracias-a-n8n/)

Template was created in n8n v1.72.1

![image-01]

### Enlaces de interés
- [enlace](www.sherblog.pro)

[link]: https://www.google.es

[image-01]: /images/20250117_n8n_merge_rss_01.jpg



