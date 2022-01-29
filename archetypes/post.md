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
