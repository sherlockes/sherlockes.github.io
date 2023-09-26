---
title: AS3 y Flex gratis con Flashdevelop.
author: Sherlockes
type: post
date: 2008-02-07T23:49:58+00:00
url: /?p=35
mytory_md_visits_count:
  - 1
categories:
  - FlashDevelop
  - Software

---
Al que no le suenen de nada todos los palabros del titulo quiz&#225; no encuentre aqu&#237; la forma m&#225;s sencilla de comenzar en el interesante mundo de creaci&#243;n de contenidos para la web, pero por alg&#250;n sitio hay que hacerlo.&#160; <a href="http://www.adobe.com/devnet/actionscript/" target="_blank">AS3</a> (Abreviatura de ActionScript V3) es el lenguaje de programaci&#243;n utilizado por los productos de dise&#241;o web de <a href="http://www.adobe.com/es/" target="_blank">Adobe</a>.&#160; Seg&#250;n la Wikipedia es <a href="http://es.wikipedia.org/wiki/ActionScript" target="_blank">esto</a>.&#160; Para crear contenido flash orientado a la web la forma m&#225;s sencilla es utilizar "<a href="https://store2.adobe.com/cfusion/store/html/index.cfm?store=OLS-ES&event=displayProduct&categoryPath=/Applications/FlashP&distributionMethod=FULL" target="_blank">Adobe Flash CS3</a>" pero por desgracia cuesta casi 900&#8364; y aunque la burra se lo puede cargar, merece la pena buscar una alternativa gratuita.&#160; Por otro lado, <a href="http://www.adobe.com/es/products/flex/" target="_blank">Flex</a> es en la actualidad la forma m&#225;s r&#225;pida y sencilla de crear RIAS (Rich internet Applications).&#160; El programa que adobe a creado para crear contenido en flex es "<a href="https://store2.adobe.com/cfusion/store/html/index.cfm?store=OLS-ES&event=displayProduct&categoryPath=/Applications/FlexBuilder" target="_blank">Flex Builder</a>" que aunque es mucho m&#225;s barato que el anterior, todav&#237;a cuesta m&#225;s de 200&#8364;.

<!--more-->

&#160;

Con este horizonte, aparece <a href="http://www.flashdevelop.org/community/" target="_blank">FlashDevelop</a>, un entorno de programaci&#243;n que, entre otras muchas facultades, es capaz de crear contenido flash y flex de una forma bastante sencilla.&#160; En primer lugar descargaremos la ultima versi&#243;n (Actualmente es <a href="http://www.flashdevelop.org/downloads/releases/FlashDevelop-3.0.0-Beta5.exe" target="_blank">FD3 Beta5</a>) y esta peque&#241;a <a href="http://flashdevelop.org/downloads/releases/Flex3Beta3_AS3_intrinsics.zip" target="_blank">actualizaci&#243;n</a> para el autocompletado de c&#243;digo en AS3.&#160; Antes de instalar el programa es necesario tener instalado un entorno <a href="http://www.java.com/es/" target="_blank">Java</a> y las librer&#237;as <a href="http://labs.adobe.com/technologies/flex/sdk/flex3sdk.html" target="_blank">Adobe Flex 3 SDK</a> (Lo 1&#186; es muy probable que ya lo tengas pero lo 2&#186; tendr&#225;s que descargarlo y descomprimirlo donde mejor te parezca).&#160; Con todo lo anterior ya es posible instalar FlashDevelop y sustituiremos el contenido de la carpeta "FirstRun\Library\AS3" por la actualizaci&#243;n para el autocompletado anteriormente descargada.&#160; Arrancamos el programa y accedemos al submen&#250; "Program settings" dentro del men&#250; "Tools" y en la pesta&#241;a "AS3 Context" rellenamos el "Flex SDK location" con la ruta donde hemos descomprimido el "Adobe Flex 3 SDK".

<center>
  <img src="sherblog/wp-content/uploads/images/20080208_flashdevelop_settings.jpg" alt="Imagen" />
</center>

<p align="justify">
  Ahora ya estamos listos para crear nuestro primer proyecto flex, para lo cual "Project &#8211; New Project &#8211; Flex 3 Project" y le asignamos un nombre y ubicaci&#243;n.&#160; Abrimos el archivo "main.mxml" e introducimos lo siguiente entre los tag Application: <mx:Text text="Hola mundo."/>
</p>

<center>
  <img src="sherblog/wp-content/uploads/images/20080208_flashdevelop_sample.jpg" alt="Imagen" />
</center>

<p align="justify">
  Pulsando en el bot&#243;n "Test Movie" Se compilar&#225; el programa obteniendo un resultado similar al siguiente.
</p>

<center>
  <img src="sherblog/wp-content/uploads/images/20080208_flashdevelop_result.jpg" alt="Imagen" />
</center>

<p align="justify">
  Puede parecer un poco simple, pero s&#243;lo es el principio ya que con un poco de tiempo, inter&#233;s y pr&#225;ctica se puede llegar a crear algo como esto: <a title="http://www.fotoflot.com/" href="http://www.fotoflot.com/">http://www.fotoflot.com/</a>
</p>

<p align="justify">
  Si no eres capaz de llegar a buen puerto con esta iniciaci&#243;n al dise&#241;o opensource en flex deja un comentario con tu problema y entre todos intentaremos resolverlo.&#160; Para m&#225;s adelante dejo la creaci&#243;n de aplicaciones de escritorio con este mismo FlashDevelop.
</p>