---
title: "Errores de seguimiento de torrents en Synology con n8n"
date: "2025-04-22"
creation: "2025-04-22"
description: "Una forma sencilla y práctica de comprobar el seguimiento de los torrents conectados a trackers en Synology"
thumbnail: "images/20250422_n8n_synology_torrent_error_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "n8n"
- "telegram"
- "synology"
draft: true
weight: 5
---
Cuando usas [Download Station] para Synology una de las características que echas de menos es el control del seguimiento de torrents compartidos en trackers para saber cuando los puedes borrar de tu lista de propagación. Así me las apaño yo.
<!--more-->
[Download Station] es una utilidad de Synology para el control de descargas que es muy sencilla pero con un funcionamiento robusto. Para comprobar que un archivo que tengo en propagación está correctamente conectado al Tracker de Torrents del que ha sido descargado tengo que acceder manualmente a dicho archivo.

Cuando la conexión al tracker falla no existe una forma automatizada de saberlo por lo que me voy a apoyar en el log de la aplicación y una plantilla de [n8n] para hacerlo.

![image-01]

### Para que nos va a servir esta plantilla:
La única utilidad de esta plantilla en notificarnos, a través de un canal de Telegram, de los errores existentes en los archivos torrent en propagación gestionados por [Download Station]. Para esto se comprobará de forma remota el contenido del archivo "transmissiond.log" que genera la aplicación.

### Como funciona
- El primer paso es acceder al NAS mediante ssh para copiar el contenido del archivo "transmissiond.log" a una ubicación donde [n8n] lo pueda añalizar. Esto se realiza mediante un bloque de comando
``` bash
ssh sherlockes@192.168.10.200 "cat /volume1/@download/transmissiond.log" > /tmp/transmissiond.log
```
- Los siguientes dos bloques van a leer el archivo copiado y extraer el contenido del mismo.
- Mediante un bloque de código javascript y algo de regex vamos a extraer sólo las líneas relativas a errores con la conexión a los tracker
- Como el archivo puede ser muy grande limitamos a 10 el número de errores a notificar mediante otro bloque, de tipo "limit".
- Puesto que la plantilla se va a ejecutar una vez cada hora, vamos a incluir un filtro en el que sólo se muestren los errores aparecidos en la última hora. Esto lo haremos mediante un bloque "filter" y un poco de código en las condiciones
``` javascript
{{ (new Date(new Date().getTime() - 1 * 60 * 60 * 1000)).toISOString() }}
```
- Eliminamos posibles duplicados con otro bloque
- Creamos una lista en formato Markdown para poder enviar en Telegram mediante un bloque de código
``` javascript
// Escape simbols function
function escapeMarkdown(text) {
    return text
        .replace(/\\/g, "\\\\")
        .replace(/\*/g, "\\*")
        .replace(/\_/g, "\\_")
        .replace(/\[/g, "\\[")
        .replace(/\]/g, "\\]")
        .replace(/~/g, "\\~")
        .replace(/`/g, "\\`")
        .replace(/>/g, "\\>")
        .replace(/#/g, "\\#")
        .replace(/\+/g, "\\+")
        .replace(/=/g, "\\=")
        .replace(/\|/g, "\\|")
        .replace(/!/g, "\\!");
}

// Generate list with links
const formattedList = items.map(item => {
    const title = escapeMarkdown(item.json.file || "No title");
    const link = item.json.errorMessage || "#";

    // Telegram Markdown Format: [Text](URL)
    return `${title} - ${link} \n`;
}).join("\n"); // Join with line break

// Return generated list
return [{ json: { message: formattedList } }];
```
- Finalmente se envía el contenido a un canal de Telegram.

### Instrucciones de configuración
- En primer lugar necesitamos un acceso al NAS remoto desde el equipo en el que corre n8n. Este acceso se realiza mediante ssh y gracias a la llave publico-privada será posible sin el uso de contraseña.
- Para Telegram necesitamos tener configurada la credencial del bot que vamos a utilizar para mandar los mensajes a un canal determinado (El bot deberá estar como administrador en dicho canal). La id del canal al que se enviarán los mensajes queda configurada como una variable de entorno en el contenedor que hace correr n8n.
``` yaml
environment:
	- TG_NOTIF_ID=-XXXXXXXXXXXX
```

### Enlaces de interés
- [enlace](www.sherblog.pro)

[Download Station]: https://www.synology.com/es-es/dsm/packages/DownloadStation
[n8n]: https://n8n.io

[image-01]: /images/20250422_n8n_synology_torrent_error_01.jpg



