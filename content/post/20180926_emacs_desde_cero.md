---
title: "Emacs desde cero"
date: "2018-09-26" 
description: "Aquí iré documentando mi experiencia con este impresionante editor de texto.."
thumbnail: "images/titulo_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Varios"
tags:
  - "emacs"
draft: true
weight: 5
---
## Emacs, sólo un editor de texto?

### Por que Emacs?
Esta es una pregunta complicada, ya que prácticamente tengo cubiertas todas mis necesidades de edición de texto con iaWritter en android y con Visual Studio Code para el resto de plataformas pero recientemente he escuchado sobre todas las bondades de Emacs y la curiosidad ha podido conmigo.

Ya había intentado en anteriores ocasiones usarlo pero por cuestiones que te responderé posteriormente lo dejé de lado.  Espero que este sea el intento definitivo.

### Que me ofrece Emacs?
En un primer momento lo único que espero de Emacs en un entorno de creación y edición para mis documentos de texto en formato MarkDown con las menores distracciones posibles.  Nada de bonitos iconos flotantes ni miles de opciones para formatear el texto que no necesito.

Seguro que con el tiempo soy capaz de conseguir esto y mucho más.

### Que necesito?
* La aplicación
* Un tutorial sencillo donde dar los primeros pasos
* Algo de tiempo
* Perseverancia y paciencia

La aplicación la puedes encontrar [aquí][11] para la mayoría de plataformas.  En esta ocasión he seguido [este][12] curso que, aunque tiene varios años resulta fácil de seguir y está bien explicado (Si quieres reproducir directamente en [vlc][14] la lista de reproducción que tengo [creada][13].  En cuanto al tiempo no creo que sea muy complicado sacar ratos de quince minutos para todos los días avanzar un poco en el manejo de Emacs.  Ya ves que los tres primeros son unos requerimientos sencillos y accesibles, sólo hay que luchar con en cuarto y aquí no puedo dar ningún consejo, simplemente que el esfuerzo merecerá la pena.

### Donde está el problema?
Emacs es una de esas aplicaciones que cuando las abres te parece que no van a ser capaces de hacer nada pero que a medida que vas profundizando en ellas te das cuenta de la increíble potencia que presentan.  Una interface que parece de finales de los ochenta y un tutorial en la ventana de inicio son dos de las cualidades que echan para atrás a casi cualquiera.

Pero lo que sin duda alguna es el gran impedimento para trabajar con Emacs es su curva de aprendizaje increiblemente lenta al principio por culpa de un flujo de trabajo completamente diferente al resto de aplicaciones y la infinidad de atajos de teclado que hay que hay que aprender para conseguir una productividad “digna”.

## Lo que he aprendido

### Personalizando Emacs
 * Añadiendo capacidad para sintaxis MarkDown `sudo apt install elpa-markdown-mode`

### Comandos genéricos
F11 ; pantalla completa
C-x C-c ; Cierra Emacs
C-g ; Cancelar un comando

### Ventanas
C-x 0 ; Elimina la ventana actual
C-x 1 ; Elimina todas ventanas menos la actual
C-x 2 ; Crea una ventana horizontal
C-x 3 ; Crea una ventana vertical
C-x o ; Cambiar de ventana

### Buffer
C-x k ; Cierra el buffer actual
M-x ; Activa el minibuffer
C-x -> ; avanza un buffer
C-x <- ; retrocede un buffer
C-x b ; Cambia de buffer
C-x C-f ; Crea un buffer / visita un archivo
C-x C-w ; Renombra un archivo
C-x C-s ; Guarda los cambios
C-h i ; Muestra la zona de manuales
C-x C-q ; Pone el buffer en modo de solo lectura

### Edición de texto
M-w ; Copiar un texto
C-y ; Pegar un texto
C-w ; Cortar un texto
C-spc ; Marcar
M-d ; Borra una palabra
C-s ; Busca un texto hacia adelante
C-r ; Busca un texto hacia atrás
M-% ; Buscar y reemplazar una palabra ("y"si, "n"no,  "!"todas)


#### Comandos del minibuffer
shell ; Lanza una terminal
menu-bar-mode ; oculta la barra de menú
tool-bar-mode ; oculta la barra de herramientas
customize-theme ; configuración del tema
eval-buffer ; evalua el contenido del buffer activo
ido-mode ; Activa el modo ido
customize ; Entra al modo de configuración de Emacs
package-list-packages ; lista los paquetes instalados

### Plugins
#### Neotree
https://www.emacswiki.org/emacs/NeoTree
En el archivo de configuración .emacs introducir la línea `(global-set-key [f8] 'neotree-toggle)` para usar la tecla F8 para desplegar el navegador.


[11]: https://www.gnu.org/software/emacs/download.html
[12]: https://github.com/farliz/emacs-academia/blob/master/contenido.md
[13]: /files/emacs-academia-farliz.xspf
[14]: https://www.videolan.org/vlc/index.es.html
