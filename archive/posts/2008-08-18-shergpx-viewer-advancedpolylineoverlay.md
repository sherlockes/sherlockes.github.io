---
title: 'Shergpx Viewer.  AdvancedPolylineOverlay'
author: Sherlockes
type: post
date: 2008-08-17T22:14:58+00:00
url: /?p=120
mytory_md_visits_count:
  - 1
wp-syntax-cache-content:
  - |
    a:2:{i:1;s:3029:"
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code"><pre class="actionscript3" style="font-family:monospace;">&nbsp;
    <span style="color: #6699cc; font-weight: bold;">var</span> overlay<span style="color: #000066; font-weight: bold;">:</span>PolylineOverlay = <span style="color: #0033ff; font-weight: bold;">new</span> PolylineOverlay<span style="color: #000000;">&#40;</span>0x333333<span style="color: #000066; font-weight: bold;">,</span> <span style="color: #000000; font-weight:bold;">1</span><span style="color: #000066; font-weight: bold;">,</span> <span style="color: #000000; font-weight:bold;">2</span><span style="color: #000066; font-weight: bold;">,</span><span style="color: #0033ff; font-weight: bold;">false</span><span style="color: #000066; font-weight: bold;">,</span> <span style="color: #0033ff; font-weight: bold;">false</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
    overlay<span style="color: #000066; font-weight: bold;">.</span>dataProvider = <span style="color: #000000;">&#91;</span><span style="color: #0033ff; font-weight: bold;">new</span> LatLon<span style="color: #000000;">&#40;</span><span style="color: #000000; font-weight:bold;">33.9455</span><span style="color: #000066; font-weight: bold;">,</span> <span style="color: #000066; font-weight: bold;">-</span><span style="color: #000000; font-weight:bold;">118.4001</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">,</span> <span style="color: #0033ff; font-weight: bold;">new</span> LatLon<span style="color: #000000;">&#40;</span><span style="color: #000000; font-weight:bold;">40.6446</span><span style="color: #000066; font-weight: bold;">,</span> <span style="color: #000066; font-weight: bold;">-</span><span style="color: #000000; font-weight:bold;">73.7948</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">,</span> <span style="color: #0033ff; font-weight: bold;">new</span> LatLon<span style="color: #000000;">&#40;</span><span style="color: #000000; font-weight:bold;">47.448</span><span style="color: #000066; font-weight: bold;">,-</span><span style="color: #000000; font-weight:bold;">122.298</span><span style="color: #000000;">&#41;</span> <span style="color: #000000;">&#93;</span><span style="color: #000066; font-weight: bold;">;</span>
    _map<span style="color: #000066; font-weight: bold;">.</span>overlayManager<span style="color: #000066; font-weight: bold;">.</span>addOverlay<span style="color: #000000;">&#40;</span>overlay<span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span></pre></td></tr></table><p class="theCode" style="display:none;">
    var overlay:PolylineOverlay = new PolylineOverlay(0x333333, 1, 2,false, false);
    overlay.dataProvider = [new LatLon(33.9455, -118.4001), new LatLon(40.6446, -73.7948), new LatLon(47.448,-122.298) ];
    _map.overlayManager.addOverlay(overlay);</p></div>
    ";i:2;s:29502:"
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code"><pre class="actionscript3" style="font-family:monospace;">&nbsp;
    <span style="color: #9900cc; font-weight: bold;">package</span>  sherlockes<span style="color: #000066; font-weight: bold;">.</span>maps
    <span style="color: #000000;">&#123;</span>
        <span style="color: #0033ff; font-weight: bold;">import</span> com<span style="color: #000066; font-weight: bold;">.</span>yahoo<span style="color: #000066; font-weight: bold;">.</span>maps<span style="color: #000066; font-weight: bold;">.</span>api<span style="color: #000066; font-weight: bold;">.</span>overlays<span style="color: #000066; font-weight: bold;">.</span>PolylineOverlay<span style="color: #000066; font-weight: bold;">;</span>
        <span style="color: #0033ff; font-weight: bold;">import</span> com<span style="color: #000066; font-weight: bold;">.</span>yahoo<span style="color: #000066; font-weight: bold;">.</span>maps<span style="color: #000066; font-weight: bold;">.</span>api<span style="color: #000066; font-weight: bold;">.</span>utils<span style="color: #000066; font-weight: bold;">.</span>DistanceResult<span style="color: #000066; font-weight: bold;">;</span>
        <span style="color: #0033ff; font-weight: bold;">import</span> com<span style="color: #000066; font-weight: bold;">.</span>yahoo<span style="color: #000066; font-weight: bold;">.</span>maps<span style="color: #000066; font-weight: bold;">.</span>api<span style="color: #000066; font-weight: bold;">.</span>YahooMap<span style="color: #000066; font-weight: bold;">;</span>
        <span style="color: #0033ff; font-weight: bold;">import</span> com<span style="color: #000066; font-weight: bold;">.</span>yahoo<span style="color: #000066; font-weight: bold;">.</span>maps<span style="color: #000066; font-weight: bold;">.</span>api<span style="color: #000066; font-weight: bold;">.</span>managers<span style="color: #000066; font-weight: bold;">.</span>OverlayManager<span style="color: #000066; font-weight: bold;">;</span>
        <span style="color: #0033ff; font-weight: bold;">import</span> mx<span style="color: #000066; font-weight: bold;">.</span>core<span style="color: #000066; font-weight: bold;">.</span>Application<span style="color: #000066; font-weight: bold;">;</span>
    &nbsp;
        <span style="color: #0033ff; font-weight: bold;">public</span> dynamic <span style="color: #9900cc; font-weight: bold;">class</span> AdvancedPolylineOverlay 
        <span style="color: #000000;">&#123;</span>
            <span style="color: #0033ff; font-weight: bold;">private</span> <span style="color: #6699cc; font-weight: bold;">var</span> max_pendiente<span style="color: #000066; font-weight: bold;">:</span><span style="color: #004993;">Number</span> = <span style="color: #000000; font-weight:bold;">0</span><span style="color: #000066; font-weight: bold;">;</span>
            <span style="color: #0033ff; font-weight: bold;">private</span> <span style="color: #6699cc; font-weight: bold;">var</span> longitud<span style="color: #000066; font-weight: bold;">:</span><span style="color: #004993;">Number</span> = <span style="color: #000000; font-weight:bold;">0</span><span style="color: #000066; font-weight: bold;">;</span>
            <span style="color: #0033ff; font-weight: bold;">private</span> <span style="color: #6699cc; font-weight: bold;">var</span> _polylines<span style="color: #000066; font-weight: bold;">:</span><span style="color: #004993;">Array</span> = <span style="color: #0033ff; font-weight: bold;">new</span> <span style="color: #004993;">Array</span><span style="color: #000000;">&#40;</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
            <span style="color: #0033ff; font-weight: bold;">private</span> <span style="color: #6699cc; font-weight: bold;">var</span> colores<span style="color: #000066; font-weight: bold;">:</span><span style="color: #004993;">Array</span> = <span style="color: #000000;">&#91;</span>0x06f800<span style="color: #000066; font-weight: bold;">,</span> 0x1ed400<span style="color: #000066; font-weight: bold;">,</span> 0x3fb80c<span style="color: #000066; font-weight: bold;">,</span> 0x5ba218<span style="color: #000066; font-weight: bold;">,</span> 0x748e23<span style="color: #000066; font-weight: bold;">,</span> 0x8e792c<span style="color: #000066; font-weight: bold;">,</span> 0x9e692d<span style="color: #000066; font-weight: bold;">,</span> 0xad5a2b<span style="color: #000066; font-weight: bold;">,</span> 0xbb4a26<span style="color: #000066; font-weight: bold;">,</span> 0xce381e<span style="color: #000066; font-weight: bold;">,</span> 0xff0000<span style="color: #000000;">&#93;</span><span style="color: #000066; font-weight: bold;">;</span>
    &nbsp;
            <span style="color: #0033ff; font-weight: bold;">public</span> <span style="color: #339966; font-weight: bold;">function</span> AdvancedPolylineOverlay<span style="color: #000000;">&#40;</span>mapa<span style="color: #000066; font-weight: bold;">:</span>YahooMap<span style="color: #000066; font-weight: bold;">,</span>datos<span style="color: #000066; font-weight: bold;">:</span>DatosPath<span style="color: #000000;">&#41;</span> 
            <span style="color: #000000;">&#123;</span>
                <span style="color: #6699cc; font-weight: bold;">var</span> elemin<span style="color: #000066; font-weight: bold;">:</span><span style="color: #004993;">Number</span> = Application<span style="color: #000066; font-weight: bold;">.</span>application<span style="color: #000066; font-weight: bold;">.</span>elevmin<span style="color: #000066; font-weight: bold;">;</span>
                <span style="color: #6699cc; font-weight: bold;">var</span> elemax<span style="color: #000066; font-weight: bold;">:</span><span style="color: #004993;">Number</span> = Application<span style="color: #000066; font-weight: bold;">.</span>application<span style="color: #000066; font-weight: bold;">.</span>elevmax<span style="color: #000066; font-weight: bold;">;</span>
    &nbsp;
                <span style="color: #009900; font-style: italic;">// Inicia la matriz de kilómetros, velocidad y pendiente</span>
                datos<span style="color: #000066; font-weight: bold;">.</span>_kilometros = <span style="color: #0033ff; font-weight: bold;">new</span> <span style="color: #004993;">Array</span><span style="color: #000000;">&#40;</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
                datos<span style="color: #000066; font-weight: bold;">.</span>_kilometros<span style="color: #000066; font-weight: bold;">.</span><span style="color: #004993;">push</span><span style="color: #000000;">&#40;</span><span style="color: #000000; font-weight:bold;">0</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
                datos<span style="color: #000066; font-weight: bold;">.</span>_velocidad = <span style="color: #0033ff; font-weight: bold;">new</span> <span style="color: #004993;">Array</span><span style="color: #000000;">&#40;</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
                datos<span style="color: #000066; font-weight: bold;">.</span>_velocidad<span style="color: #000066; font-weight: bold;">.</span><span style="color: #004993;">push</span><span style="color: #000000;">&#40;</span><span style="color: #000000; font-weight:bold;">0</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
                datos<span style="color: #000066; font-weight: bold;">.</span>_pendiente = <span style="color: #0033ff; font-weight: bold;">new</span> <span style="color: #004993;">Array</span><span style="color: #000000;">&#40;</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
                datos<span style="color: #000066; font-weight: bold;">.</span>_pendiente<span style="color: #000066; font-weight: bold;">.</span><span style="color: #004993;">push</span><span style="color: #000000;">&#40;</span><span style="color: #000000; font-weight:bold;">0</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
    &nbsp;
                <span style="color: #6699cc; font-weight: bold;">var</span> i<span style="color: #000066; font-weight: bold;">:</span><span style="color: #004993;">uint</span>
                <span style="color: #0033ff; font-weight: bold;">for</span> <span style="color: #000000;">&#40;</span>i = <span style="color: #000000; font-weight:bold;">0</span><span style="color: #000066; font-weight: bold;">;</span> i <span style="color: #000066; font-weight: bold;">&lt;</span> datos<span style="color: #000066; font-weight: bold;">.</span>_coordenadas<span style="color: #000066; font-weight: bold;">.</span>length<span style="color: #000066; font-weight: bold;">-</span><span style="color: #000000; font-weight:bold;">1</span><span style="color: #000066; font-weight: bold;">;</span> i<span style="color: #000066; font-weight: bold;">++</span><span style="color: #000000;">&#41;</span>
                <span style="color: #000000;">&#123;</span>
                    <span style="color: #009900; font-style: italic;">// Creando el trozo de polilínea</span>
                    <span style="color: #0033ff; font-weight: bold;">this</span><span style="color: #000000;">&#91;</span><span style="color: #990000;">&quot;linea&quot;</span> <span style="color: #000066; font-weight: bold;">+</span> i<span style="color: #000000;">&#93;</span> = <span style="color: #0033ff; font-weight: bold;">new</span> PolylineOverlay<span style="color: #000000;">&#40;</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
                    _polylines<span style="color: #000066; font-weight: bold;">.</span><span style="color: #004993;">push</span><span style="color: #000000;">&#40;</span><span style="color: #0033ff; font-weight: bold;">this</span><span style="color: #000000;">&#91;</span><span style="color: #990000;">&quot;linea&quot;</span> <span style="color: #000066; font-weight: bold;">+</span> i<span style="color: #000000;">&#93;</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
    &nbsp;
                    <span style="color: #0033ff; font-weight: bold;">this</span><span style="color: #000000;">&#91;</span><span style="color: #990000;">&quot;linea&quot;</span> <span style="color: #000066; font-weight: bold;">+</span> i<span style="color: #000000;">&#93;</span><span style="color: #000066; font-weight: bold;">.</span>lineThickness = <span style="color: #000000; font-weight:bold;">3</span><span style="color: #000066; font-weight: bold;">;</span>
    &nbsp;
                    <span style="color: #6699cc; font-weight: bold;">var</span> <span style="color: #004993;">color</span><span style="color: #000066; font-weight: bold;">:</span><span style="color: #004993;">Number</span> = <span style="color: #004993;">Math</span><span style="color: #000066; font-weight: bold;">.</span><span style="color: #004993;">round</span><span style="color: #000000;">&#40;</span><span style="color: #000000; font-weight:bold;">10</span><span style="color: #000066; font-weight: bold;">*</span><span style="color: #000000;">&#40;</span><span style="color: #004993;">Number</span><span style="color: #000000;">&#40;</span>datos<span style="color: #000066; font-weight: bold;">.</span>_elevacion<span style="color: #000000;">&#91;</span>i<span style="color: #000000;">&#93;</span><span style="color: #000000;">&#41;</span> <span style="color: #000066; font-weight: bold;">-</span> elemin<span style="color: #000000;">&#41;</span> <span style="color: #000066; font-weight: bold;">/</span> <span style="color: #000000;">&#40;</span>elemax <span style="color: #000066; font-weight: bold;">-</span> elemin<span style="color: #000000;">&#41;</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
                    <span style="color: #0033ff; font-weight: bold;">if</span> <span style="color: #000000;">&#40;</span><span style="color: #004993;">color</span> <span style="color: #000066; font-weight: bold;">&lt;</span> <span style="color: #000000; font-weight:bold;">0</span><span style="color: #000000;">&#41;</span><span style="color: #000000;">&#123;</span><span style="color: #004993;">color</span> = <span style="color: #000000; font-weight:bold;">0</span> <span style="color: #000000;">&#125;</span> <span style="color: #0033ff; font-weight: bold;">else</span> <span style="color: #0033ff; font-weight: bold;">if</span> <span style="color: #000000;">&#40;</span><span style="color: #004993;">color</span> <span style="color: #000066; font-weight: bold;">&gt;</span> <span style="color: #000000; font-weight:bold;">10</span><span style="color: #000000;">&#41;</span><span style="color: #000000;">&#123;</span><span style="color: #004993;">color</span> = <span style="color: #000000; font-weight:bold;">10</span> <span style="color: #000000;">&#125;</span><span style="color: #000066; font-weight: bold;">;</span>
    &nbsp;
                    <span style="color: #0033ff; font-weight: bold;">this</span><span style="color: #000000;">&#91;</span><span style="color: #990000;">&quot;linea&quot;</span> <span style="color: #000066; font-weight: bold;">+</span> i<span style="color: #000000;">&#93;</span><span style="color: #000066; font-weight: bold;">.</span>lineColor = colores<span style="color: #000000;">&#91;</span><span style="color: #004993;">color</span><span style="color: #000000;">&#93;</span><span style="color: #000066; font-weight: bold;">;</span>
                    <span style="color: #0033ff; font-weight: bold;">this</span><span style="color: #000000;">&#91;</span><span style="color: #990000;">&quot;linea&quot;</span> <span style="color: #000066; font-weight: bold;">+</span> i<span style="color: #000000;">&#93;</span><span style="color: #000066; font-weight: bold;">.</span><span style="color: #004993;">mouseEnabled</span> = <span style="color: #0033ff; font-weight: bold;">false</span><span style="color: #000066; font-weight: bold;">;</span>
    &nbsp;
                    mapa<span style="color: #000066; font-weight: bold;">.</span>overlayManager<span style="color: #000066; font-weight: bold;">.</span>addOverlay<span style="color: #000000;">&#40;</span><span style="color: #0033ff; font-weight: bold;">this</span><span style="color: #000000;">&#91;</span><span style="color: #990000;">&quot;linea&quot;</span> <span style="color: #000066; font-weight: bold;">+</span> i<span style="color: #000000;">&#93;</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
                    <span style="color: #0033ff; font-weight: bold;">this</span><span style="color: #000000;">&#91;</span><span style="color: #990000;">&quot;linea&quot;</span> <span style="color: #000066; font-weight: bold;">+</span> i<span style="color: #000000;">&#93;</span><span style="color: #000066; font-weight: bold;">.</span>dataProvider = <span style="color: #000000;">&#91;</span>datos<span style="color: #000066; font-weight: bold;">.</span>_coordenadas<span style="color: #000000;">&#91;</span>i<span style="color: #000000;">&#93;</span><span style="color: #000066; font-weight: bold;">,</span> datos<span style="color: #000066; font-weight: bold;">.</span>_coordenadas<span style="color: #000000;">&#91;</span>i <span style="color: #000066; font-weight: bold;">+</span> <span style="color: #000000; font-weight:bold;">1</span><span style="color: #000000;">&#93;</span><span style="color: #000000;">&#93;</span><span style="color: #000066; font-weight: bold;">;</span>
    &nbsp;
                    <span style="color: #009900; font-style: italic;">// Calcular distancia recorrida</span>
                    <span style="color: #6699cc; font-weight: bold;">var</span> trozo<span style="color: #000066; font-weight: bold;">:</span>DistanceResult = <span style="color: #0033ff; font-weight: bold;">this</span><span style="color: #000000;">&#91;</span><span style="color: #990000;">&quot;linea&quot;</span> <span style="color: #000066; font-weight: bold;">+</span> i<span style="color: #000000;">&#93;</span><span style="color: #000066; font-weight: bold;">.</span>getDistance<span style="color: #000000;">&#40;</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
                    longitud <span style="color: #000066; font-weight: bold;">+</span>= trozo<span style="color: #000066; font-weight: bold;">.</span>kilometers<span style="color: #000066; font-weight: bold;">;</span>
    &nbsp;
                    <span style="color: #009900; font-style: italic;">// Calcular la velocidad en el tramo y pendiente</span>
                    <span style="color: #6699cc; font-weight: bold;">var</span> tiempo<span style="color: #000066; font-weight: bold;">:</span><span style="color: #004993;">Number</span> = <span style="color: #000000;">&#40;</span>datos<span style="color: #000066; font-weight: bold;">.</span>_tiempos<span style="color: #000000;">&#91;</span>i <span style="color: #000066; font-weight: bold;">+</span> <span style="color: #000000; font-weight:bold;">1</span><span style="color: #000000;">&#93;</span><span style="color: #000066; font-weight: bold;">.</span><span style="color: #004993;">getTime</span><span style="color: #000000;">&#40;</span><span style="color: #000000;">&#41;</span> <span style="color: #000066; font-weight: bold;">-</span> datos<span style="color: #000066; font-weight: bold;">.</span>_tiempos<span style="color: #000000;">&#91;</span>i<span style="color: #000000;">&#93;</span><span style="color: #000066; font-weight: bold;">.</span><span style="color: #004993;">getTime</span><span style="color: #000000;">&#40;</span><span style="color: #000000;">&#41;</span><span style="color: #000000;">&#41;</span> <span style="color: #000066; font-weight: bold;">/</span> <span style="color: #000000;">&#40;</span><span style="color: #000000; font-weight:bold;">1000</span> <span style="color: #000066; font-weight: bold;">*</span> <span style="color: #000000; font-weight:bold;">60</span> <span style="color: #000066; font-weight: bold;">*</span> <span style="color: #000000; font-weight:bold;">60</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
                    <span style="color: #6699cc; font-weight: bold;">var</span> pend<span style="color: #000066; font-weight: bold;">:</span><span style="color: #004993;">int</span> = <span style="color: #000000; font-weight:bold;">1000</span><span style="color: #000066; font-weight: bold;">*</span><span style="color: #000000;">&#40;</span>datos<span style="color: #000066; font-weight: bold;">.</span>_elevacion<span style="color: #000000;">&#91;</span>i <span style="color: #000066; font-weight: bold;">+</span> <span style="color: #000000; font-weight:bold;">1</span><span style="color: #000000;">&#93;</span> <span style="color: #000066; font-weight: bold;">-</span> datos<span style="color: #000066; font-weight: bold;">.</span>_elevacion<span style="color: #000000;">&#91;</span>i<span style="color: #000000;">&#93;</span><span style="color: #000000;">&#41;</span> <span style="color: #000066; font-weight: bold;">/</span> trozo<span style="color: #000066; font-weight: bold;">.</span>meters<span style="color: #000066; font-weight: bold;">;</span>
                    <span style="color: #6699cc; font-weight: bold;">var</span> pendiente<span style="color: #000066; font-weight: bold;">:</span><span style="color: #004993;">Number</span> = pend <span style="color: #000066; font-weight: bold;">/</span> <span style="color: #000000; font-weight:bold;">10</span><span style="color: #000066; font-weight: bold;">;</span>
    &nbsp;
                    datos<span style="color: #000066; font-weight: bold;">.</span>_velocidad<span style="color: #000066; font-weight: bold;">.</span><span style="color: #004993;">push</span><span style="color: #000000;">&#40;</span>trozo<span style="color: #000066; font-weight: bold;">.</span>kilometers <span style="color: #000066; font-weight: bold;">/</span> tiempo<span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
                    datos<span style="color: #000066; font-weight: bold;">.</span>_pendiente<span style="color: #000066; font-weight: bold;">.</span><span style="color: #004993;">push</span><span style="color: #000000;">&#40;</span>pendiente<span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
    &nbsp;
                    <span style="color: #009900; font-style: italic;">// Construye la matriz kilómetros redondeado a décima de km</span>
                    datos<span style="color: #000066; font-weight: bold;">.</span>_kilometros<span style="color: #000066; font-weight: bold;">.</span><span style="color: #004993;">push</span><span style="color: #000000;">&#40;</span><span style="color: #004993;">Math</span><span style="color: #000066; font-weight: bold;">.</span><span style="color: #004993;">round</span><span style="color: #000000;">&#40;</span><span style="color: #000000; font-weight:bold;">10</span> <span style="color: #000066; font-weight: bold;">*</span> longitud<span style="color: #000000;">&#41;</span> <span style="color: #000066; font-weight: bold;">/</span> <span style="color: #000000; font-weight:bold;">10</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
                <span style="color: #000000;">&#125;</span>
            <span style="color: #000000;">&#125;</span>
    &nbsp;
            <span style="color: #0033ff; font-weight: bold;">public</span> <span style="color: #339966; font-weight: bold;">function</span> <span style="color: #0033ff; font-weight: bold;">set</span> <span style="color: #004993;">visible</span><span style="color: #000000;">&#40;</span><span style="color: #004993;">value</span><span style="color: #000066; font-weight: bold;">:</span><span style="color: #004993;">Boolean</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">:</span><span style="color: #0033ff; font-weight: bold;">void</span> 
            <span style="color: #000000;">&#123;</span>
                <span style="color: #6699cc; font-weight: bold;">var</span> i<span style="color: #000066; font-weight: bold;">:</span><span style="color: #004993;">uint</span><span style="color: #000066; font-weight: bold;">;</span>
                <span style="color: #0033ff; font-weight: bold;">for</span> <span style="color: #000000;">&#40;</span>i = <span style="color: #000000; font-weight:bold;">0</span><span style="color: #000066; font-weight: bold;">;</span> i <span style="color: #000066; font-weight: bold;">&lt;</span> _polylines<span style="color: #000066; font-weight: bold;">.</span><span style="color: #004993;">length</span><span style="color: #000066; font-weight: bold;">;</span> i<span style="color: #000066; font-weight: bold;">++</span><span style="color: #000000;">&#41;</span>
                <span style="color: #000000;">&#123;</span>
                    _polylines<span style="color: #000000;">&#91;</span>i<span style="color: #000000;">&#93;</span><span style="color: #000066; font-weight: bold;">.</span><span style="color: #004993;">visible</span> = <span style="color: #004993;">value</span><span style="color: #000066; font-weight: bold;">;</span>
                <span style="color: #000000;">&#125;</span>
            <span style="color: #000000;">&#125;</span>
            <span style="color: #0033ff; font-weight: bold;">public</span> <span style="color: #339966; font-weight: bold;">function</span> borrar<span style="color: #000000;">&#40;</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">:</span><span style="color: #0033ff; font-weight: bold;">void</span>
            <span style="color: #000000;">&#123;</span>
                <span style="color: #6699cc; font-weight: bold;">var</span> i<span style="color: #000066; font-weight: bold;">:</span><span style="color: #004993;">uint</span><span style="color: #000066; font-weight: bold;">;</span>
                <span style="color: #0033ff; font-weight: bold;">for</span> <span style="color: #000000;">&#40;</span>i = <span style="color: #000000; font-weight:bold;">0</span><span style="color: #000066; font-weight: bold;">;</span> i <span style="color: #000066; font-weight: bold;">&lt;</span> _polylines<span style="color: #000066; font-weight: bold;">.</span><span style="color: #004993;">length</span><span style="color: #000066; font-weight: bold;">;</span> i<span style="color: #000066; font-weight: bold;">++</span><span style="color: #000000;">&#41;</span>
                <span style="color: #000000;">&#123;</span>
                    _polylines<span style="color: #000000;">&#91;</span>i<span style="color: #000000;">&#93;</span><span style="color: #000066; font-weight: bold;">.</span>destroy<span style="color: #000000;">&#40;</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
                    _polylines<span style="color: #000000;">&#91;</span>i<span style="color: #000000;">&#93;</span><span style="color: #000066; font-weight: bold;">.</span><span style="color: #004993;">graphics</span><span style="color: #000066; font-weight: bold;">.</span><span style="color: #004993;">clear</span><span style="color: #000000;">&#40;</span><span style="color: #000000;">&#41;</span><span style="color: #000066; font-weight: bold;">;</span>
                <span style="color: #000000;">&#125;</span>
    &nbsp;
            <span style="color: #000000;">&#125;</span>
        <span style="color: #000000;">&#125;</span>
    <span style="color: #000000;">&#125;</span></pre></td></tr></table><p class="theCode" style="display:none;">
    package  sherlockes.maps
    {
        import com.yahoo.maps.api.overlays.PolylineOverlay;
        import com.yahoo.maps.api.utils.DistanceResult;
        import com.yahoo.maps.api.YahooMap;
        import com.yahoo.maps.api.managers.OverlayManager;
        import mx.core.Application;
        
        public dynamic class AdvancedPolylineOverlay 
        {
            private var max_pendiente:Number = 0;
            private var longitud:Number = 0;
            private var _polylines:Array = new Array();
            private var colores:Array = [0x06f800, 0x1ed400, 0x3fb80c, 0x5ba218, 0x748e23, 0x8e792c, 0x9e692d, 0xad5a2b, 0xbb4a26, 0xce381e, 0xff0000];
            
            public function AdvancedPolylineOverlay(mapa:YahooMap,datos:DatosPath) 
            {
                var elemin:Number = Application.application.elevmin;
                var elemax:Number = Application.application.elevmax;
                
                // Inicia la matriz de kilómetros, velocidad y pendiente
                datos._kilometros = new Array();
                datos._kilometros.push(0);
                datos._velocidad = new Array();
                datos._velocidad.push(0);
                datos._pendiente = new Array();
                datos._pendiente.push(0);
                
                var i:uint
                for (i = 0; i &lt; datos._coordenadas.length-1; i++)
                {
                    // Creando el trozo de polilínea
                    this[&quot;linea&quot; + i] = new PolylineOverlay();
                    _polylines.push(this[&quot;linea&quot; + i]);
                    
                    this[&quot;linea&quot; + i].lineThickness = 3;
                    
                    var color:Number = Math.round(10*(Number(datos._elevacion[i]) - elemin) / (elemax - elemin));
                    if (color &lt; 0){color = 0 } else if (color &gt; 10){color = 10 };
                    
                    this[&quot;linea&quot; + i].lineColor = colores[color];
                    this[&quot;linea&quot; + i].mouseEnabled = false;
                    
                    mapa.overlayManager.addOverlay(this[&quot;linea&quot; + i]);
                    this[&quot;linea&quot; + i].dataProvider = [datos._coordenadas[i], datos._coordenadas[i + 1]];
                    
                    // Calcular distancia recorrida
                    var trozo:DistanceResult = this[&quot;linea&quot; + i].getDistance();
                    longitud += trozo.kilometers;
                    
                    // Calcular la velocidad en el tramo y pendiente
                    var tiempo:Number = (datos._tiempos[i + 1].getTime() - datos._tiempos[i].getTime()) / (1000 * 60 * 60);
                    var pend:int = 1000*(datos._elevacion[i + 1] - datos._elevacion[i]) / trozo.meters;
                    var pendiente:Number = pend / 10;
                    
                    datos._velocidad.push(trozo.kilometers / tiempo);
                    datos._pendiente.push(pendiente);
                    
                    // Construye la matriz kilómetros redondeado a décima de km
                    datos._kilometros.push(Math.round(10 * longitud) / 10);
                }
            }
            
            public function set visible(value:Boolean):void 
            {
                var i:uint;
                for (i = 0; i &lt; _polylines.length; i++)
                {
                    _polylines[i].visible = value;
                }
            }
            public function borrar():void
            {
                var i:uint;
                for (i = 0; i &lt; _polylines.length; i++)
                {
                    _polylines[i].destroy();
                    _polylines[i].graphics.clear();
                }
                
            }
        }
    }</p></div>
    ";}
categories:
  - AS3 Flex Air
tags:
  - Shergpx

---
La API de Yahoo Maps para AS3 tiene la clase [PolylineOverlay][1] para dibujar líneas o rutas sobre el mapa de una forma sencilla y rápida. El siguiente ejemplo como se dibuja un trazo

<pre lang="actionscript3">var overlay:PolylineOverlay = new PolylineOverlay(0x333333, 1, 2,false, false);
overlay.dataProvider = [new LatLon(33.9455, -118.4001), new LatLon(40.6446, -73.7948), new LatLon(47.448,-122.298) ];
_map.overlayManager.addOverlay(overlay);

</pre>

En primer lugar se crea la polilínea (Asignando color, transparencia, anchura&#8230;), después se le asigna una matriz de datos con las coordenadas por las que pasa la polilínea y finalmente se le asigna al mapa con el que estamos trabajando mediante su correspondiente "overlayManager".

Para la representación de la altitud de la ruta mediante un código de colores esta clase no es suficiente por lo que es necesario crear una clase "AdvancedPolylineOverlay" que entre otras cosas sea capaz de este modo de dibujo. Para crear la ruta, deberemos pasar a la clase por un lado el nombre del mapa donde la queremos dibujar y por otro un proveedor de datos en forma de variable "DatosPath" que vimos en un post [anterior][2]. La clase crea un trazo compuesto por varios segmentos cada uno de los cuales del color correspondiente a la altitud de la ruta en ese punto. La clase también calcula la distancia, velocidad y pendiente en todos los puntos de la ruta para posteriormente guardar esta información dentro de la variable "DatosPath" de forma que pueda ser utilizada en las distintas representaciones gráficas.

La clase completa queda así:

<pre lang="actionscript3">package  sherlockes.maps
{
    import com.yahoo.maps.api.overlays.PolylineOverlay;
    import com.yahoo.maps.api.utils.DistanceResult;
    import com.yahoo.maps.api.YahooMap;
    import com.yahoo.maps.api.managers.OverlayManager;
    import mx.core.Application;
    
    public dynamic class AdvancedPolylineOverlay 
    {
        private var max_pendiente:Number = 0;
        private var longitud:Number = 0;
        private var _polylines:Array = new Array();
        private var colores:Array = [0x06f800, 0x1ed400, 0x3fb80c, 0x5ba218, 0x748e23, 0x8e792c, 0x9e692d, 0xad5a2b, 0xbb4a26, 0xce381e, 0xff0000];
        
        public function AdvancedPolylineOverlay(mapa:YahooMap,datos:DatosPath) 
        {
            var elemin:Number = Application.application.elevmin;
            var elemax:Number = Application.application.elevmax;
            
            // Inicia la matriz de kilómetros, velocidad y pendiente
            datos._kilometros = new Array();
            datos._kilometros.push(0);
            datos._velocidad = new Array();
            datos._velocidad.push(0);
            datos._pendiente = new Array();
            datos._pendiente.push(0);
            
            var i:uint
            for (i = 0; i &lt; datos._coordenadas.length-1; i++)
            {
                // Creando el trozo de polilínea
                this["linea" + i] = new PolylineOverlay();
                _polylines.push(this["linea" + i]);
                
                this["linea" + i].lineThickness = 3;
                
                var color:Number = Math.round(10*(Number(datos._elevacion[i]) - elemin) / (elemax - elemin));
                if (color &lt; 0){color = 0 } else if (color > 10){color = 10 };
                
                this["linea" + i].lineColor = colores[color];
                this["linea" + i].mouseEnabled = false;
                
                mapa.overlayManager.addOverlay(this["linea" + i]);
                this["linea" + i].dataProvider = [datos._coordenadas[i], datos._coordenadas[i + 1]];
                
                // Calcular distancia recorrida
                var trozo:DistanceResult = this["linea" + i].getDistance();
                longitud += trozo.kilometers;
                
                // Calcular la velocidad en el tramo y pendiente
                var tiempo:Number = (datos._tiempos[i + 1].getTime() - datos._tiempos[i].getTime()) / (1000 * 60 * 60);
                var pend:int = 1000*(datos._elevacion[i + 1] - datos._elevacion[i]) / trozo.meters;
                var pendiente:Number = pend / 10;
                
                datos._velocidad.push(trozo.kilometers / tiempo);
                datos._pendiente.push(pendiente);
                
                // Construye la matriz kilómetros redondeado a décima de km
                datos._kilometros.push(Math.round(10 * longitud) / 10);
            }
        }
        
        public function set visible(value:Boolean):void 
        {
            var i:uint;
            for (i = 0; i &lt; _polylines.length; i++)
            {
                _polylines[i].visible = value;
            }
        }
        public function borrar():void
        {
            var i:uint;
            for (i = 0; i &lt; _polylines.length; i++)
            {
                _polylines[i].destroy();
                _polylines[i].graphics.clear();
            }
            
        }
    }
}

</pre>

Si queda alguna duda no dudes en dejar un comentario e intentaré explicarla.

 [1]: http://developer.yahoo.com/flash/maps/classreference/com/yahoo/maps/api/overlays/PolylineOverlay.html
 [2]: http://sherver.homeip.net/blog/?p=68