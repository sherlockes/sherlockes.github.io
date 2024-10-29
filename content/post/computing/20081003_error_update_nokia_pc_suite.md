---
title: "Error al actualizar Nokia Pc Suite"
date: "2008-10-03"
creation: "2008-10-03"
description: "Error al actualizar Nokia Pc Suite"
#thumbnail: "images/titulo_00.jpg" # 300x200px
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "productividad"
draft: false
weight: 5
---
Todo funciona correctamente, puedes instalar programas en el teléfono, copiar archivos y hacer copias de seguridad de agenda y mensajes mediante "[Nokia Pc suite][1]" pero un buen día aparece un cartelillo junto al icono de este programa ofreciéndote una actualización del mismo. Seguro que no sabes que más te puede ofrecer pero te tiras a la piscina y le das a actualizar. Tremenda cagada, ya que de aquí en adelante lo único que vas a conseguir al conectar el teléfono via usb es un precioso mensaje de error que dice "Cannot install USB Phone parent".

Pierdes toda conexión con el teléfono y la reinstalación, desinstalación o la vuelta a la versión anterior de la aplicación no suponen más que una ingente pérdida de tiempo. La solución es rápida y sencilla, tan sólo hay que seguir los siguientes pasos.

1.- Desconecta el teléfono del ordenador.
     
2.- Desinstala todas las versiones de Nokia Pc Suite e instala sólo la última.
     
3.- No conectes el teléfono todavía.
     
4.- Ves a la carpeta "C:\Windows\System32\Drivers" (Deberás mostrar los archivos ocultos).
     
5.- Busca el archivo "WDF01000" y copialó a otra carpeta.
     
6.- Ahora borra "WDF01000" de la carpeta "System32\Drivers".
     
7.- Arranca "Nokia Pc Suite" y conecta el teléfono.

Espero que hayas encontrado esta solución y la hayas podido aplicar sin perder todo el tiempo que he perdido yo para después darme cuenta que la actualización no traía consigo ninguna mejora significativa.

 [1]: http://www.nokia.es/A4993027