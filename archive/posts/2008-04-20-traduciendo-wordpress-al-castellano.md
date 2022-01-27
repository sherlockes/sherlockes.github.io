---
title: Traduciendo WordPress al castellano
author: Sherlockes
type: post
date: 2008-04-20T15:55:03+00:00
url: /?p=61
mytory_md_visits_count:
  - 3
wp-syntax-cache-content:
  - |
    a:1:{i:1;s:3973:"
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code"><pre class="php" style="font-family:monospace;"><span style="color: #000000; font-weight: bold;">&lt;?php</span>
    <span style="color: #666666; font-style: italic;">// ** MySQL settings ** //</span>
    <span style="color: #990000;">define</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">'DB_NAME'</span><span style="color: #339933;">,</span> <span style="color: #0000ff;">'*****'</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #990000;">define</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">'DB_USER'</span><span style="color: #339933;">,</span> <span style="color: #0000ff;">'*****'</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #990000;">define</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">'DB_PASSWORD'</span><span style="color: #339933;">,</span> <span style="color: #0000ff;">'*****'</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #990000;">define</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">'DB_HOST'</span><span style="color: #339933;">,</span> <span style="color: #0000ff;">'*****'</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #990000;">define</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">'DB_CHARSET'</span><span style="color: #339933;">,</span> <span style="color: #0000ff;">'utf8'</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #990000;">define</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">'DB_COLLATE'</span><span style="color: #339933;">,</span> <span style="color: #0000ff;">'utf8_spanish_ci'</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    &nbsp;
    <span style="color: #000088;">$table_prefix</span>  <span style="color: #339933;">=</span> <span style="color: #0000ff;">'wp_'</span><span style="color: #339933;">;</span>
    <span style="color: #990000;">define</span> <span style="color: #009900;">&#40;</span><span style="color: #0000ff;">'WPLANG'</span><span style="color: #339933;">,</span> <span style="color: #0000ff;">'es_ES'</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span> <span style="color: #666666; font-style: italic;">// !!!! Sólo hay que modificar esto !!!!</span>
    <span style="color: #990000;">define</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">'ABSPATH'</span><span style="color: #339933;">,</span> <span style="color: #990000;">dirname</span><span style="color: #009900;">&#40;</span><span style="color: #009900; font-weight: bold;">__FILE__</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">.</span><span style="color: #0000ff;">'/'</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #b1b100;">require_once</span><span style="color: #009900;">&#40;</span>ABSPATH<span style="color: #339933;">.</span><span style="color: #0000ff;">'wp-settings.php'</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #000000; font-weight: bold;">?&gt;</span></pre></td></tr></table><p class="theCode" style="display:none;">&lt;?php
    // ** MySQL settings ** //
    define('DB_NAME', '*****');
    define('DB_USER', '*****');
    define('DB_PASSWORD', '*****');
    define('DB_HOST', '*****');
    define('DB_CHARSET', 'utf8');
    define('DB_COLLATE', 'utf8_spanish_ci');
    
    $table_prefix  = 'wp_';
    define ('WPLANG', 'es_ES'); // !!!! Sólo hay que modificar esto !!!!
    define('ABSPATH', dirname(__FILE__).'/');
    require_once(ABSPATH.'wp-settings.php');
    ?&gt;</p></div>
    ";}
categories:
  - Software
  - Wordpress
tags:
  - wordpress

---
<p style="text-align: justify;">
  Para traducir WordPress al castellano hay dos alternativas. La primera de ellas es descargar los archivos de instalación directamente en castellano. En "<a href="http://ayudawordpress.com/wordpress-espanol/" target="_blank">Ayuda WordPress</a>" hacen paquetes de instalación de WordPress directamente en castellano de forma que la manera más sencilla y rápida pero tiene el inconveniente de que no hacen versiones de todas las actualizaciones y que pasa un tiempo desde que se lanza la versión oficial hasta que sale la traducida. Si queremos optar por esta vía tan sólo hay que descargar la última versión desde el link anterior y seguir el proceso de instalación tal y como expliqué en un <a href="http://www.sherver.synology.me/sherblog/?p=55" target="_self">post anterior</a>.
</p>

<p style="text-align: justify;">
  La otra alternativa es instalar el paquete oficial de WordPress y posteriormente traducirlo al castellano. Para esto es necesario descargar el archivo de idioma para la versión de WordPress que tengamos instalada. En la web de <a href="http://carrero.es/wordpress-en-castellano" target="_blank">Carrero</a> tienen estos archivos listos para descargar de forma que seguiremos los siguientes pasos.
</p>

  1. Descargar el archivo de idioma (<a href="http://carrero.es/wp-content/uploads/2008/03/wp-25-castellano.zip" target="_blank">De la web de Carrero</a> o bien <a href="wp-content/uploads/files/es_es.mo" target="_blank">es_es</a><a href="http://carrero.es/wp-content/uploads/2008/03/wp-25-castellano.zip" target="_blank"></a>)
  2. Dentro de la carpeta "wp-content" crear una nueva "languages".
  3. Descomprimir el archivo "es_ES.mo" dentro de la carpeta creada.
  4. Editar el archivo "wp-config.php" para que quede como el siguiente.

<pre lang="php"><?php
// ** MySQL settings ** //
define('DB_NAME', '*****');
define('DB_USER', '*****');
define('DB_PASSWORD', '*****');
define('DB_HOST', '*****');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', 'utf8_spanish_ci');

$table_prefix  = 'wp_';
define ('WPLANG', 'es_ES'); // !!!! Sólo hay que modificar esto !!!!
define('ABSPATH', dirname(__FILE__).'/');
require_once(ABSPATH.'wp-settings.php');
?>
</pre>

<p style="text-align: justify;">
  Con estos sencillos pasos ya podremos abrir nuevamente nuestro blog y ver como se ha traducido al castellano. Es posible que en función del tema que estemos utilizando queden algunas palabras en inglés para lo que habrá que modificar directamente las plantillas de tema, pero esto será otro día.
</p>