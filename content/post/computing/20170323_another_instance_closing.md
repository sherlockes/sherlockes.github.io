---
title: "Another instance is currently closing… Portable app error"
date: "2017-03-23"
creation: "2017-03-23"
description: "Un dolor de cabeza con algunas aplicaciones portables"
thumbnail: "images/20170322_another_instance_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "productividad"
draft: false
weight: 5

---
Atrás han quedado los años en los que probaba e instalaba una ingente cantidad de programas en el pc que luego en su mayoría no empleaba y dejaban tras de sí restos de la instalación.

Ahora intento utilizar programas "portables" que, aunque no estoy seguro, entiendo que son más limpios al no dejar tras de si restos de los archivos de instalación.  Uno de los que utilizo bastante es Google Earth con el que recientemente he tenido un pequeño problema ya que al intentar ejecutarlo me ha salido el siguiente cuadro de diálogo.

![imagen][1]

No hace falta ser un erudito en la lengua de Shakespeare para darse cuenta de que el problema es que hay otra instancia del mismo programa que se está intentando cerrar actualemnte (o eso es lo que piensa el sistema operativo).  Abro el administrador de tareas y&#8230; nada, no se está ejecutando otra versión de Google Earth así que opto por la principal solución en informática, reiniciar¡¡¡

El reinicio no produce ninguna diferencia sustancial y al volver a arrancar windows e intentar lanzar el programa el error persiste por lo cual toca buscar un poco por la red.

Aunque el encontrar una solución me lleva un tiempo resulta un éxito, ya que funciona perfectamente el primer remedio que encuentro. Dentro de la carpeta "Data" podemos encontrar un archivo de congiguración con el nombre "PortableApps.comLauncherRuntimeData-GoogleEarthPortable".

![imagen][2]

Si abrimos con el bloc de notas o cualquier editor de texto el archivo podremos ver algo como lo siguiente:
```
<p style="padding-left: 30px;">
  <code><br/>
[PortableApps.comLauncher]<br/>
Status=stopping<br/>
PluginsDir=C:/users/AppData/Local/Temp/nso5C00.tmp<br/>
[FailedRegistryKeys]<br/>
-=true<br/>
</code>
</p>
```

Pues bien, la solución a nuestro problema pasa por cambiar en la segunda línea la palabra "stopping"por "stopped", guardar los cambios y nuestra aplicación portable ya se podrá ejecutar sin ningún problema.

[1]: /images/20170322_another_instance_01.jpg
[2]: /images/20170322_another_instance_02.jpg
[3]: /images/20170322_another_instance_03.jpg
[4]: /images/20170322_another_instance_04.jpg
