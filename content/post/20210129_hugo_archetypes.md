---
title: "Hugo arquetipos"
date: "2022-01-29"
creation: "2022-01-29"
description: "Hugo archetypes"
thumbnail: "images/20210129_hugo_archetypes_00.jpg"
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
Cada vez que se comienza la creación de un artículo en Hugo partimos del comando `hugo new post/nuevo` que hace uso de los arquetipos creados para definir la plantilla de este artículo.
<!--more-->

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

[image-01]: /images/{{ .Name }}_01.jpg
[image-02]: /images/{{ .Name }}_02.jpg
[image-03]: /images/{{ .Name }}_03.jpg
```

![image-01]

### Enlaces de interés
- [enlace](www.sherblog.pro)

[link]: https://www.google.es

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

