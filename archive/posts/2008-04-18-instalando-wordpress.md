---
title: Instalando WordPress
author: Sherlockes
type: post
date: 2008-04-18T15:04:29+00:00
url: /?p=55
mytory_md_visits_count:
  - 5
wp-syntax-cache-content:
  - |
    a:1:{i:1;s:4189:"
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code"><pre class="php" style="font-family:monospace;"><span style="color: #000000; font-weight: bold;">&lt;?php</span>
    <span style="color: #666666; font-style: italic;">// ** MySQL settings ** //</span>
    <span style="color: #990000;">define</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">'DB_NAME'</span><span style="color: #339933;">,</span> <span style="color: #0000ff;">'wpprueba'</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #990000;">define</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">'DB_USER'</span><span style="color: #339933;">,</span> <span style="color: #0000ff;">'usuario'</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #990000;">define</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">'DB_PASSWORD'</span><span style="color: #339933;">,</span> <span style="color: #0000ff;">'password'</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #990000;">define</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">'DB_HOST'</span><span style="color: #339933;">,</span> <span style="color: #0000ff;">'localhost'</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #990000;">define</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">'DB_CHARSET'</span><span style="color: #339933;">,</span> <span style="color: #0000ff;">'utf8'</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #990000;">define</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">'DB_COLLATE'</span><span style="color: #339933;">,</span> <span style="color: #0000ff;">''</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    &nbsp;
    <span style="color: #990000;">define</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">'SECRET_KEY'</span><span style="color: #339933;">,</span> <span style="color: #0000ff;">'put your unique phrase here'</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #000088;">$table_prefix</span>  <span style="color: #339933;">=</span> <span style="color: #0000ff;">'wp_'</span><span style="color: #339933;">;</span>
    <span style="color: #990000;">define</span> <span style="color: #009900;">&#40;</span><span style="color: #0000ff;">'WPLANG'</span><span style="color: #339933;">,</span> <span style="color: #0000ff;">''</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #990000;">define</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">'ABSPATH'</span><span style="color: #339933;">,</span> <span style="color: #990000;">dirname</span><span style="color: #009900;">&#40;</span><span style="color: #009900; font-weight: bold;">__FILE__</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">.</span><span style="color: #0000ff;">'/'</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #b1b100;">require_once</span><span style="color: #009900;">&#40;</span>ABSPATH<span style="color: #339933;">.</span><span style="color: #0000ff;">'wp-settings.php'</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #000000; font-weight: bold;">?&gt;</span></pre></td></tr></table><p class="theCode" style="display:none;">&lt;?php
    // ** MySQL settings ** //
    define('DB_NAME', 'wpprueba');
    define('DB_USER', 'usuario');
    define('DB_PASSWORD', 'password');
    define('DB_HOST', 'localhost');
    define('DB_CHARSET', 'utf8');
    define('DB_COLLATE', '');
    
    define('SECRET_KEY', 'put your unique phrase here');
    $table_prefix  = 'wp_';
    define ('WPLANG', '');
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
  Una vez que ya tenemos instalado el servidor apache y mysql con php y phpmyadmin como ya vimos en un post <a href="http://sherver.homeip.net/blog/?p=28" target="_self">anterior</a>, estamos en condiciones de instalar wordpress. Para ello seguiremos los siguientes pasos:
</p>

<p style="padding-left: 30px; text-align: justify;">
  1.- Descargar la última versión de WordPress desde <a href="http://wordpress.org/download/" target="_blank">aquí</a>. Como estamos trabajando con el servidor en un entorno windows descargaremos un archivo "<a href="http://wordpress.org/latest.zip" target="_blank">latest.zip</a>"
</p>

<p style="padding-left: 30px; text-align: justify;">
  2.- Descomprimimos la carpeta "WordPress" que sale dentro del archivo descargado anteriormente en el directorio raiz de los documentos de nuestro servidor. Si no has modificado nada tras <a href="http://sherver.homeip.net/blog/?p=28" target="_self">instalar XAMPP</a> deberás copiarlo en la carpeta "htdocs" y si no en la ruta que muestre el parámetro "DocumentRoot" del archivo "\apache\conf\httpd.conf" que podemos abrir con el bloc de notas.
</p>

<p style="padding-left: 30px; text-align: justify;">
  3.- Creamos una nueva base de datos para el blog. Para ello accedemos a <a href="http://localhost/phpmyadmin/" target="_blank">phpmyadmin</a>. Desde aquí veremos algo parecido a lo siguiente.
</p>

<center>
  <img src="sherblog/wp-content/uploads/images/20080418_install_wordpress_01.jpeg" />
</center>

<p style="text-align: justify; padding-left: 30px;">
  4.- Con la base de datos creada, y desde la pantalla principal de phpmyadmin (No desde la base de datos que hemos creado) crearemos un nuevo usuario desde el menú "Privilegios" y la opción "Agregar nuevo usuario"
</p>

<center>
  <img src="sherblog/wp-content/uploads/images/20080418_install_wordpress_02.jpeg" />
</center>

<p style="text-align: justify; padding-left: 30px;">
  Todos los campos que aparecen debajo los dejaremos en blanco ya que le asignaremos privilegios sólo para acceder o modificar la base de datos del blog. Si va todo bien, al pulsar el botón "Continuar" aparecerá un mensaje en el que pone "Ha agregado un nuevo usuario." con la consulta correspondiente debajo.
</p>

<p style="text-align: justify; padding-left: 30px;">
  5.- Volvemos a entrar en el apartado "Privilegios" del servidor y en la tabla de usuarios vemos como se ha añadido nuestro nuevo usuario. Le editamos los privilegios mediante el botón de la última columna y en el apartado "Privilegios específicos para la base de datos" seleccionamos la base de datos que hemos creado anteriormente (En nuestro caso "wpprueba"). En la pantalla que aparece a continuación seleccionamos todos los campos y pulsamos en "Continuar".
</p>

<center>
  <img src="sherblog/wp-content/uploads/images/20080418_install_wordpress_03.jpeg" />
</center>

<p style="text-align: justify; padding-left: 30px;">
  6.- Volviendo a los archivos que hemos descomprimido y reubicado, habra de renombrar "wp-config-sample.php" a "wp-config.php" y lo abriremos con el bloc de notas para dejarlo según lo siguiente.
</p>

<p style="text-align: justify; padding-left: 30px;">
  <pre lang="php">
<?php
// ** MySQL settings ** //
define('DB_NAME', 'wpprueba');
define('DB_USER', 'usuario');
define('DB_PASSWORD', 'password');
define('DB_HOST', 'localhost');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('SECRET_KEY', 'put your unique phrase here');
$table_prefix  = 'wp_';
define ('WPLANG', '');
define('ABSPATH', dirname(__FILE__).'/');
require_once(ABSPATH.'wp-settings.php');
?>
</pre>
  
  <p style="padding-left: 30px;">
    7.- Con lo anterior modificado ya podemos acceder a "<a href="http://localhost/wordpress" target="_blank">http://localhost/wordpress</a>" para iniciar la instalación del blog. En el primer paso sólo nos pide el Titulo del blog y nuestra dirección de correo electrónico.
  </p>
  
  <p>
    <center>
      <img src="sherblog/wp-content/uploads/images/20080418_install_wordpress_04.jpeg" />
    </center>
  </p>
  
  <p style="text-align: justify; padding-left: 30px;">
    8.- Al pulsar en el botón "Install WordPress" si todo ha ido correctamente, nos mostrará una pantalla con "admin" como nuestro nombre de usuario y una contraseña que de momento anotaremos y que posteriormente podremos modificar.
  </p>
  
  <p style="text-align: justify; padding-left: 30px;">
    9.- Mediante el botón "Log in", admin como nombre de usuario y la contraseña que hemos copiado accederemos definitivamente al panel de control del blog que ya está instalado y que podremos ver desde la dirección "http://localhost/wordpress"
  </p>
  
  <p>
    <center>
      <img src="sherblog/wp-content/uploads/images/20080418_install_wordpress_05.jpeg" />
    </center>
  </p>
  
  <p style="text-align: justify;">
    Hasta aquí todo lo indispensable para empezar con WordPress, en el siguiente post veremos como traducir tanto el blog como el panel de control al cristiano para no tener problemas con el idioma.
  </p>