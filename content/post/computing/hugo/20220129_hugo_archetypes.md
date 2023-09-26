---
title: "Arquetipos en Hugo (Archetypes)"
date: "2022-01-29"
creation: "2022-01-29"
description: "El uso de los arquetipos en Hugo te ahorra mucho tiempo a la hora de estribir nuevos artículos."
thumbnail: "images/20220129_hugo_archetypes_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
- "hugo"
tags:
- "regexp"
draft: false
weight: 5
---
Cada vez que se comienza la creación de un artículo en Hugo partimos del comando `hugo new post/nuevo.md` que hace uso de los arquetipos creados para definir la plantilla de este artículo. Aquí dejo como los tengo configurados para ahorrar tiempo.
<!--more-->
El uso de [archetypes] en [Hugo] presenta dos ventajas importantes, por un lado la estandarización de la estructura de todos los artículos al crearse a partir de una plantilla y el ahorro de tiempo al no tener que estar copiando y modificanto esta plantilla.

### Definición del título
En mi caso, todos los post los creo con el nombre "20220129_titulo_del_post.md" del cual debemos extraer el título del post siguiendo estos pasos:
- Buscar mediante expresiones regulares en el nombre del archivo para quedarnos con el título.
- Reemplazar los guiones bajos "_" por " " espacios.
- Humanizar el texto poniendo en mayúscula la primera palabra.

```
{{ replace (replaceRE "([0-9]+)_(.+)" "$2" .Name) "_" " " | humanize }}
```

### Definición de la fecha
Tengo configurada la fecha de todos los artículos dentro de [Hugo] con el formato "2022-01-29" por lo que es necesario que cuando se genere un nuevo post este formato sea respetado a la hora de incluir en el mismo la fecha. Esto lo consigo gracias al siguiente código:

```
{{ dateFormat "2006-01-02" .Date }}
```

### Ruta de las imágenes
Para un post cuyo nombre sea "20220129_un_titulo_cualquiera.md", las imágenes incrustadas en el mismo siguen el siguiente orden nominal:

"images/20220129_un_titulo_cualquiera_00.jpg"
"images/20220129_un_titulo_cualquiera_01.jpg"
"images/20220129_un_titulo_cualquiera_02.jpg"

Para generar esta cadena hago un llamamiento directo la la función ".Name"

```
images/{{ .Name }}_00.jpg
```

Además, para generar una lista con las posibles imágenes del artículo hago uso de la función "Range"

```
{{ range $num := (seq 9) }}
[image-0{{.}}]: /images/{{ $.Name }}_0{{ . }}.jpg{{ end }}
```

Con lo que genero una lista como esta

```
[image-01]: /images/20210129_un_titulo_cualquiera_01.jpg
[image-02]: /images/20210129_un_titulo_cualquiera_02.jpg
[image-03]: /images/20210129_un_titulo_cualquiera_03.jpg
[image-04]: /images/20210129_un_titulo_cualquiera_04.jpg
[image-05]: /images/20210129_un_titulo_cualquiera_05.jpg
[image-06]: /images/20210129_un_titulo_cualquiera_06.jpg
[image-07]: /images/20210129_un_titulo_cualquiera_07.jpg
[image-08]: /images/20210129_un_titulo_cualquiera_08.jpg
[image-09]: /images/20210129_un_titulo_cualquiera_09.jpg
```

### Plantilla resultante
```
---
title: "{{ replace (replaceRE "([0-9]+)_(.+)" "$2" .Name) "_" " " | humanize }}"
date: "{{ dateFormat "2006-01-02" .Date }}"
creation: "{{ dateFormat "2006-01-02" .Date }}"
description: "{{ replace (replaceRE "([0-9]+)_(.+)" "$2" .Name) "_" " " | humanize }}"
thumbnail: "images/{{ .Name }}_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
draft: true
weight: 5
---
Resumen de introducción
<!--more-->


![image-01]

### Enlaces de interés
- [enlace](www.sherblog.pro)

[link]: https://www.google.es

{{ range $num := (seq 9) }}
[image-0{{.}}]: /images/{{ $.Name }}_0{{ . }}.jpg{{ end }}
```

### Enlaces de interés
- [GoHugoHq.com - Dateformat](https://gohugohq.com/howto/hugo-dateformat/)
- [Angela1c - Hugo Archetypes](https://www.angela1c.com/projects/hugo-files/templating/)
- [MertBaKir - Loops in Hugo](https://mertbakir.gitlab.io/hugo/loops-in-hugo/)
- [Re2 - Regex in Hugo](https://github.com/google/re2/wiki/Syntax)

[archetypes]: https://gohugo.io/content-management/archetypes/
[Hugo]: https://gohugo.io

[image-01]: /images/20210129_hugo_archetypes_01.jpg
[image-02]: /images/20210129_hugo_archetypes_02.jpg
[image-03]: /images/20210129_hugo_archetypes_03.jpg
[image-04]: /images/20210129_hugo_archetypes_04.jpg
[image-05]: /images/20210129_hugo_archetypes_05.jpg
[image-06]: /images/20210129_hugo_archetypes_06.jpg
[image-07]: /images/20210129_hugo_archetypes_07.jpg
[image-08]: /images/20210129_hugo_archetypes_08.jpg
[image-09]: /images/20210129_hugo_archetypes_09.jpg
[image-10]: /images/20210129_hugo_archetypes_10.jpg

