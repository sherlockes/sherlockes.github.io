---
title: "Contenido relacionado en Hugo"
date: "2021-12-14"
creation: "2021-12-14"
description: "La forma que he utilizado en Hugo para mostar artículos similares al final del mismo."
thumbnail: "images/20211214_hugo_related_content_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
- "hugo"
tags:
- "desarrollo"
draft: false
weight: 5
---
Para que el visitante obtenga una mejor experiencia de tu contenido, es importante mostrarle contenido relaccionado para que siga leyendo a continuación de loa que ya ha consultado. Así lo he implementado en [Hugo]
<!--more-->
La gestión del [contenido relaccionado] en [Hugo] está claramente expuesta pero para los recien iniciados no resulta obvio de implementar.

### Creación de la plantilla
Crearemos en archivo related.html dentro del directorio "/layouts/partials"

```html
{{ $related := .Site.RegularPages.Related . | first 5 }}
{{ with $related }}
<div class="content post__content clearfix">
    <h3>Otros de mís artículos que te pueden interesar</h3>
    <ul>
	    {{ range . }}
	    <li><a href="{{ .RelPermalink }}">{{ .Title }}</a></li>
	    {{ end }}
    </ul>
</div>
{{ end }}
```
En el podemos modificar el número de artículos relaccionados que se van a mostrar, el texto como encabezado de los mismos y el nivel de este encabezado.

### Inclusión de la plantilla en la página
Hay que modificar el archivo "layouts/_default/single.html" para incluir en el mismo la plantilla del contenido relaccionado que hemos generado. En caso de que no tengamos este archivo copiaremos el correspondiente dentro de la carpeta de los temas y lo modificaremos.

> No hay que editar ningún archivo dentro de la carpeta "themes" ya que una actualización del propio tema sobreescribiría las modificaciones que hayaos introducido. Para ello hay que hacer una copia del archivo en la carpeta "layouts" de la raiz del sitio y modificarlo aquí.

Así quedará una vez modificado el archivo "single.html"

```html
{{ define "main" }}
<main class="main" role="main">
	<article class="post">
		<header class="post__header">
			<h1 class="post__title">{{ .Title }}</h1>
			{{- with .Params.lead }}
			<p class="post__lead">{{ . }}</p>
			{{- end }}
			{{ with partial "post_meta.html" . -}}
			<div class="post__meta meta">{{ . }}</div>
			{{- end }}
		</header>
		{{- if .Params.thumbnail }}
		<figure class="post__thumbnail">
			<img src="{{ .Params.thumbnail | relURL }}" alt="{{ .Title }}">
		</figure>
		{{- end }}
		{{- partial "post_toc.html" . -}}
		<div class="content post__content clearfix">
			{{ .Content }}
		</div>
		{{- if .Params.tags }}
		<footer class="post__footer">
            {{ partial "related.html" . }}
			{{ partial "post_tags.html" . }}      
		</footer>
		{{- end }}
	</article>
</main>
{{ partial "authorbox.html" . }}
{{ partial "post_nav.html" . }}
{{ partial "comments.html" . }}
{{ end }}
```

Se puede ver como hemos intruducido el contenido relaccionado mediante `{{ partial "related.html" . }}` en el pie del artículo justo ante de la barra de tags.

### Configuración del contenido
Llegados a este punto ya es posible regenerar el sitio para comprobar el contenido relaccionado que se ha incluido, si no nos parece adecuado es posible modificar la configuración editando el archivo "config.toml" incluyendo un nuevo apartado para este contenido relaccionado.

Asi es como lo tengo dispuesto en este blog:

```toml
[related]
  includeNewer = true
  threshold = 85
  toLower = false

  [[related.indices]]
  name = "tags"
  weight = 80

  [[related.indices]]
  name = "categories"
  weight = 60

  [[related.indices]]
  name = "date"
  weight = 20
```
De esta forma muestra primero el contenido con los mismos tags, despues el de la misma categoría y fimalmente el de una fecha parecida

### Enlaces de interés

- [Digital Notions](https://digitalnotions.net/related-posts-in-hugo/)  
- [Hugo related content](https://gohugo.io/content-management/related/)  
- [Regis Philibert](https://www.regisphilibert.com/blog/2018/04/hugo-optmized-relashionships-with-related-content/)  


[contenido relaccionado]: https://gohugo.io/content-management/related/#relatedindices-page-indice1-indice2-
[Hugo]: https://gohugo.io
