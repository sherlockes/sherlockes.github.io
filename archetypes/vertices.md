---
title: "Vértice geodésico {{ .Name | title }}"
date: "{{ dateFormat "2006-01-02" .Date }}"
creation: "{{ dateFormat "2006-01-02" .Date }}"
description: "Vértice geodésico {{ .Name | title }}"
thumbnail: "images/vertice.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "vertices"
draft: true
weight: 5

js: https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.3.1/build/ol.js
css: https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.3.1/css/ol.css

mapa_alto: 400

vertice_nom: "{{ .Name | title }}"
vertice_loc: "localidad"
vertice_lon: "-0.3565367"
vertice_lat: "41.3790035"
vertice_alt: "354"
vertice_hoja: "0413"
vertice_id: "42"
vertice_img: "tZbCy46"
vertice_pan: "VY8ieZb"
vertice_videopan: "wLdya1MCFb8"

vertice_gps_gar: "85111891"
vertice_gps_wik: "5111891"
---
{{< mapa_vertice >}}
