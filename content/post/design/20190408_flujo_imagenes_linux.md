---
title: "Flujo de imágenes en Linux"
date: "2019-04-08"
creation: "2019-04-08"
description: "Otro de mis post incrementales en el que voy a explicar mi modo de trabajo con imágenes en linux"
thumbnail: "images/20190408_flujo_imagenes_linux_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
  - "diseño"
  - "linux"
tags:
  - "gimp"
  - "gthumb"
  - "darktable"
  - "trimage"
  - "linux"
draft: false
weight: 5
---

## El origen de las imágenes
Las imágenes con las que suelo tratar más habitualmente tienen dos procedencias claramente diferenciadas.

### Capturas de pantalla
Cada vez que escribo un post para el blog me encuentro con que necesito incluir alguna imagen para el mismo.  Desde que uso Linux [Mint] el flujo ha cambiado notablemente ya que ahora uso simplemente la captura de pantalla nativa y [Gimp] para la edición.

1. Para capturar un area de pantalla al portapapeles uso el atajo de teclado `Ctrl + Mays + ImprPant` (Importante tenerlo punsado un segundo hasta que el cursor cambia por una cruz con la que seleccionar el area a capturar).  Para el caso de querer seleccionar una ventana entera `Ctrl + Alt + ImprPant`.  Si quieres saber más mira este artículo sobre [capturas] de pantalla en Ubuntu y derivados.  
![imagen_01]
1. Abro [Gimp] y pulso `Ctrl + Mays + v` para crear una nueva imagen a partir del portapapeles.
1. Edito lo necesario en la imagen (Recorte, niveles...)
1. Mediante el menú "Cuardar para la web..." ajusto finalmente la calidad, tamaño y formato de la imagen a exportar (Gracias a [atareao] por enseñarme a instalarlo mediante `sudo apt install gimp-plugin-registry`)
1. Renombro adecuadamente la imagen para dejarla con la estructura "20190408_titulo_02.jpg" y la guardo en la corresponiente carpeta para la publicación en el blog (/static/images).

Para el caso de imágenes dentro del post utilizo un ancho de 600 px y para la imagen de cabecera unas dimensiones de 300x200 px. Se que parecen unas dimensiones ridículas pero las considero que tienen una calidad  suficiente y no empeoran la experiencia de usuario consumiendo un gran ancho de banda. 

### Fotografías
Cuando la cámara digital [Sony] sale a pasear suele volver con al menos unas decenas de fotos. Atrás quedaron donde cada imagen que tomaba traía consigo un fuerte procesado digital en Photoshop. Ahora simplemente las encuadro (si lo necesitan) y en la que lo merece realizo unos ajustes simples. Para eso sigo los siguientes pasos. 

1. Durante mucho tiempo he estado descargando las imágenes desde la cámara a el pc mediante la conexión usb (La conexión wifi me pareció absurdamente lenta la primera vez que la usé y no he vuelto a emplearla) pero recientemente he puesto a trabajar al [NAS] a mi servicio mediante una tarea en [USB_Copy] que realiza una importación de fotos y vídeos desde la carpeta donde están las fotos en la cámara la la carpeta "fotos/00-importadas" del NAS.  
![imagen_03]  
Tan sencillo como configurar unos pocos parámetros con la cámara conectada al puerto usb frontal del [NAS] y en dos pasos lo tenemos listo.  
![imagen_04]  
De esta forma y tal y como lo hemos configurado, cada vez que la cámara se conecte al [NAS] este copiará todas las fotografías a la correspondiente carpeta compartida y eliminará las fotos de la cámara.  Un pitido al principio y al final de la tarea nos indicará que se ha realizado correctamente.
1. Cribado selectivo en [Gthumb]. Abro la carpeta donde he descargado las fotos ("00-importadas")y de una forma rápida desecho las que técnica o artisticamente no son útiles.  Para poder abrir en [Gthumb] la carpeta del NAS (fotos) donde voy a trabajar con las fotografías necesito montarla en el pc.  Gracias a [UGeek] he dado con un sencillo método en el que una sola línea de terminal `sshfs usuario@192.168.1.200:../../fotos/ Fotos` ejecutada en la carpeta personal hace que monte la carpeta "fotos" del NAS en la carpeta "home/usuario/Fotos" del pc.  Para desmontarla tan secillo como `fusermount -u ~/carpeta_montaje`.
1. Renombrado en Gthumb. Aunque la utilidad no es ninguna maravilla, este software permite renombrar varias imágenes a la vez siguiendo un patrón de forma rápida y sencilla. Personalmente uso el patrón del tipo "20190408 - descripción num.jpg" el cual consigo mediante la platilla `%D{ %Y%m%d } - descripcion ###%E` tal y como se puede ver en la siguiente imagen.  
![imagen_02]
1. Traslado a carpeta para procesar. Directamente en Gthumb con las imágenes que he seleccionado para renombrar las muevo a otra carpeta llamada "01-renombradas" donde pueden seguir dos caminos. 
   1. Las fotografías que sólo necesitan un recorte o encuadre con unos ajustes básicos lo realizo en Gthumb para después pasarlas a la carpeta "02-terminadas"
   1. Las que merecen unos ajustes un poco más avanzados los realizo con Darktable para terminar exportandolas a la carpeta "02-terminadas" 
1. Subir las imágenes terminadas a Google Photos. Hasta ahora lo realizo de forma manual, es decir, abro el servicio web en una pestaña del navegador y desde este selecciono las imágenes de la carpeta "02-terminadas". 
1. Archivar las imágenes en el NAS. Directamente con el gestor de archivos nuevo las imágenes desde la carpeta "02-terminadas" a la carpeta de archivo del NAS. 
1. Sincronizar el archivo con Amazon Photos. Gracias a la cuota de Amazon Prime es posible almacenar en sus servidores sin un sobrecoste todas las fotos que quieras. Con la ayuda de [Cloudsync] de Synology este paso es completamente transparente.
![imagen_05]

Todavía queda mucho margen de mejora y automatización por lo que, supongo este no será el método definitivo e iré actualizándolo a medida que lo vaya modificando.




[imagen_01]: /images/20190408_flujo_imagenes_linux_01.jpg
[imagen_02]: /images/20190408_flujo_imagenes_linux_02.jpg
[imagen_03]: /images/20190408_flujo_imagenes_linux_03.jpg
[imagen_04]: /images/20190408_flujo_imagenes_linux_04.jpg
[imagen_05]: /images/20190408_flujo_imagenes_linux_05.jpg

[atareao]: https://www.atareao.es/podcast/optimizar-imagenes/
[capturas]: https://www.atareao.es/ubuntu/realizar-una-captura-de-pantalla-en-ubuntu/
[Cloudsync]: https://www.synology.com/es-es/knowledgebase/DSM/help/CloudSync/cloudsync
[Gimp]: http://www.gimp.org.es/
[Gthumb]: https://wiki.gnome.org/Apps/Gthumb
[Mint]: https://linuxmint.com/
[NAS]: https://qloudea.com/synology-ds216plusii
[Sony]: https://www.sony.es/electronics/camaras-lentes-intercambiables/ilce-5000-kit
[UGeek]: https://ugeek.github.io/blog/post/2019-04-04--montando-carpetas-del-servidor-raspberry-en-tu-escritorio.html
[USB_Copy]: https://www.synology.com/es-es/knowledgebase/DSM/help/USBCopy/usbcopy_general
