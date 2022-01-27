---
title: 'SherGpx Viewer.  Archivo principal'
author: Sherlockes
type: post
date: 2008-05-15T10:20:37+00:00
url: /?p=69
wp-syntax-cache-content:
  - |
    a:1:{i:1;s:4289:"
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code"><pre class="xml" style="font-family:monospace;"><span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;?xml</span> <span style="color: #000066;">version</span>=<span style="color: #ff0000;">&quot;1.0&quot;</span> <span style="color: #000066;">encoding</span>=<span style="color: #ff0000;">&quot;utf-8&quot;</span><span style="color: #000000; font-weight: bold;">?&gt;</span></span>  
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;mx:Application</span> </span>
    <span style="color: #009900;">    <span style="color: #000066;">xmlns:mx</span>=<span style="color: #ff0000;">&quot;http://www.adobe.com/2006/mxml&quot;</span></span>
    <span style="color: #009900;">    <span style="color: #000066;">viewSourceURL</span>=<span style="color: #ff0000;">&quot;http://sherver.homeip.net/blog/?page_id=67&quot;</span></span>
    <span style="color: #009900;">    <span style="color: #000066;">layout</span>=<span style="color: #ff0000;">&quot;absolute&quot;</span> </span>
    <span style="color: #009900;">    <span style="color: #000066;">creationComplete</span>=<span style="color: #ff0000;">&quot;init();&quot;</span><span style="color: #000000; font-weight: bold;">&gt;</span></span>
    &nbsp;
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;mx:UIComponent</span> <span style="color: #000066;">id</span>=<span style="color: #ff0000;">&quot;mapContainer&quot;</span> <span style="color: #000066;">width</span>=<span style="color: #ff0000;">&quot;100%&quot;</span> <span style="color: #000066;">height</span>=<span style="color: #ff0000;">&quot;100%&quot;</span><span style="color: #000000; font-weight: bold;">/&gt;</span></span>
    &nbsp;
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;mx:Script<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>  
            <span style="color: #339933;">&lt;![CDATA[</span>
    <span style="color: #339933;">            import mx.collections.ArrayCollection;</span>
    &nbsp;
    <span style="color: #339933;">            public var _mapa:MapaYahoo;</span>
    <span style="color: #339933;">            public var _panelrutas:PanelRutas;</span>
    <span style="color: #339933;">            public var _rutasprovider:ArrayCollection;</span>
    <span style="color: #339933;">            public var elevmin:Number;</span>
    <span style="color: #339933;">            public var elevmax:Number;</span>
    &nbsp;
    &nbsp;
    <span style="color: #339933;">            private function init():void{</span>
    <span style="color: #339933;">                _mapa = new MapaYahoo();</span>
    <span style="color: #339933;">                _panelrutas = new PanelRutas();</span>
    <span style="color: #339933;">            }</span>
    <span style="color: #339933;">        ]]&gt;</span>  
        <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/mx:Script<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>  
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/mx:Application<span style="color: #000000; font-weight: bold;">&gt;</span></span></span></pre></td></tr></table><p class="theCode" style="display:none;">&lt;?xml version=&quot;1.0&quot; encoding=&quot;utf-8&quot;?&gt;  
    &lt;mx:Application 
        xmlns:mx=&quot;http://www.adobe.com/2006/mxml&quot;
        viewSourceURL=&quot;http://sherver.homeip.net/blog/?page_id=67&quot;
        layout=&quot;absolute&quot; 
        creationComplete=&quot;init();&quot;&gt;
            
        &lt;mx:UIComponent id=&quot;mapContainer&quot; width=&quot;100%&quot; height=&quot;100%&quot;/&gt;
        
        &lt;mx:Script&gt;  
            &lt;![CDATA[
                import mx.collections.ArrayCollection;
                
                public var _mapa:MapaYahoo;
                public var _panelrutas:PanelRutas;
                public var _rutasprovider:ArrayCollection;
                public var elevmin:Number;
                public var elevmax:Number;
                
                
                private function init():void{
                    _mapa = new MapaYahoo();
                    _panelrutas = new PanelRutas();
                }
            ]]&gt;  
        &lt;/mx:Script&gt;  
    &lt;/mx:Application&gt;</p></div>
    ";}
categories:
  - AS3 Flex Air
  - Shergpx
  - Software
tags:
  - as3
  - Shergpx

---
Como toda aplicación Flex que se precie, el proyecto parte de un archivo *.mxml principal. En este caso, el grueso de la programación está realizada en AS3 de forma que este archivo queda realmente escueto y a que son apenas 30 líneas de código muy fáciles de entender. A continuación se muestra el archivo "main.mxml"

<pre lang="xml"><?xml version="1.0" encoding="utf-8"?>  
&lt;mx:Application 
    xmlns:mx="http://www.adobe.com/2006/mxml"
    viewSourceURL="http://sherver.homeip.net/blog/?page_id=67"
    layout="absolute" 
    creationComplete="init();">
        
    &lt;mx:UIComponent id="mapContainer" width="100%" height="100%"/>
    
    &lt;mx:Script>  
        
            import mx.collections.ArrayCollection;
            
            public var _mapa:MapaYahoo;
            public var _panelrutas:PanelRutas;
            public var _rutasprovider:ArrayCollection;
            public var elevmin:Number;
            public var elevmax:Number;
            
            
            private function init():void{
                _mapa = new MapaYahoo();
                _panelrutas = new PanelRutas();
            }
          
    &lt;/mx:Script>  
&lt;/mx:Application>
</pre>

La parte Flex consta únicamente de la declaración inicial de la aplicación y dos nodos, por un lado tenemos "MapContainer" (Que como su nombre indica será el contenedor en el que AS3 incluirá el resto de elementos visuales de la aplicación) y por otro lado un pequeño script en AS3 con la declaración de las variables principales y la función de inicio de la aplicación.

En otro artículo explicaré detalladamente lo que implican las líneas "\_mapa = new MapaYahoo();" y "\_panelrutas = new PanelRutas();" ya que es aquí donde está el meollo de la cuestión.