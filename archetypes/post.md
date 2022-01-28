---
title: "{{ replace (replaceRE "([0-9]+)_(.+)" "$2" .Name) "_" " " | humanize }}"
date: {{ dateFormat "2006-01-02" .Date }}
creation: {{ dateFormat "2006-01-02" .Date }}
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
[image-04]: /images/{{ .Name }}_04.jpg
[image-05]: /images/{{ .Name }}_05.jpg
[image-06]: /images/{{ .Name }}_06.jpg
[image-07]: /images/{{ .Name }}_07.jpg
[image-08]: /images/{{ .Name }}_08.jpg
[image-09]: /images/{{ .Name }}_09.jpg
[image-10]: /images/{{ .Name }}_10.jpg

