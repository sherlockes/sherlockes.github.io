---
title: 'Leyendo el archivo *.gpx'
author: Sherlockes
type: post
date: 2008-05-08T20:42:03+00:00
url: /?p=68
mytory_md_visits_count:
  - 1
wp-syntax-cache-content:
  - |
    a:1:{i:1;s:14546:"
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code"><pre class="actionscript" style="font-family:monospace;">package  
    <span style="color: #66cc66;">&#123;</span>
        <span style="color: #0066CC;">import</span> flash.<span style="color: #006600;">events</span>.<span style="color: #006600;">Event</span>;
        <span style="color: #0066CC;">import</span> flash.<span style="color: #006600;">net</span>.<span style="color: #006600;">URLRequest</span>;
        <span style="color: #0066CC;">import</span> flash.<span style="color: #006600;">net</span>.<span style="color: #006600;">URLLoader</span>;
        <span style="color: #0066CC;">import</span> com.<span style="color: #006600;">yahoo</span>.<span style="color: #006600;">maps</span>.<span style="color: #006600;">api</span>.<span style="color: #006600;">core</span>.<span style="color: #006600;">location</span>.<span style="color: #006600;">LatLon</span>;
    &nbsp;
        <span style="color: #0066CC;">public</span> <span style="color: #0066CC;">dynamic</span> <span style="color: #000000; font-weight: bold;">class</span> DatosPath 
        <span style="color: #66cc66;">&#123;</span>
            <span style="color: #0066CC;">private</span> <span style="color: #000000; font-weight: bold;">var</span> ns1:Namespace = <span style="color: #000000; font-weight: bold;">new</span> Namespace<span style="color: #66cc66;">&#40;</span><span style="color: #ff0000;">&quot;http://www.topografix.com/GPX/1/1&quot;</span><span style="color: #66cc66;">&#41;</span>;
    &nbsp;
            <span style="color: #0066CC;">public</span> <span style="color: #000000; font-weight: bold;">var</span> _coordenadas:<span style="color: #0066CC;">Array</span> = <span style="color: #000000; font-weight: bold;">new</span> <span style="color: #0066CC;">Array</span><span style="color: #66cc66;">&#40;</span><span style="color: #66cc66;">&#41;</span>;
            <span style="color: #0066CC;">public</span> <span style="color: #000000; font-weight: bold;">var</span> _elevacion:<span style="color: #0066CC;">Array</span> = <span style="color: #000000; font-weight: bold;">new</span> <span style="color: #0066CC;">Array</span><span style="color: #66cc66;">&#40;</span><span style="color: #66cc66;">&#41;</span>;
            <span style="color: #0066CC;">public</span> <span style="color: #000000; font-weight: bold;">var</span> _kilometros:<span style="color: #0066CC;">Array</span> = <span style="color: #000000; font-weight: bold;">new</span> <span style="color: #0066CC;">Array</span><span style="color: #66cc66;">&#40;</span><span style="color: #66cc66;">&#41;</span>;
            <span style="color: #0066CC;">public</span> <span style="color: #000000; font-weight: bold;">var</span> _tiempos:<span style="color: #0066CC;">Array</span> = <span style="color: #000000; font-weight: bold;">new</span> <span style="color: #0066CC;">Array</span><span style="color: #66cc66;">&#40;</span><span style="color: #66cc66;">&#41;</span>;
            <span style="color: #0066CC;">public</span> <span style="color: #000000; font-weight: bold;">var</span> _velocidad:<span style="color: #0066CC;">Array</span> = <span style="color: #000000; font-weight: bold;">new</span> <span style="color: #0066CC;">Array</span><span style="color: #66cc66;">&#40;</span><span style="color: #66cc66;">&#41;</span>;
            <span style="color: #0066CC;">public</span> <span style="color: #000000; font-weight: bold;">var</span> _pendiente:<span style="color: #0066CC;">Array</span> = <span style="color: #000000; font-weight: bold;">new</span> <span style="color: #0066CC;">Array</span><span style="color: #66cc66;">&#40;</span><span style="color: #66cc66;">&#41;</span>;
            <span style="color: #0066CC;">public</span> <span style="color: #000000; font-weight: bold;">var</span> _energia:<span style="color: #0066CC;">Array</span> = <span style="color: #000000; font-weight: bold;">new</span> <span style="color: #0066CC;">Array</span><span style="color: #66cc66;">&#40;</span><span style="color: #66cc66;">&#41;</span>;
    &nbsp;
            <span style="color: #0066CC;">public</span> <span style="color: #000000; font-weight: bold;">function</span> DatosPath<span style="color: #66cc66;">&#40;</span>archivo:<span style="color: #0066CC;">String</span><span style="color: #66cc66;">&#41;</span> 
            <span style="color: #66cc66;">&#123;</span>
                <span style="color: #000000; font-weight: bold;">var</span> xmlLoader:URLLoader = <span style="color: #000000; font-weight: bold;">new</span> URLLoader<span style="color: #66cc66;">&#40;</span><span style="color: #66cc66;">&#41;</span>;
                <span style="color: #000000; font-weight: bold;">var</span> xmlData:<span style="color: #0066CC;">XML</span> = <span style="color: #000000; font-weight: bold;">new</span> <span style="color: #0066CC;">XML</span><span style="color: #66cc66;">&#40;</span><span style="color: #66cc66;">&#41;</span>;
                xmlLoader.<span style="color: #006600;">addEventListener</span><span style="color: #66cc66;">&#40;</span>Event.<span style="color: #006600;">COMPLETE</span>, LoadXML<span style="color: #66cc66;">&#41;</span>;
                xmlLoader.<span style="color: #0066CC;">load</span><span style="color: #66cc66;">&#40;</span><span style="color: #000000; font-weight: bold;">new</span> URLRequest<span style="color: #66cc66;">&#40;</span>archivo<span style="color: #66cc66;">&#41;</span><span style="color: #66cc66;">&#41;</span>;
                <span style="color: #000000; font-weight: bold;">default</span> <span style="color: #0066CC;">xml</span> namespace = ns1;
    &nbsp;
                <span style="color: #000000; font-weight: bold;">function</span> LoadXML<span style="color: #66cc66;">&#40;</span><span style="color: #0066CC;">e</span>:Event<span style="color: #66cc66;">&#41;</span>:<span style="color: #0066CC;">void</span> <span style="color: #66cc66;">&#123;</span>
                    xmlData = <span style="color: #000000; font-weight: bold;">new</span> <span style="color: #0066CC;">XML</span><span style="color: #66cc66;">&#40;</span><span style="color: #0066CC;">e</span>.<span style="color: #0066CC;">target</span>.<span style="color: #0066CC;">data</span><span style="color: #66cc66;">&#41;</span>;
                    <span style="color: #000000; font-weight: bold;">var</span> puntos:<span style="color: #0066CC;">XML</span> = <span style="color: #000000; font-weight: bold;">new</span> <span style="color: #0066CC;">XML</span><span style="color: #66cc66;">&#40;</span>xmlData.<span style="color: #006600;">trk</span>.<span style="color: #006600;">trkseg</span><span style="color: #66cc66;">&#41;</span>;
    &nbsp;
                    <span style="color: #b1b100;">for</span> <span style="color: #b1b100;">each</span> <span style="color: #66cc66;">&#40;</span><span style="color: #000000; font-weight: bold;">var</span> item:<span style="color: #0066CC;">XML</span> <span style="color: #b1b100;">in</span> puntos.<span style="color: #006600;">elements</span><span style="color: #66cc66;">&#40;</span><span style="color: #66cc66;">&#41;</span><span style="color: #66cc66;">&#41;</span> <span style="color: #66cc66;">&#123;</span>
                        <span style="color: #808080; font-style: italic;">// LLenar las matrices con datos de elevación y coordenadas</span>
                        _coordenadas.<span style="color: #0066CC;">push</span><span style="color: #66cc66;">&#40;</span><span style="color: #000000; font-weight: bold;">new</span> LatLon<span style="color: #66cc66;">&#40;</span>item.<span style="color: #66cc66;">@</span>lat, item.<span style="color: #66cc66;">@</span>lon<span style="color: #66cc66;">&#41;</span><span style="color: #66cc66;">&#41;</span>;
                        _elevacion.<span style="color: #0066CC;">push</span><span style="color: #66cc66;">&#40;</span><span style="color: #0066CC;">Number</span><span style="color: #66cc66;">&#40;</span>item.<span style="color: #006600;">ele</span><span style="color: #66cc66;">&#41;</span><span style="color: #66cc66;">&#41;</span>;
    &nbsp;
                        <span style="color: #808080; font-style: italic;">// Crear la matriz de tiempos  --&gt; 2008-03-16T08:14:06Z  &lt;--</span>
                        <span style="color: #000000; font-weight: bold;">var</span> patron:RegExp = <span style="color: #66cc66;">/</span><span style="color: #66cc66;">&#40;</span>?P<span style="color: #66cc66;">&lt;</span>ano<span style="color: #66cc66;">&gt;</span><span style="color: #66cc66;">&#91;</span><span style="color: #cc66cc;">0</span>-<span style="color: #cc66cc;">9</span><span style="color: #66cc66;">&#93;</span><span style="color: #66cc66;">&#123;</span><span style="color: #cc66cc;">2</span><span style="color: #66cc66;">&#125;</span><span style="color: #66cc66;">&#41;</span>\-<span style="color: #66cc66;">&#40;</span>?P<span style="color: #66cc66;">&lt;</span>mes<span style="color: #66cc66;">&gt;</span><span style="color: #66cc66;">&#91;</span><span style="color: #cc66cc;">0</span>-<span style="color: #cc66cc;">9</span><span style="color: #66cc66;">&#93;</span><span style="color: #66cc66;">&#123;</span><span style="color: #cc66cc;">2</span><span style="color: #66cc66;">&#125;</span><span style="color: #66cc66;">&#41;</span>\-<span style="color: #66cc66;">&#40;</span>?P<span style="color: #66cc66;">&lt;</span>dia<span style="color: #66cc66;">&gt;</span><span style="color: #66cc66;">&#91;</span><span style="color: #cc66cc;">0</span>-<span style="color: #cc66cc;">9</span><span style="color: #66cc66;">&#93;</span><span style="color: #66cc66;">&#123;</span><span style="color: #cc66cc;">2</span><span style="color: #66cc66;">&#125;</span><span style="color: #66cc66;">&#41;</span>T<span style="color: #66cc66;">&#40;</span>?P<span style="color: #66cc66;">&lt;</span>hora<span style="color: #66cc66;">&gt;</span><span style="color: #66cc66;">&#91;</span><span style="color: #cc66cc;">0</span>-<span style="color: #cc66cc;">9</span><span style="color: #66cc66;">&#93;</span><span style="color: #66cc66;">&#123;</span><span style="color: #cc66cc;">2</span><span style="color: #66cc66;">&#125;</span><span style="color: #66cc66;">&#41;</span>\:<span style="color: #66cc66;">&#40;</span>?P<span style="color: #66cc66;">&lt;</span>minuto<span style="color: #66cc66;">&gt;</span><span style="color: #66cc66;">&#91;</span><span style="color: #cc66cc;">0</span>-<span style="color: #cc66cc;">9</span><span style="color: #66cc66;">&#93;</span><span style="color: #66cc66;">&#123;</span><span style="color: #cc66cc;">2</span><span style="color: #66cc66;">&#125;</span><span style="color: #66cc66;">&#41;</span>\:<span style="color: #66cc66;">&#40;</span>?P<span style="color: #66cc66;">&lt;</span>segundo<span style="color: #66cc66;">&gt;</span><span style="color: #66cc66;">&#91;</span><span style="color: #cc66cc;">0</span>-<span style="color: #cc66cc;">9</span><span style="color: #66cc66;">&#93;</span><span style="color: #66cc66;">&#123;</span><span style="color: #cc66cc;">2</span><span style="color: #66cc66;">&#125;</span><span style="color: #66cc66;">&#41;</span>Z<span style="color: #66cc66;">/</span>;
                        <span style="color: #000000; font-weight: bold;">var</span> result:<span style="color: #0066CC;">Array</span> = patron.<span style="color: #006600;">exec</span><span style="color: #66cc66;">&#40;</span>item.<span style="color: #0066CC;">time</span><span style="color: #66cc66;">&#41;</span>;
                        <span style="color: #000000; font-weight: bold;">var</span> tiempo:<span style="color: #0066CC;">Date</span> = <span style="color: #000000; font-weight: bold;">new</span> <span style="color: #0066CC;">Date</span><span style="color: #66cc66;">&#40;</span>result.<span style="color: #006600;">ano</span>, result.<span style="color: #006600;">mes</span>, result.<span style="color: #006600;">dia</span>, result.<span style="color: #006600;">hora</span>, result.<span style="color: #006600;">minuto</span>, result.<span style="color: #006600;">segundo</span><span style="color: #66cc66;">&#41;</span>;
                        _tiempos.<span style="color: #0066CC;">push</span><span style="color: #66cc66;">&#40;</span>tiempo<span style="color: #66cc66;">&#41;</span>;
                    <span style="color: #66cc66;">&#125;</span>
                <span style="color: #66cc66;">&#125;</span>
            <span style="color: #66cc66;">&#125;</span>
        <span style="color: #66cc66;">&#125;</span>
    <span style="color: #66cc66;">&#125;</span></pre></td></tr></table><p class="theCode" style="display:none;">package  
    {
        import flash.events.Event;
        import flash.net.URLRequest;
        import flash.net.URLLoader;
        import com.yahoo.maps.api.core.location.LatLon;
        
        public dynamic class DatosPath 
        {
            private var ns1:Namespace = new Namespace(&quot;http://www.topografix.com/GPX/1/1&quot;);
            
            public var _coordenadas:Array = new Array();
            public var _elevacion:Array = new Array();
            public var _kilometros:Array = new Array();
            public var _tiempos:Array = new Array();
            public var _velocidad:Array = new Array();
            public var _pendiente:Array = new Array();
            public var _energia:Array = new Array();
            
            public function DatosPath(archivo:String) 
            {
                var xmlLoader:URLLoader = new URLLoader();
                var xmlData:XML = new XML();
                xmlLoader.addEventListener(Event.COMPLETE, LoadXML);
                xmlLoader.load(new URLRequest(archivo));
                default xml namespace = ns1;
                
                function LoadXML(e:Event):void {
                    xmlData = new XML(e.target.data);
                    var puntos:XML = new XML(xmlData.trk.trkseg);
                    
                    for each (var item:XML in puntos.elements()) {
                        // LLenar las matrices con datos de elevación y coordenadas
                        _coordenadas.push(new LatLon(item.@lat, item.@lon));
                        _elevacion.push(Number(item.ele));
                        
                        // Crear la matriz de tiempos  --&gt; 2008-03-16T08:14:06Z  &lt;--
                        var patron:RegExp = /(?P&lt;ano&gt;[0-9]{2})\-(?P&lt;mes&gt;[0-9]{2})\-(?P&lt;dia&gt;[0-9]{2})T(?P&lt;hora&gt;[0-9]{2})\:(?P&lt;minuto&gt;[0-9]{2})\:(?P&lt;segundo&gt;[0-9]{2})Z/;
                        var result:Array = patron.exec(item.time);
                        var tiempo:Date = new Date(result.ano, result.mes, result.dia, result.hora, result.minuto, result.segundo);
                        _tiempos.push(tiempo);
                    }
                }
            }
        }
    }</p></div>
    ";}
categories:
  - AS3 Flex Air
  - Shergpx
tags:
  - as3
  - gpx
  - Shergpx

---
<p style="text-align: justify;">
  El primer problema con el que nos encontramos a la hora de representar sobre un mapa los datos que hay dentro del archivo gpx es el de transferir los datos del archivo a la aplicación Flex. Para esto he creado la clase "DatosPath.as" a la que habrá que pasarle la ruta del archivo y esta se encargará de crear las matrices de datos tanto en coordenadas como en elevación así como de calcular los valores de elevación máxima y mínima de la ruta. La clase es la siguiente:
</p>

<pre lang="actionscript">package  
{
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import com.yahoo.maps.api.core.location.LatLon;
    
    public dynamic class DatosPath 
    {
        private var ns1:Namespace = new Namespace("http://www.topografix.com/GPX/1/1");
        
        public var _coordenadas:Array = new Array();
        public var _elevacion:Array = new Array();
        public var _kilometros:Array = new Array();
        public var _tiempos:Array = new Array();
        public var _velocidad:Array = new Array();
        public var _pendiente:Array = new Array();
        public var _energia:Array = new Array();
        
        public function DatosPath(archivo:String) 
        {
            var xmlLoader:URLLoader = new URLLoader();
            var xmlData:XML = new XML();
            xmlLoader.addEventListener(Event.COMPLETE, LoadXML);
            xmlLoader.load(new URLRequest(archivo));
            default xml namespace = ns1;
            
            function LoadXML(e:Event):void {
                xmlData = new XML(e.target.data);
                var puntos:XML = new XML(xmlData.trk.trkseg);
                
                for each (var item:XML in puntos.elements()) {
                    // LLenar las matrices con datos de elevación y coordenadas
                    _coordenadas.push(new LatLon(item.@lat, item.@lon));
                    _elevacion.push(Number(item.ele));
                    
                    // Crear la matriz de tiempos  --> 2008-03-16T08:14:06Z  &lt;--
                    var patron:RegExp = /(?P&lt;ano>[0-9]{2})\-(?P&lt;mes>[0-9]{2})\-(?P&lt;dia>[0-9]{2})T(?P&lt;hora>[0-9]{2})\:(?P&lt;minuto>[0-9]{2})\:(?P&lt;segundo>[0-9]{2})Z/;
                    var result:Array = patron.exec(item.time);
                    var tiempo:Date = new Date(result.ano, result.mes, result.dia, result.hora, result.minuto, result.segundo);
                    _tiempos.push(tiempo);
                }
            }
        }
    }
}
</pre>

<p style="text-align: justify;">
  Básicamente es la típica estructura en as3 para leer un archivo xml preformateado. Lo más importante a señalar de esta clase es que a causa de un "bug", para que el motor de actionscript sea capaz de entender el xml generado a partir del gpx, hay que asignarle un nombre de espacio por defecto (En la clase es la variable ns1).
</p>

<p style="text-align: justify;">
  Para hacer lo más simple posible el proceso de cálculo de máximo y mínimo se les asignan unos valores iniciales de 0 y 9999 respectivamente para a medida que se crea la matriz de elevaciones y aumentando el valor de máxima elevación y reduciendo el de mínima.
</p>