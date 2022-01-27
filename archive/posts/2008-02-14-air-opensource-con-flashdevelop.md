---
title: AIR opensource con FlashDevelop. Parte I
author: Sherlockes
type: post
date: 2008-02-13T23:03:07+00:00
url: /?p=38
mytory_md_visits_count:
  - 3
wp-syntax-cache-content:
  - |
    a:2:{i:1;s:1244:"
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code"><pre class="xml" style="font-family:monospace;"><span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;?xml</span> <span style="color: #000066;">version</span>=”1.0?<span style="color: #000000; font-weight: bold;">?&gt;</span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;mx:Application</span> <span style="color: #000066;">xmlns:mx</span>=”http://www.adobe.com/2006/mxml”<span style="color: #000000; font-weight: bold;">&gt;</span></span>
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;mx:Text</span> <span style="color: #000066;">text</span>=”Hola a todos”<span style="color: #000000; font-weight: bold;">/&gt;</span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/mx:Application<span style="color: #000000; font-weight: bold;">&gt;</span></span></span></pre></td></tr></table><p class="theCode" style="display:none;">&lt;?xml version=”1.0??&gt;
    &lt;mx:Application xmlns:mx=”http://www.adobe.com/2006/mxml”&gt;
        &lt;mx:Text text=”Hola a todos”/&gt;
    &lt;/mx:Application&gt;</p></div>
    ";i:2;s:5860:"
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code"><pre class="xml" style="font-family:monospace;"><span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;?xml</span> <span style="color: #000066;">version</span>=”1.0? <span style="color: #000066;">encoding</span>=”utf-8? <span style="color: #000000; font-weight: bold;">?&gt;</span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;application</span></span>
    <span style="color: #009900;">    <span style="color: #000066;">xmlns</span>=”http://ns.adobe.com/air/application/1.0.M6<span style="color: #000000; font-weight: bold;">?&gt;</span></span>
    &nbsp;
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;id<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>com.sherlockes.loquesea<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/id<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;name<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>Loquesea<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/name<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;version<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>1.0<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/version<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;filename<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>fd_air_loquesea<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/filename<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;description<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>Descripcion<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/description<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;copyright<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>Sherlockes 2008<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/copyright<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;initialWindow<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
            <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;content<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>loquesea.swf<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/content<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
            <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;title<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>LoQueSea<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/title<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
            <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;systemChrome<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>none<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/systemChrome<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
            <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;transparent<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>true<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/transparent<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
            <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;visible<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>true<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/visible<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/initialWindow<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    &nbsp;
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/application<span style="color: #000000; font-weight: bold;">&gt;</span></span></span></pre></td></tr></table><p class="theCode" style="display:none;">&lt;?xml version=”1.0? encoding=”utf-8? ?&gt;
    &lt;application
        xmlns=”http://ns.adobe.com/air/application/1.0.M6?&gt;
    
        &lt;id&gt;com.sherlockes.loquesea&lt;/id&gt;
        &lt;name&gt;Loquesea&lt;/name&gt;
        &lt;version&gt;1.0&lt;/version&gt;
        &lt;filename&gt;fd_air_loquesea&lt;/filename&gt;
        &lt;description&gt;Descripcion&lt;/description&gt;
        &lt;copyright&gt;Sherlockes 2008&lt;/copyright&gt;
        &lt;initialWindow&gt;
            &lt;content&gt;loquesea.swf&lt;/content&gt;
            &lt;title&gt;LoQueSea&lt;/title&gt;
            &lt;systemChrome&gt;none&lt;/systemChrome&gt;
            &lt;transparent&gt;true&lt;/transparent&gt;
            &lt;visible&gt;true&lt;/visible&gt;
        &lt;/initialWindow&gt;
    
    &lt;/application&gt;</p></div>
    ";}
categories:
  - FlashDevelop
  - Software

---
En el <a href="http://sherver.homeip.net/blog/?p=35" target="_blank">post anterior</a> vimos como crear contenido en AS3 o Flex de una forma sencilla y gratuita usando FlashDevelop. Ahora daremos un nuevo paso adelante para crear contenido en AIR desde el mismo entorno de desarrollo y sin gastas un solo euro.

Antes de comenzar en interesante incluir la ruta donde instalamos el sdk de flex 3 dentro de las variables de nuestro sistema. En "Inicio-Configuración-Panel de control-Sistema-Opciones avanzadas-Variables de entorno-Variables del sistema" modificaremos la variable "Path" para añadir la ruta de la carpeta "bin" del sdk.<!--more-->

<center>
  <img src="sherblog/wp-content/uploads/images/20080214_varsdk.jpg" alt="Imagen" />
</center>

<p align="justify">
  Con esto conseguimos la capacidad de ejecutar cualquiera de los programas residentes en esta carpeta sin la necesidad de escribir toda la ruta.
</p>

<p align="justify">
  <p align="justify">
    Ahora ya podemos arrancar FlashDevelop y crear un nuevo proyecto del tipo "AIR Flex3 Projector" y dentro de la carpeta "src" modificaremos el archivo "main.mxml" con lo siguiente:
  </p>
  
  <pre lang="xml">
<?xml version=”1.0??>
&lt;mx:Application xmlns:mx=”http://www.adobe.com/2006/mxml”>
    &lt;mx:Text text=”Hola a todos”/>
&lt;/mx:Application>
</pre>
  
  <p align="justify">
    Le damos al botón "Test Movie" y tras un tiempo de compilación en entorno no muestra ningún resultado, pero ha creado la carpeta "bin" con dos archivos, un "loquesea.swf" y un "loquesea.xml", el primero es el contenido de nuestra aplicación y el segundo la descripción para AIR de dicha aplicación. El xml lo editaremos hasta que quede algo parecido a esto:
  </p>
  
  <pre lang="xml">
<?xml version=”1.0? encoding=”utf-8? ?>
&lt;application
    xmlns=”http://ns.adobe.com/air/application/1.0.M6?>

    &lt;id>com.sherlockes.loquesea&lt;/id>
    &lt;name>Loquesea&lt;/name>
    &lt;version>1.0&lt;/version>
    &lt;filename>fd_air_loquesea&lt;/filename>
    &lt;description>Descripcion&lt;/description>
    &lt;copyright>Sherlockes 2008&lt;/copyright>
    &lt;initialWindow>
        &lt;content>loquesea.swf&lt;/content>
        

<title>
  LoQueSea
</title>
        &lt;systemChrome>none&lt;/systemChrome>
        &lt;transparent>true&lt;/transparent>
        &lt;visible>true&lt;/visible>
    &lt;/initialWindow>

&lt;/application>
</pre>
  
  <p align="justify">
    Con este archivo, el resultado de la aplicación será un cuadro sin bordes ni botones para maximizar, minimizar o cerrar. Si queremos que el resultado se muestre en una ventana como los programas normales deberemos cambiar el parámetro "systemchrome" a "standard" y el "transparent" a "false". El factor principal es que la etiqueta "content" coincida con el archivo swf. Es importante no escribir acentos ni caracteres especiales en este archivo, ya que luego no se sienta nada bien al compilador. Respecto al archivo swf, si tenemos instalado el Flash Player (Está en la carpeta \runtimes\player\win\ del SDK) podremos ver el resultado de nuestra aplicación.
  </p>
  
  <p align="justify">
    Hasta aquí esta primera parte, en la segunda veremos como automatizar el proceso de compilación, muestra y empaquetado de la aplicación, pero eso será otro día.
  </p>