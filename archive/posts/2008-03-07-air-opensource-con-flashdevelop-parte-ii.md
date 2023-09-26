---
title: AIR opensource con FlashDevelop. Parte II
author: Sherlockes
type: post
date: 2008-03-06T23:33:49+00:00
url: /?p=50
mytory_md_visits_count:
  - 3
wp-syntax-cache-content:
  - |
    a:1:{i:1;s:6077:"
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code"><pre class="xml" style="font-family:monospace;"><span style="color: #009900;">&lt; ?xml <span style="color: #000066;">version</span>=<span style="color: #ff0000;">&quot;1.0&quot;</span> <span style="color: #000066;">encoding</span>=<span style="color: #ff0000;">&quot;utf-8&quot;</span> <span style="color: #000000; font-weight: bold;">?&gt;</span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;application</span> <span style="color: #000066;">xmlns</span>=<span style="color: #ff0000;">&quot;http://ns.adobe.com/air/application/1.0&quot;</span></span>
    <span style="color: #009900;">    <span style="color: #000066;">minimumPatchLevel</span>=<span style="color: #ff0000;">&quot;0&quot;</span><span style="color: #000000; font-weight: bold;">&gt;</span></span>
    &nbsp;
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;id<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>com.sherlockes.loquesea<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/id<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;name<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>loquesea<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/name<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;version<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>1.0<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/version<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;filename<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>loquesea<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/filename<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;description<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>loquesea<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/description<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;copyright<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>Sherlockes 2008<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/copyright<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;initialwindow<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
            <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;content<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>loquesea.swf<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/content<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
            <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;title<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>loquesea<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/title<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
            <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;systemchrome<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>none<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/systemchrome<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
            <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;transparent<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>true<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/transparent<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
            <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;visible<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>true<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/visible<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/initialwindow<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/application<span style="color: #000000; font-weight: bold;">&gt;</span></span></span></pre></td></tr></table><p class="theCode" style="display:none;">&lt; ?xml version=&quot;1.0&quot; encoding=&quot;utf-8&quot; ?&gt;
    &lt;application xmlns=&quot;http://ns.adobe.com/air/application/1.0&quot;
        minimumPatchLevel=&quot;0&quot;&gt;
            
        &lt;id&gt;com.sherlockes.loquesea&lt;/id&gt;
        &lt;name&gt;loquesea&lt;/name&gt;
        &lt;version&gt;1.0&lt;/version&gt;
        &lt;filename&gt;loquesea&lt;/filename&gt;
        &lt;description&gt;loquesea&lt;/description&gt;
        &lt;copyright&gt;Sherlockes 2008&lt;/copyright&gt;
        &lt;initialwindow&gt;
            &lt;content&gt;loquesea.swf&lt;/content&gt;
            &lt;title&gt;loquesea&lt;/title&gt;
            &lt;systemchrome&gt;none&lt;/systemchrome&gt;
            &lt;transparent&gt;true&lt;/transparent&gt;
            &lt;visible&gt;true&lt;/visible&gt;
        &lt;/initialwindow&gt;
    &lt;/application&gt;</p></div>
    ";}
categories:
  - FlashDevelop
  - Software

---
Desde que escribí la [primera parte][1] de este tema el panorama ha cambiado notablemente, ya que por fin ha salido la versión 1.0 de Adobe Air y de la mano ha traído el SDK definitivo de Flex 3 el cual deberemos descargar desde [aquí][2] y reemplazar con el a la versión beta que teníamos anteriormente instalada.

Antes de seguir con el empaquetado de aplicaciones en AIR, deberemos modificar el archivo xml de configuración para adecuarlo a esta nueva versión del SDK de forma que nos quedará algo parecido a lo siguiente.

<pre lang="xml"><?xml version="1.0" encoding="utf-8" ?>
&lt;application 
    xmlns="http://ns.adobe.com/air/application/1.0"
    minimumPatchLevel="0">
        
    &lt;id>com.sherlockes.loquesea&lt;/id>
    &lt;name>loquesea&lt;/name>
    &lt;version>1.0&lt;/version>
    &lt;filename>loquesea&lt;/filename>
    &lt;description>loquesea&lt;/description>
    &lt;copyright>Sherlockes 2008&lt;/copyright>
    &lt;initialWindow>
        &lt;content>loquesea.swf&lt;/content>
        

<title>
  loquesea
</title>
        &lt;systemChrome>none&lt;/systemChrome>
        &lt;transparent>true&lt;/transparent>
        &lt;visible>true&lt;/visible>
    &lt;/initialWindow>
&lt;/application>
</pre>

Es muy importante hacer esto si quieres evitar posteriormente unos fuertes dolores de cabeza.

Para compilar directamente desde el SDK crearemos dentro de la carpeta "bin" del proyecto un archivo _"air_compilar.bat"_ con el bloc de notas y escribiremos dentro _"adl main-app.xml"_ donde _"main-app.xml"_ es el nombre del archivo de descripción de la aplicación y deberá ser muy parecido al que se ha mostrado anteriormente además de estar ubicado en la misma carpeta. Hay que recordar que al haber introducido la ruta del SDK dentro de las variables del sistema no es necesario escribir la ruta completa al archivo, y lanzaramos el "AIR Debug Launcher" simplemente con el comando "adl".

Un doble click en el archivo "air_compilar.bat" nos abrirá una ventana de comandos y posteriormente mostrará la aplicación.

<!--more-->

El siguiente tema a tocar es la necesidad de un certificado que valide el software que hemos creado de cara a los clientes. Este certificado es un archivo *.pfx que debe ser comprado a una empresa que e dedica específicamente a crearlos. Como no estamos por la labor de gastar nada de dinero nos arreglaremos con una alternativa gratuita. Nuevamente con el bloc de notas crearemos un archivo _"air_certificado.bat"_ que contenga la siguiente línea:

<p align="center">
  <em>adt -certificate -cn tunombre 1024-RSA air_certificado.pfx tupassword</em>
</p>

<p align="justify">
  Al ejecutar este archivo se creará un archivo <em>"air_certificado.pfx"</em> que utilizaremos posteriormente para el empaquetado de la aplicación. Si quieres saber más sobre la creación de estos certificados, lee <a href="http://livedocs.adobe.com/labs/air/1/devappsflex/help.html?content=dg_part_3_1.html">esto</a>.
</p>

<p align="justify">
  Aunque parezca mentira, ya estamos a las puertas de tener creada nuestra primera aplicación AIR de forma gratuita con FlashDevelop. El último paso es crear un archivo <em>"air_crear_aplicación.bat"</em> con la siguiente linea de comando en su interior (Todo en la misma línea):
</p>

<p align="center">
  <em>adt -package -storetype pkcs12 -keystore air_certificado.pfx setup.air main-app.xml main.swf</em>
</p>

<p align="justify">
  De todo lo anterior, <em>"air_certificado.pfx"</em> es el archivo con el certificado que hemos creado anteriormente, <em>"setup.air"</em> es el archivo con la aplicación empaquetada que se creará, <em>"main-app.xml"</em> el archivo de descripción de la aplicación y <em>"main.swf"</em> la aplicación flash que se ha compilado con FlasDevelop. Con todo esto, si hemos seguido bien los pasos ya tendremos creada nuestra aplicación lista para instalar en cualquier PC o MAC que tenga instalado <a href="http://get.adobe.com/air/thankyou/" target="_blank">Adobe AIR 1.0</a>, para linux habrá que esperar un poco.
</p>

<p align="justify">
  Finalmente, para agilizar un poco el desarrollo de la aplicación con FlashDevelop, en el menú "Project-properties" modificaremos el comando para la acción "Test Movie" e introduciremos un "Post-Build command"
</p>

<center>
  <img src="sherblog/wp-content/uploads/images/20080307_14d75air-fd-project-1.jpg" />
</center>

<center>
  <img src="sherblog/wp-content/uploads/images/20080307_14d75air-fd-project-2.jpg" />
</center>

<p align="justify">
  Con esto bastará pulsar F5 para compilar la aplicación y mostrarla en pantalla. Espero que todo el que haya tenido tiempo para leer esto haya sido capaz de obtener resultados pero por si no ha sido así dejo abierta la vía de los comentarios.
</p>

<p align="justify">
  En otros Post veremos como poner iconos a nuestra aplicación y otras muchas cosas más, sólo hace falta un poco de paciencia.
</p>

 [1]: http://sherver.homeip.net/blog/?p=38
 [2]: http://download.macromedia.com/pub/flex/sdk/flex_sdk_3.zip