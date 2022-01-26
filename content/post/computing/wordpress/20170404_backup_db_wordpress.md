---
title: "Copia de seguridad de la base de datos de WordPress"
date: "2017-04-04"
description: "Así es como realizo la copia de seguridad de la base de datos de WordPress hacia Google Drive"
thumbnail: "images/20170228_db_backup_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Wordpress"
  - "Sherver"
draft: false
weight: 5
---
Hace unos días expliqué como gestiona la copia de seguridad de los archivos de WordPress (la carpeta wp-content) y aquí vamos a ver como hago lo propio con la base de datos. El flujo de trabajo es simple, periódicamente me llega un correo electrónico con la base de datos comprimida como archivo adjunto y guardo ese archivo en mi unidad de Google Drive.

El plugin de WordPress [WP-DB-Backup][1] es el que se encarga de enviar un correo electrónico periódicamente con la copia de la base de datos. La configuración es muy sencilla, una vez que el plugin está instalado y activo vamos al menú "Herramientas - Copia de respaldo" del escritorio de WordPress y bajamos hasta la opción "Respaldo Programado".

![image][2]

Seleccionamos la frecuencia del respaldo y las tablas adicionales a respaldar, introducimos la dirección de correo a la que vamos a enviar el respaldo y pulsamos el botón "Respaldo Programado" para guardar la configuración.

A continuación vamos a crear un programa dentro de Google Apps Script que nos guardará el archivo adjunto en una carpeta de nuestra unidad de Google Drive y borrará el correo electrónico.

```
// Declaración de variables
var ahora = new Date();
var correos = GmailApp.search("subject:(*SherBlog Copia de seguridad de la base de datos*) has:attachment");
var carpeta = DriveApp.searchFolders("title contains 'sherblog_db_backups'").next();
var archivos = new Array();
 
// Matrices para distintos rangos de antiguedad 10-20-40-80-160 
var d10 = new Array();
var d20 = new Array();
var d40 = new Array();
var d80 = new Array();
var d160 = new Array();
 
function backup_db() {
  
  // Guardar los archivos adjuntos y borra los correos
  for (var x=0; x<correos.length; x++) {
    var mensaje = correos[x].getMessages()[0];
    var adjuntos = mensaje.getAttachments();
    carpeta.createFile(adjuntos[0]);
    correos[x].moveToTrash();
  }
                 
  // Genera matriz con los archivos ya existentes en carpeta
  archivos = carpeta.getFiles();
  
  while (archivos.hasNext()) {
    archivo = archivos.next();
    // Asigna cada archivo al rango de antiguedad y borra los obsoletos
    if(dias(archivo)>5 && dias(archivo)<11){d10.push(archivo)};
    if(dias(archivo)>10 && dias(archivo)<21){d20.push(archivo)};
    if(dias(archivo)>20 && dias(archivo)<41){d40.push(archivo)};
    if(dias(archivo)>40 && dias(archivo)<81){d80.push(archivo)};
    if(dias(archivo)>80 && dias(archivo)<161){d160.push(archivo)};
    if(dias(archivo)>160){archivo.setTrashed(true)};
  }
               
  // Borrar los archivos recientes de cada rango
  limpiar(d10);
  limpiar(d20);
  limpiar(d40);
  limpiar(d80);
  limpiar(d160); 
}
 
// función para contar los días de antiguedad de un archivo
function dias(archiv){
  return(Math.round((ahora - archiv.getLastUpdated())/1000/60/60/24));
}
 
// Función para eliminar los archivos mas recientes de una matriz
function limpiar(matriz){
  while (matriz.length>1){
    if(dias(matriz[0])>dias(matriz[1])){
      matriz[1].setTrashed(true);  //Elimina el archivo más reciente
      matriz.splice(1,1);  //Elimina la entrada de la matriz correspondiente al archivo borrado
    }else{
      matriz[0].setTrashed(true);
      matriz.splice(0,1);
    }
  }
}
```

Con esto ya tenemos guardada en nuestra unidad de Google Drive una copia de seguridad de la base de datos de WordPress de la web.

Para el tema del guardado de versiones he optado por un sistema tan simple como efectivo, tal y como se puede ver en el código se guardan los siguientes archivos.

* Un archivo por cada uno de los cinco últimos días
* Un archivo con una antigüedad entre 5 y 10 días
* Un archivo con una antigüedad entre 10 y 20 días
* Un archivo con una antigüedad entre 20 y 40 días
* Un archivo con una antigüedad entre 40 y 80 días
* Un archivo con una antigüedad entre 80 y 160 días

Y con esto creo que tengo más que suficiente para cubrir mis necesidades ocupando un espacio limitado.

[1]:  https://es.wordpress.org/plugins/wp-db-backup/
[2]: /images/20170228_db_backup_01.jpg