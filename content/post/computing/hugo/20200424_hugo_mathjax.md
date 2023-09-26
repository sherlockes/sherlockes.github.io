---
title: "Mathjax en Hugo"
date: "2022-01-04"
creation: "2020-05-01"
description: "Como incluir fórmulas matemáticas en Hugo usando Latex a través de Mathjax."
thumbnail: "images/20200501_hugo_mathjax_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: true
categories:
  - "Hugo"
tags:
  - "mathjax"
draft: false
weight: 5
---
En un post de Hugo podemos ser prácticos e incluir una ecuación matemática simplemente insertando una imagen de la misma o ser mucho más elegantes haciéndolo mediante [Mathjax]. A continuación voy a explicar como lo hago.
<!--more-->
Este es uno de esos casos en los que la solución resulta ser mucho más simple de lo que, en un primer momento, hubiera pensado.

Para el desarrollo de este Blog uso [Hugo] con el tema [Mainroad] el cual presenta entre sus características la implantanción de Mathjax de una forma nativa para lo cual simplemente hay que habilitarlo en el Post que lo necesite mediante la configuración de

```
mathjax: true
```
Con esto ya es posible incrustar una sentencia en [Mathjax] como la siguiente

``` Mathjax
$$\sum_{i=0}^n i^2 = \frac{(n^2+n)(2n+1)}{6}$$
```
Obteniendo el siguiente resultado.

$$\sum_{i=0}^n i^2 = \frac{(n^2+n)(2n+1)}{6}$$

Ahora ya sólo queda aprender todas las posibilidades que ofrede [Mathjax], puede utilizar alguno de los enlaces que dejo a continuación.



### Enlaces de interés

- [JojozHuang - Mathjax Cheatsheet](https://jojozhuang.github.io/blog/2018/09/11/mathjax-cheat-sheet-for-mathematical-notation/)
- [Math.Meta - Mathjax basic tutorial](https://math.meta.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference)
- [DavidHamann - Latex Cheatsheet](https://davidhamann.de/2017/06/12/latex-cheat-sheet/)
- [OneMathematical - Tex commands in Mathjax](https://www.onemathematicalcat.org/MathJaxDocumentation/TeXSyntax.htm)

[Hugo]: https://gohugo.io/
[Mainroad]: https://themes.gohugo.io/mainroad/
[Mathjax]: https://www.mathjax.org
