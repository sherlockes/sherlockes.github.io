---
title: "Simple web apps by Chatgpt"
date: "2026-02-06"
creation: "2025-12-10"
description: "Aquí dejo unas simples aplicaciones web que he creado con la ayuda de Chatgpt"
thumbnail: "images/20251210_chatgpt_simple_web_apps_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
- "computing"
tags:
- "html"
draft: false
weight: 5
---
Hacer pequeñas aplicaciones cada día que pasa es más sencillo sin tener mucha idea de programar. Aquí dejo unas cuantas que he creado para satisfacer necesidades puntuales. Hasta la descripción de la aplicación va a ser cortesía de la inteligencia artificial.
<!--more-->
### Menú diario
Esta pequeña webapp de menú semanal es un buen ejemplo: todo vive en un único archivo HTML, listo para abrir en cualquier navegador y empezar a usar sin instalación ni configuración previa. Una solución directa, portátil y sorprendentemente completa.

El diseño apuesta por la claridad visual y la navegación inmediata. Desde la pantalla principal se puede recorrer el menú mediante un selector de semanas y, dentro de cada una, un selector de días que permite cambiar de forma instantánea el contenido mostrado. Cada jornada despliega sus recetas organizadas en tarjetas limpias, con jerarquía tipográfica clara y una lectura cómoda tanto en escritorio como en móvil gracias al enfoque responsive.

Cada receta está estructurada de manera muy práctica: incluye ingredientes, pasos de preparación y consejos finales, lo que convierte la página en una referencia rápida para el día a día en la cocina. No es solo un visor estático, sino una pequeña aplicación pensada para el uso real, donde la información importante está siempre a un clic de distancia.

Uno de los aspectos más interesantes es la capa de interactividad añadida con JavaScript puro. La app permite marcar platos como favoritos, visualizar una lista filtrada solo con ellos e incluso acceder directamente a un plato concreto desde esa lista. Todo esto se gestiona mediante almacenamiento local del navegador, que guarda preferencias y recuerda la última semana consultada sin necesidad de conexión ni servicios externos.

Además, existe un modo de lista completa con búsqueda integrada y filtros por tipo de comida (desayuno, comida, merienda o cena). Esta vista transforma el archivo en algo más cercano a una base de datos personal de recetas que a una simple página web, facilitando encontrar rápidamente qué cocinar según el momento del día o los ingredientes disponibles.

![image-03]

En conjunto, la webapp demuestra que con HTML, CSS y JavaScript bien utilizados se pueden construir herramientas funcionales, rápidas y totalmente autónomas. Un recordatorio de que, a veces, la mejor tecnología no es la más compleja, sino la que desaparece y deja paso a lo importante: resolver un problema cotidiano con elegancia y sencillez.

Aquí tienes la aplicación [Menú semanal]

### Generador de Turnos
Esta aplicación web es una herramienta práctica e intuitiva para la generación automática de calendarios laborales con turnos rotatorios, pensada para trabajadores con sistemas de rotación de mañana, tarde, noche y descansos. Funciona de manera completamente local en el navegador, sin necesidad de registro ni conexión a servidores externos, garantizando la privacidad del usuario.

El usuario solo debe seleccionar la fecha de inicio del ciclo y el turno inicial, y la aplicación se encarga de generar automáticamente el calendario anual siguiendo una rueda predefinida de turnos (mañana, tarde, noche y descanso). La distribución respeta bloques de trabajo diferenciados según el día de la semana, ajustando automáticamente los descansos y los grupos de días.

Entre sus funcionalidades más destacadas se encuentran:

- Gestión de días especiales:
 - Días “sobrante” que se añaden manualmente como eventos adicionales.
 - Días a “quitar” que permiten eliminar jornadas concretas del calendario (festivos, permisos, etc.).
 - Vacaciones por rangos de fechas, que bloquean automáticamente cualquier turno dentro del periodo seleccionado.
 - Restricciones automáticas para evitar turnos de tarde y noche en fechas especiales como el 24 y 31 de diciembre.

- Vista previa visual del calendario completo por meses, con una cuadrícula clara, código de colores por tipo de turno y leyendas simplificadas, lo que permite comprobar de un vistazo toda la planificación anual.

- Generación y descarga del calendario en formato .ics, totalmente compatible con Google Calendar, Outlook, Apple Calendar y la mayoría de aplicaciones de agenda digital.

- Previsualización de archivos .ics externos, permitiendo cargar un calendario existente y visualizarlo directamente dentro de la aplicación.

- Guardado automático de los datos en la sesión del navegador, para que el usuario no pierda la información al recargar la página.

- Diseño adaptado a dispositivos móviles, con botones grandes, formularios optimizados y calendario legible desde smartphone o tablet.

Además, incluye la opción de borrado completo de la sesión, permitiendo comenzar una planificación desde cero en cualquier momento.

En conjunto, esta aplicación ofrece una solución completa, ágil y visualmente clara para la planificación laboral con cuadrantes rotatorios, combinando automatización, personalización, compatibilidad con calendarios digitales y facilidad de uso tanto en ordenador como en móvil.

![image-02]

Aquí tienes la aplicación [Generador de turnos]


### Informe de desviaciones
Informe de Desviaciones es una aplicación web ligera, rápida y totalmente autónoma pensada para registrar, organizar y exportar incidencias de seguridad, mantenimiento o inspección de forma sencilla y profesional. Funciona sin instalación y sin conexión a servidores, almacenando toda la información directamente en el navegador mediante almacenamiento local.

La herramienta permite crear múltiples secciones independientes, ideales para separar informes por zonas, proyectos, fechas o centros de trabajo. En cada sección puedes registrar desviaciones por categorías como almacenamiento, productos químicos, herramientas, residuos, señalización, EPIs, zonas de paso y muchas más. Cada registro permite añadir descripción, ubicación y fotografía tomada directamente desde el móvil o el ordenador.

Entre sus funciones más destacadas se incluyen:
- Edición y borrado de desviaciones.
- Gestión completa de secciones (crear, renombrar, eliminar).
- Compresión automática de imágenes.
- Generación automática de informes en PDF listos para imprimir.
- Exportación completa en HTML para archivo o auditorías.
- Resumen automático por tipos de desviación.

Su interfaz está diseñada para ser clara, rápida y usable en móvil, lo que la convierte en una herramienta ideal para técnicos de PRL, responsables de mantenimiento, inspecciones internas, auditorías de seguridad o centros educativos con talleres y laboratorios.

Una solución práctica, portable y eficaz para dejar de usar papel y organizar las incidencias de forma profesional en segundos.

![image-01]

Aquí tienes la aplicación [Informe de desviaciones]

[Informe de desviaciones]: /files/desviaciones.html
[Generador de turnos]: /files/turnos.html
[Menú semanal]: /files/menu.html

[image-01]: /images/20251210_chatgpt_simple_web_apps_01.jpg
[image-02]: /images/20251210_chatgpt_simple_web_apps_02.jpg
[image-03]: /images/20251210_chatgpt_simple_web_apps_03.jpg


