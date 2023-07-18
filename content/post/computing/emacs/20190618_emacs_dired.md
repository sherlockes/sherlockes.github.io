---
title: "Usando Dired en Emacs"
date: "2022-02-06"
creation: "2019-06-18"
description: "Para editar un archivo, algo fundamental es encontrarlo y abrirlo, aquí el método que uso al trabajar con Emacs"
thumbnail: "images/20190619_emacs_dired_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
  - "computing"
tags:
  - "dired"
  - "emacs"
draft: false
weight: 5
---
Después de algún tiempo buscando alternativas para la gestión de ficheros en emacs he tomado la determinación de que lo más práctico va a ser aprender a manejar una de las más potentes y que viene por defecto, Dired.

<!--more-->
No pretendo hacer un completo tutorial sobre el uso de Dired ya que soy un recién llegado y todavía no tengo la capacidad para ello, simplemente pretendo reflejar aquí mi aprendizaje para que cualquiera lo pueda usar como una pequeña guía de inicio.  Para un aprendizaje profundo siempre es mejor utilizar fuentes oficiales como [gnu], [wikemacs] o  [ergoemacs].

Como en todos los aspectos de Emacs, hay que ser un privilegiado para aprenderse de memoria desde un principio todos los atajos de teclado que existen. Lo más práctico creo que es una "[Reference Card]" que podemos imprimir y tener a mano cuando necesitemos alguna consulta.

---
### Instalación
Quizás esto sea una de las grandes bondades de Dired y es que no hay que instalar nada al venir incluido en la distribución de Emacs. Para ejecutarlo usaremos el atajo `C-x d` (Para abrir Dired en la ventana activa) , `C-x 4 d` (Para abrirlo en la ventana no activa) o `C-x 5 d` (Para abrirlo en una estancia nueva de emacs) y a continuación introduciremos la ruta del directorio que queremos abrir.

---
### Abrir un archivo o directorio
En el buffer ya nos aparecen una línea por cada archivo o carpeta, para abrir un archivo o entrar en un directorio tenemos tres opciones

* "o" o Click Izdo sobre la línea > Abre el archivo o carpeta en la ventana no activa (O abre una nueva)
* "f" o "Enter" sobre la línea > Abre el archivo o carpeta en la misma ventana
* "a" sobre la línea > Abre el archivo o carpeta en la misma ventana y buffer

Para la navegación por carpetas está claro que la mejor opión es la tercera ya que de lo contrario te encuentras con tantos fubbers como carpetas has abierto.  Para el caso de los archivos, a gusto de cada uno en función de las necesidades.

---
### Seleccionando y editando archivos
##### Selección de archivos para eliminar "Flag"
Para eliminar archivos o directorios, Dired puede seleccionar los archivos o directorios mediante "Flags" de una forma rápidad y sencilla. Con el teclado, nada de usar el ratón nos ponemos sobre el archivo o directorio que queremos seleccionar y pulsamos la tecla "d". En caso de que queramos deseleccionar, nos colocamos sobre el mismo archivo y pulsamos "u". Una vez realizada la selección, eliminamos todo lo selaccionado con la tecla "x"

* "d" > Selecciona el archivo
* "u" > Deseleciona el archivo
* "x" > Elimina el archivo
* [Del] > Elimina la selección de la línea anterior

Tanto la selección como la deselección son compatibles con el "[Argumento prefijo]" de Emacs de modo que p.ej podemos selecionar cuatro archivos consecutivos situando el cursor sobre el primero de ellos y con la combinación de teclas `C-u 4 d`

##### Selección de archivos para editar archivos "Mark"

* "m" > Selecciona el archivo
* "u" > Deselecciona el archivo
* "U" > Deselecciona todo
* "*/" > Selecciona los directorios
* "*t" > Invierte la selección
* [Del] > Elimina la marca de la línea anterior

En este caso existen muchos más comandos específicos además de moder hacer uso del "[Argumento Prefijo]" pero aquí sólo muestro los que yo uso habitualmente.

##### Manejar archivos marcados
Copiar, mover, borrar archivos , comprimirlos,renombrarlos... y muchas más opciones se realizan con la simple pulsación de una tecla una vez que tenemos seleccionados los archivos con la opción "Mark". A continuación sólo las opciones mas comunes.

* "C" > Copiar archivos
* "R" > Renombrar un archivo o mover varios a otro directorio
* "D" > Eliminar lo seleccionado

---
### Actualizar el buffer
Si el contenido del directorio que estamos visualizando en Dired cambia debemos tener en cuenta que este no se refresca de forma automática. Se dispone de varios comandos para actualizar el buffer.

* "g" > Actualiza todo  el buffer que nos muestra archivos y directorios
* "s" > Cambia entre la ordenación alfabética y por fecha
* "k" > Borra las líneas seleccionadas sin borrar los archivos
* "l" > Refresca sólo las líneas que se muestran en el buffer

---
### Ocultando información irrelevante
Cuando nos da igual el propietario de un archivo, tamaño, privilegios... al trabajar con Dired dentro de Emacs resulta más productivo ver sólo el el nombre de la carpeta o archivo para navegar entre ellos cuando utilizamos [Dired] dentro de [Emacs].

Para ocultar toda esta información sólo hay que pulsar `(` desde el buffer donde este [Dired] activado para habilitar/deshabilitar el [modo de ocultar detalles] de modo que pasamos de ver esto:

``` lisp
  /ssh:pi@192.168.10.202:/home/pi/sherblog:
  drwxr-xr-x 12 pi 4.0K Jan 29 13:24 .
  drwxr-xr-x 14 pi 4.0K Feb  6 00:30 ..
  drwxr-xr-x  4 pi 4.0K Jan 29 12:39 content
  drwxr-xr-x  5 pi 4.0K Jan 29 12:39 layouts
  drwxr-xr-x  4 pi 4.0K Jan 29 12:40 resources
  drwxr-xr-x  6 pi 4.0K Jan 29 16:31 static
  drwxr-xr-x  3 pi 4.0K Jan 29 12:39 themes
  -rw-r--r--  1 pi 1.1K Jan 29 12:39 LICENSE
  -rw-r--r--  1 pi   72 Jan 29 12:39 README.md
  -rw-r--r--  1 pi 2.1K Jan 29 12:39 config.toml
```

a ver esto:

``` lisp
  /ssh:pi@192.168.10.202:/home/pi/sherblog:
  .
  ..
  content
  layouts
  resources
  static
  themes
  LICENSE
  README.md
  config.toml
```

El problema reside en que cada vez que abramos un buffer con dired o cambiemos de directorio dentro del mismo vamos a tener que usar el comando `(` para ocultar los detalles, lo cual resulta un poso engorroso. Para evitarlo he añadido la siguiente línea a mi archivo de configuración de [Emacs] ".emacs"

``` lisp
(add-hook 'dired-mode-hook (lambda()(dired-hide-details-mode)))
```

##### Función Mostrar/Ocultar archivos no visibles
Para alternar entre que se vean o no los archivos ocultos tengo configurado otro "hook" con una llamada a una función:

``` lisp
(setq my-dired-ls-switches-show "-laGh1v --group-directories-first")
(setq my-dired-ls-switches-hide "-lGh1v --group-directories-first")

(setq my-dired-switch 1)

(add-hook 'dired-mode-hook
 (lambda ()
  (if (= my-dired-switch 1)(dired-sort-other my-dired-ls-switches-hide))
  (define-key dired-mode-map (kbd "M-o")
   (lambda ()
    (interactive)
    (setq my-dired-switch (- my-dired-switch))
    (if (= my-dired-switch 1)
      (dired-sort-other my-dired-ls-switches-hide)
     (dired-sort-other my-dired-ls-switches-show))))))
```

- Definición de cadenas (setq my-dired-ls-switches-show/hide) que determinan la lista de opciones con las que poder fijar el valor de "dired-listing-switches", quien es el encargado de guardar las opciones de visualización de "ls".
- Definición de la variable "my-dired-switch" para determinar en cada momento si estamos en el modo de ver o ocultar.
- Definición del "hook" o función que se va a ejecutar cuando sea abierto un buffer con [Dired].
  - Se establece el modo por defecto ("my-dired-switch" = 1) estableciendo la cadena "hide" mediante "dired-sort-other"
  - Se define una función para alternar mediante el atajo "M-o" qeu realiza lo siguiente:
    - Se invierte el valor de modo ("my-dired-switch") respecto al anterior.
    - Se activa la cadena "hide" si el valor de modo es "1" o la cadena "show" en caso contrario.

{{< borrador >}}

---
### Navegación limpia entre directorios
Uno de los problemas con que nos encontramos al navegar entre directorios mediante [Dired] es que puede llegar a abrirse un buffer por cada directorio que hayamos visitado lo que convierte el cambio a otro buffer en una pesadilla si tienes que buscarlo entre todos los que tienes abiertos.

El método más sencillo para evitar esta acumulación de buffers es entrar a los directorios mediante la tecla `a` (La primera vez que la utilices [Emacs] preguntará si quieres habilitar el comando) y para volver al directorio anterior pulsar en `..`. Esto último es un problema si tenemos ocultos los archivos no visibles ya que tampoco se mostrará la línea correspondiente al directorio superior.

Existen varias soluciones a este problema aunque la más sencilla pasa por añadir dos definiciones nuevas de combinación de teclas dentro de un "hook" de dired en el archivo de configuración ".emacs" del mismo modo que hemos realizado para `M-o` para la función mostrar/ocultar en el apartado anterior.

``` lisp
(define-key dired-mode-map (kbd "M-<up>") (lambda () (interactive) (find-alternate-file "..")))
(define-key dired-mode-map (kbd "M-<down>") 'dired-find-alternate-file)
```

Gracias a estas dos combinaciones, para acceder a un directorio pulsaremos `M-<down>` y para volver al nivel superior `M-<up>` sin que se nos abran buffers adicionales.

{{< / borrador >}}

---
### Un caso práctico, emacs como gestor de dos paneles
Desde los tiempos de Norton Commander creo que la opción más práctica para los gestores de ficheros es el doble panel.  Emacs es fácilmente convertible a un gestor de arcivos de dos (o más) paneles con el el copiar o mover archivos de uno a otro de una forma sencilla. Para mover un archivo de un directorio a otro haciendo uso de dos paneles seguiremos los siguientes pasos.

1. Cerrar todos los buffers correspondientes los archivos a mover
1. Configurar la variable "dired-dwim-target" a "t" (Añadirá la línea '(dired-dwim-target t) en Custom-set-variables. (Esto quedará activo para futuras ocasiones)
1. Abrimos un bufer de Dired con el directorio conde están los archivos a mover `C-x d`
1. En caso de tener que navegar desde el raiz, usamos "a" sobre cada carpeta para subir niveles
1. Marcamos los archivos a mover o copiar con "m"
1. Abrimos un nuevo buffer con el directorio al que queremos mover los arhivos con "o"
1. Con el directorio de destino en el nuevo buffer, volvemos al de origen con `C-x o`
1. Para copiar los archivos usamos "C" y para mover "R"

Parece un método un poco laborioso pero en el siguiente vídeo se puede ver como apenas son unos cuantos "Clicks"

{{< youtube 01XAYge2Qq8 >}}

### Enlaces de interés
- [GNU - Dired reference card](https://www.gnu.org/software/emacs/refcards/pdf/dired-ref.pdf)
- [GNU - Hooks in Emacs](https://www.gnu.org/software/emacs/manual/html_node/emacs/Hooks.html)
- [Emacs StackExchange - Dired sort](https://emacs.stackexchange.com/questions/27912/dired-sort-and-hide-by-default)
- [EmacsWiki - Dired Omit Mode](https://www.emacswiki.org/emacs/DiredOmitMode)
- [Oremacs - Dired options](https://oremacs.com/2015/01/13/dired-options/)
- [Xahlee - Define keys in Emacs](http://xahlee.info/emacs/emacs/keyboard_shortcuts.html)
- [Xenodium - Hide dired details](https://xenodium.com/showhide-emacs-dired-details-in-style/)

[Dired]: https://www.emacswiki.org/emacs/DiredMode
[Emacs]: https://www.gnu.org/software/emacs/
[Argumento Prefijo]: https://www.emacswiki.org/emacs/PrefixArgument
[gnu]: https://www.gnu.org/software/emacs/manual/html_node/emacs/Dired.html
[wikemacs]: https://wikemacs.org/wiki/Dired
[ergoemacs]: http://ergoemacs.org/emacs/file_management.html
[modo de ocultar detalles]: https://www.emacswiki.org/emacs/DiredDetails
[Reference Card]: https://www.gnu.org/software/emacs/refcards/pdf/dired-ref.pdfxs
