---
title: "Automatizando la limpieza de Gmail"
date: "2020-11-29"
creation: "2016-10-14"
description: "La mejor forma de tener la bandeja de entrada los más despejada posible es dedicarle un tiempo o automatizar la limpieza.  Así lo hago en Gmail"
thumbnail: "images/20161014_promociones_05.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "productividad"
tags:
  - "gmail"
draft: false
weight: 5
---
Si eres de los que realiza compras en internet, no te importa recibir ofertas, usas Gmail como gestor de correo electrónico y usas la pestaña "Promociones" creo que este artículo te va a interesar.

<!--more-->

### El problema

Haciendo una estimación aproximada, creo que recibo un correo electrónico cada menos de dos horas de las tiendas y servicios online que utilizo. Estos son mensajes que van directamente a la pestaña "Promociones" de Gmail por lo que no me molestan con continuas notificaciones.

![imagen][1]

Para mi, todos estos son mensajes de segunda categoría, es decir, no pasa nada si alguno se queda sin leer y no los leo a diario. Por esto tienden a acumularse y la mayoría de ellos cuando los lees ya no tienen relevancia puesto que suelen ser promociones temporales. Me resulta muy fácil acumular cientos de mensajes en esta pestaña y de vez en cuando tengo que perder tiempo en borrar los antiguos. Para ello utilizo un filtro que me busque todos los mensajes de la pestaña promociones con mas de diez días en la bandeja de entrada, los selecciono y los borro.

![imagen][2]

Cierto es que esta operación supone un gasto de tiempo pequeño, pero me pregunto... ¿Podrá automatizarse esto? Pues si, y de una forma bastante sencilla usando [Google Apps Script][11]. Tan sencillo como entrar en [Google Drive][12] y crear un nuevo "Google Apps Script".

![imagen][3]

Aparece un nuevo proyecto en blanco en el que incluiremos la siguiente función:

```
function limpiar_propaganda() {
  var filtro = GmailApp.search('category:promotions older_than:10d');
  for (var i = 0; i < filtro.length; i++) {
    filtro[i].moveToTrash();
  }
}
```

Por otro lado tengo definida un par de reglas en la configuración de gmail para los correos "menos importantes" que se pueden borrar sin ningún problema pasados diez días después de su recepción y que etiquetará como "notificarme".

![imagen-06]

Ahora sólo resta añadir un segundo bucle "for" en el script para busque los mensajes de correo con la etiqueta "notificarme" y una antigüedad mayor de diez días para proceder a eliminarlos.  De esta forma el script completo quedará como lo siguiente.

```
function limpiar_propaganda() {
  var filtro = GmailApp.search('category:promotions older_than:10d');
  for (var i = 0; i < filtro.length; i++) {
    filtro[i].moveToTrash();
  }
  var filtro = GmailApp.search('label:notificarme older_than:10d');
  for (var i = 0; i < filtro.length; i++) {
    filtro[i].moveToTrash();
  }
}
```

Lo guardamos, le damos nombre y fijamos los activadores del proyecto activo a una ejecución por hora o lo que cada uno considere adecuado.

![imagen][4]

A partir de ahora y de forma automática, cada hora se borrarán los correos con promociones o la etiqueta "notificarme" de más de diez días de antigüedad.

[1]: /images/20161014_promociones_01.jpg
[2]: /images/20161014_promociones_02.jpg
[3]: /images/20161014_promociones_03.jpg
[4]: /images/20161014_promociones_04.jpg
[imagen-06]: /images/20161014_promociones_06.jpg

[11]: https://www.google.com/script/start/
[12]: https://drive.google.com/drive/u/0/my-drive
