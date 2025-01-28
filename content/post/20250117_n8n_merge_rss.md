---
title: "Unir Rss y enviar a Telegram mediante n8n"
date: "2025-01-28"
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
### Para que nos va a servir esta plantilla:
Nos servirá para combinar varias fuentes de Rss, curar el contenido y enviar el resultado a un canal de Telegram donde será fácil de consultar.

![image-01]

### Como funciona:
- Partimos de dos fuentes rss de los que básicamente nos interesa extraer el título, enlace y fecha de publicación. Periódicamente, el flujo de trabajo va a consultar ambas fuentes y mediante expresiones regulares y algo de javascript se editarán varios campos hasta quedarnos con los deseados en el formato adecuado.
- Una vez formateadas las fuentes las combinaremos mediante el nodo "Merge"
- Puesto que el flujo de trabajo se va a ejecutar dos veces al día, despreciaremos los elementos que tengan más de dos días de antigüedad. Esto se realizará gracias a un nodo "Filter".
- Un nodo "Sort" será el encargado de ordenar los elementos por fecha de publicación para que nos aparezcan primero los más recientes.
- Para crear una lista plana en formato "Markdown" a partir de la serie de elementos resultantes vamos a usar una pequeña función en Javascript (Esta función deberá escapar los caracteres espaciales para que sean correctamente interpretados.
- Finalmente se enviará la lista al canal correspondiente mediante un nodo "Telegram"

### Instrucciones de configuración
- Cuando abramos el flujo de trabajo por primera vez deberemos configurar la credencial de Telegram.
- En los nodos "Rss" insertaremos las url de las fuentes que vamos a consultar.
- En los nodos "Edit Fields" deberemos ajustar las expresiones regulares para obtener el resultado deseado en función de nuestras fuentes Rss. En este caso yo he ajustado las expresiones para obtener el nombre, tamaño y enlace de cada archivo publicado.
- En el nodo "Sort" podemos modificar la antigüedad máxima de los elementos que vamos a enviar. En este caso, se han incluido 2 dias (2 * 24 * 60 * 60 * 1000 milisegundos) ya que es necesario tener en cuenta que Telegram tiene una longitud máxima de mensaje y si nos excedemos devolverá un error en lugar de enviarlo.
- Finalmente, incluiremos en el nodo "Telegram" la identificación del canal donde vamos a enviar los mensajes.

### Paso a paso
#### Schedule trigger
Gracias a este disparador ejecutamos el flujo se trabajo cada 8 horas

![image-01]

#### Read Rss
Este nodo se encarga de leer la fuente Rss y devolverla en forma de json que posteriormente vamos a analizar

![image-03]

#### Edit Fields
Estos nodos se encargan del curado de la información obtenida del Rss para sólo quedarnos con la parte que nos interesa

![image-04]

Gracias al uso de expresiones regulares resulta sencillo realizar la curación del contenido para finalmente tener un "nombre", "enlace" y "momento de publicación"

#### Merge Rss
Si más, este nodo une el contenido de la información obtenida de los distintos Rss en un solo json que vamos a seguir procesando.

#### Filter
La finalidad de este nodo es eliminar todos los elementos que tengan más de dos días de antigüedad aprovechando que la fecha de publicación está descrita en milisegundos.

![image-05]

#### Sort
Ordena los elementos por fecha de publicación dejando al principio los más recientes

![image-06]

#### Markdown list
Gracias a este bloque de código en javascript conseguimos convertir el json que nos devuelve el nodo anterior en una lista formateada en Markdown para enviar a Telegram. Es importante "escapar" caracteres especiales para que el texto sea correctamente interpretado.

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
    const title = escapeMarkdown(item.json.title || "No title");
    const link = item.json.link || "#";

    // Telegram Markdown Format: [Text](URL)
    return `[${title}](${link})`;
}).join("\n"); // Join with line break

// Return generated list
return [{ json: { message: formattedList } }];
```
#### Telegram
Finalmente ya sólo hay que enviar el texto a través de Telegram a un chat donde hayamos configurado nuestro bot.

![image-07]

Puedes navegar a través de todos estos nodos visitando la [plantilla de n8n].

[plantilla de n8n]: https://n8n.io/workflows/2748-merge-and-filter-several-rss-and-send-to-telegram/

[image-01]: /images/20250117_n8n_merge_rss_01.jpg
[image-02]: /images/20250117_n8n_merge_rss_02.jpg
[image-03]: /images/20250117_n8n_merge_rss_03.jpg
[image-04]: /images/20250117_n8n_merge_rss_04.jpg
[image-05]: /images/20250117_n8n_merge_rss_05.jpg
[image-06]: /images/20250117_n8n_merge_rss_06.jpg
[image-07]: /images/20250117_n8n_merge_rss_07.jpg
