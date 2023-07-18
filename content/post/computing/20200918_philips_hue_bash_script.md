---
title: "Controlar las luces de Philips hue con un script en bash"
date: "2020-09-18"
creation: "2020-09-18"
description: "Controlar las luces de Philips hue con un script en bash"
thumbnail: "/images/20200918_philips_hue_bash_script_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
  - "computing"
tags:
  - "bash"
  - "phillips hue"
draft: false
weight: 5
---
Hay muchas formas de controlar las luces de Phillis Hue, aquí dejo la que empleo para apagar las luces mediante una simple línea de comando gracias a la Raspberry.

<!--more-->

Desde que [IFTTT] se ha pasado al modelo de subscripción, me he visto obligado a buscar alternativas a su uso más económicas que el pago de 10€ al mes de cuota. Después de dar unas cuantas vueltas por [GitHub] a la búsqueda de scripts para controlar desde la línea de comando las luces de Philips sin ningún éxito me he encontrado con que la solución era mucho más facil de lo que yo pensaba además de estar perfectamente documentada en la web del fabricante. El punto de partida es la web de desarrolladores de [Philips] y seguir unos sencillos pasos.

## Conocer la IP del puente de Hue

La forma mas sencilla de conocer la IP del Bridge es sin duda desde la aplicación del teléfono, en el apartado "Ajustes" seleccionamos "Hue Bridges" y abrimos la información del puente que tengamos conectado en nuestra casa. Obtendremos la siguiente info entre la que podemos ver la IP local del puente. 

``` Estado: Conectado Seguridad: Protegido por HTTPS ID: 001788FFFC5G7247 Dirección IP: 192.168.1.94 Dirección MAC: 01:14:68:2E:7B:AC SW: 1940083000 ```

Resulta extraño no tener instalada la aplicación en el móvil, pero si ocurre, obtener la IP desde la terminal es tan sencillo como lanzar el comando `sudo nmap -sn 192.168.1.0/24` y buscar la IP que corresponde al punte de Philips entre todos los aparatos que tenemos conectados a nuestra red local. 

``` Nmap scan report for 192.168.1.94 Host is up (0.00027s latency). MAC Address: 01:14:68:2E:7B:AC (Philips Lighting BV) ```

La imagen anterior es el resultado de nmap en la que se puede ver las ip del puente, latencia, estado, dirección MAC y  fabricante.

## Crear un usuario autorizado de acceso al hub 
Para poder enviar comandos al hub, lo primero que necesitamos es un usuario autorizado para lo cual pulsaremos el botón central del bridge y seguidamentemandaremos este comando desde la terminal. `curl -X POST -H "Content-Type: application/json" -d '{"devicetype":"my_hue_app#android usuario"}' http://192.168.1.94/api/` Obteniendo, si todo ha ido bien, una respuesta del tipo

``` [ { "success": { "username": "IUhFYVXiv46HGzc1fY46dGUpvTnhfffl0BdmEyDC" } } ] ```

Es posible ver toda la configuración del Hub así como los usuarios activos con el comando (Habrá que sustituir <username> por IUhFYVXiv46HGzc1fY46dGUpvTnhfffl0BdmEyDC `curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://192.168.1.94/api/<username>/config`

Además de toda la información disponible en el Bridge puedes ver el usuario que acabas de añadir en la última línea del texto.

``` "IUhFYVXiv46HGzc1fY46dGUpvTnhfffl0BdmEyDC":{"last use date":"2020-09-18T08:44:33","create date":"2020-09-16T11:02:47","name":"my_hue_app#android usuario"} ```

> Es posible eliminar usuarios activos desde la web https://account.meethue.com/apps 

## Conociendo las bombillas
Antes de plantearnos la posibilidad de encender una bombilla, deberemos saber como el puente la ha identificado para lo cual lanzaremos el siguiente comando `curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://192.168.1.94/api/<username>/lights`

![Image_01]

No te asustes de la parrafada, copia el último trozo de texto en json y pégalo en este [visor] online para darle un formato más "humano" tal y como se puede ver en la siguiente imagen.

![Image_02]

Ahora resulta sencillo ver que la bombilla "1" corresponde con la que hemos llamado "Luz de Noel" por lo que ya estamos más cerca de poder encenderla.

## Encendiendo la bombilla
Llegados a este punto, ya tenemos la Ip donde se encuentra localizado el Hub de Pilips, el nombre el usuario autorizado y la identificación de la bombilla que queremos encender. Sólo resta lanzar un comando para encender esta bombilla `curl -X PUT -H "Content-Type: application/json" -d '{"on":true}' "http://<ip_del_hub>/api/<username>/lights/1/state"`

> Para apagarla, tan sencillo como cambiar el true por false... Y hasta aquí lo prometido, una sola línea de comando para encender una bombilla.

De aquí en adelante, gracias a la buena documentación de Philips, se puede hacer lo que necesitemos con esas bombillas.

[IFTTT]: https://ifttt.com
[GitHub]: https://github.com
[Philips]: https://developers.meethue.com/develop/get-started-2
[Visor]: http://jsonviewer.stack.hu

[Image_01]: /images/20200918_philips_hue_bash_script_01.jpg
[Image_02]: /images/20200918_philips_hue_bash_script_02.jpg
