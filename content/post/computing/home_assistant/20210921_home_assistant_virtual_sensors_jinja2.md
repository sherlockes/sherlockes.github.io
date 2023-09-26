---
title: "Sensores virtuales y Jinja2 en Home Assistant"
date: "2022-12-21"
creation: "2021-09-21"
description: "Mi manejo de los sensores virtuales y el motor de plantillas Jinja2 en Home Assistant"
thumbnail: "images/20210921_home_assistant_virtual_sensors_jinja2_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
- "home assistant"
tags:
- "jinja2"
draft: false
weight: 5
---
Aquí dejo la solución que he implementado ante el problema de crear una nueva entidad en Home Assistant cuyo valor dependa del de otras entidades ya existentes gracias al uso de sensores virtuales y el motor de plantillas de Jinja2.

**Actualización:** Sensor de día lectivo
<!--more-->

### Creando el archivo de sensores
Antes de seguir adelante es importante tener instalado el complemento [File Editor] que puedes instalar desde la tienda oficial.

![image-01]

Abriremos el complemento y a continuación hay que crear un nuevo archivo en la carpeta "/config" con nombre "sensors.yaml"

Abriremos el archivo "configuration.yaml" y lo editaremos añadiendo la siguiente línea

```
sensor: !include sensors.yaml
```

Antes de seguir adelante, guardaremos los cambios y comprobaremos que todo funciona correctamente verificando los archivos de configuración desde el apartado "Controles del servidor" en el menú de configuración de Home Assistant.

![image-02]

Si la configuración es válida podemos seguir adelante con la creación de nuestro nuevo sensor virtual.

> El error más habitual es que ya tubieramos creado un sensor dentro del archivo "configuration.yaml". Deberemos moverlos al archivo "sensors.yaml"

### Sensor para el punto cardinal del viento
En mi instalación de Home Assistant hago unos de la integracion de la [AEMET] para obtener la información del tiempo. El valor de la dirección del viento se obtiene como un valor en grados lo cual no resulta muy intuitivo por lo que me he decidido a crear una nueva entidad que lo transforme en un campo de texto que nos indique si em viento viene del norte, del sur....

En el archivo "sensors.yaml" añadiremos el nuevo sensor

```
  - platform: template
    sensors:
      aemet_dir_viento_texto:
        friendly_name: "Dirección viento"
        value_template: >-
            {% if ( states('sensor.aemet_wind_bearing') | float < 22.5 ) %}
                Norte
            {% elif ( states('sensor.aemet_wind_bearing') | float < 67.5 ) %}
                Noreste
            {% elif ( states('sensor.aemet_wind_bearing') | float < 112.5 ) %}
                Este
            {% elif ( states('sensor.aemet_wind_bearing') | float < 157.5 ) %}
                Sureste
            {% elif ( states('sensor.aemet_wind_bearing') | float < 202.5 ) %}
                Sur
            {% elif ( states('sensor.aemet_wind_bearing') | float < 247.5 ) %}
                Suroeste
            {% elif ( states('sensor.aemet_wind_bearing') | float < 292.5 ) %}
                Oeste
            {% elif ( states('sensor.aemet_wind_bearing') | float < 337.5 ) %}
                Cierzo
            {% else %}
                Norte
            {% endif %}
```
Lo hemos nombrado como "aemet_dir_viento_texto" y para calcular su valor se emplea el motor de plantilla Jinja2. El valor del sensor "aemet_wind_bearing" se convierte a un valor numérico y se compara con los distintos rangos cada 45 grados para obtener el punto cardinal desde el que sopla el viento.

Ya sólo resta añadir este sensor en la página que deseemos de home assistant y tendremos la dirección del viento de una forma mucho más amigable.

![image-03]

### Sensor para definir si trabajo
Cuando no se vive solo en casa es un detalle no despertar a todos cuando uno lo tiene que hacer antes de las 5:00 AM. Dentro de los turnos de trabajo, me tengo que levantar a esta hora si trabajo en el turno de "Mañana" o de "Sobrante" lo cual tengo definido en el calendario de google "turno_de_trabajo".

Vamos a crear un sensor virtual que, en función del calendario devuelva un "On" si tengo que madrugar o un "Off" si no tengo que hacerlo.

En el archivo "sensors.yaml" añadiremos el nuevo sensor

```
  - platform: template
    sensors:
      madrugo_hoy:
        friendly_name: "Tengo que madrugar hoy?"
        value_template: >-
            {% set turno = state_attr('calendar.turno_de_trabajo','message') %}
            {% set fecha_turno = state_attr('calendar.turno_de_trabajo','start_time') %}
            {% set fecha_hoy = as_timestamp(now())|timestamp_custom("%Y-%m-%d 00:00:00") %}
            
            {% if (fecha_hoy == fecha_turno and (turno == "Mañana" or turno == "Sobrante")) %}
            On
            {% else %}
            Off
            {% endif %}
```

Y con esto ya puedo definir una automatización en la que, si estoy en casa y tengo que madrugar, se enciendan las luces de forma muy tenue durante unos minutos hasta que me voy de casa.

### Sensor de casa vacía
En la estancia de [Home Assistant] tengo definidas las personas que vivimos en casa y para cada una de ellas el dispositivo a rastrear que define si la persona está en casa o no.

![image-04]

Cn esto resulta sencillo crear un sensor virtual que devuelva "true" cuando no hay nadie en casa y "false" cuando si lo haya tal y como se puede ver en las siguiente líneas.

```
  - platform: template
    sensors:
      casa_vacia:
        friendly_name: "Esta la casa vacía?"
        value_template: >-
            {% set persona_1 = states('person.sherlockes') %}
            {% set persona_2 = states('person.sara') %}
            
            {% if ( persona_1 == "not_home" and persona_2 == "not_home" ) %}
              true
            {% else %}
              false
            {% endif %}
```

### Sensor de consigna de temperatura
Para el cálculo de la consigna de temperatura haremos uso de varios ayudantes
- Hora de levantar
- Hora de dormir
- Modo fuera de casa
- Temperatura cómoda
- Temperatura eco

```
  - platform: template
    sensors:
      consigna_caldera:
        friendly_name: "Consigna de Tª para la caldera"
        value_template: >-          
            {% set ahora = as_timestamp(now()) | timestamp_custom('%H:%M:%S') %}
            {% set levantar = states("input_datetime.hlevantar") %}
            {% set dormir = states("input_datetime.hdormir") %}
            {% if states ('input_boolean.fuera_de_casa') == 'on' %}
            {% set consigna = 16.5 %}
            {% elif states ('sensor.casa_vacia') == 'true' %}
            {% set consigna = states('input_number.eco') %}
            {% elif ahora > dormir or ahora < levantar %}
            {% set consigna = states('input_number.eco') %}
            {% elif ahora > levantar %}
            {% set consigna = states('input_number.ta_comoda') %}
            {% else %}
            {% set consigna = states('input_number.eco') %}
            {% endif %}
            {{ consigna }}
```

De este modo obtendremos los siguientes resultados para el sensor "consigna_caldera":
- 16.5 ºC si está habilitado el modo fuera de casa
- Tª eco si no hay nadie en casa entre hora de dormir y levantar
- tª cómoda entre la hora de levantar y dormir si hay alguien en casa

### Sensor de horario de apagado de la TV
Para evitar que lo primero que hagn los pequeños al levantarse sea encencer la tele tengo un horario de en el que el enchufe que la alimenta permanece apagado. Este horario lo defino mediante un ayudante de hora de apagado y otro de encendido:
- input_datetime.tv_off --> horaOFF
- input_datetime.tv_on --> horaON

Teniendo en cuenta lo anterior, la tele deberá estar apagada (off) en las siguientes condiciones:
- horaOFF > horaON y horaACT > horaOFF
- horaOFF > horaON y horaACT < horaON
- horaOFF < horaON , horaACT > horaOFF y horaACT < horaON

Definiendo A, B y C de la siguiente forma:
- A = horaOFF > horaON
- B = horaACT > horaOFF
- C = horaACT < horaON

podemos aplicar la lógica condicional según lo anterior y obtener el siguiente resultado:
(A y (B o C)) o (no A y B y C ) = OFF

Si lo traducimos a jinja 2, el sensor virtual quedará así.

```
  - platform: template
    sensors:
      modo_tv:
        friendly_name: "Modo de Tv según horario"
        value_template: >-          
            {% set ahora = as_timestamp(now()) | timestamp_custom('%H:%M:%S') %}
            {% set A = states("input_datetime.tv_off") > states("input_datetime.tv_on") %}
            {% set B = ahora > states("input_datetime.tv_off") %}
            {% set C = ahora < states("input_datetime.tv_on") %}
            
            {% if (A and ( B or C )) or ( not A and B and C ) %}
            off
            {% else %}
            on
            {% endif %}
```

### Sensor de estado de la TV
Mi TV no es "inteligente" y para poder encenderla o apagarla a través de [Home Assistant] lo hago a través de un [Broadlink RM mini] colocado en el salón gracias a la integración [SmartIR]. Esta integración hace uso de un sensor de encendido denominado "power_sensor" de forma que cuando está a "on" ofrece todos los controles de la TV y cuando esta a "off" sólo ofrece la posibilidad de encenderla.

Para crear este sensor de encendido tengo conectada la TV a un enchufe inteligente que me da información de consumo. No se si la medición es muy fiable, pero la experiencia me dice que cuando está encendida gasta por encima de los 30w lo que es información suficiente para crear este sensor de estado de la TV que incluyo dentro del archivo "sensors.yaml"

```
  - platform: template
    sensors:
      estado_tv:
        friendly_name: "Como está la tele?"
        value_template: >-
            {% set consumo_tv = state_attr('sensor.salon_tv_enchufe_corriente','current') %}
            {% if consumo_tv > 30 %}
            on
            {% else %}
            off
            {% endif %}
```

### Sensor de día lectivo
Desde hace varios años tengo una automatización en Alexa como despertador para los días de colegio, ahora voy a integrarla en [Home Assistant] mediante un calendario "festivos_escolares" en el que he insertado el [calendario escolar] con todos los días que no hay que ir al cole (Lo he hecho a través de la integración con Google Calendar aunque también se podría haber hecho directamente en [Home Assistant]).

El sensor que he creado para saber si hoy es lectivo pasa por comprobar que no haya ningún festivo escolar ni que sea fin de semana. Así de sencillo.

```yaml
- platform: template
    sensors:
        es_lectivo_hoy:
          entity_id: sensor.date
          value_template: >
            {% if states('calendar.festivos_escolares') == 'on' or now().isoweekday() >= 6 %}
              no
            {% else %}
              si
            {% endif %}
```

[AEMET]: https://www.home-assistant.io/integrations/aemet
[Broadlink RM mini]: https://www.broadlink.com.es/broadlink-rm-mini3-domotica-mando-distancia-universal.html
[calendario escolar]: https://educa.aragon.es/calendario-escolar
[File Editor]: https://github.com/home-assistant/addons/tree/master/configurator
[Home Assistant]: https://www.home-assistant.io
[SmartIR]: https://github.com/smartHomeHub/SmartIR

[image-01]: /images/20210921_home_assistant_virtual_sensors_jinja2_01.jpg
[image-02]: /images/20210921_home_assistant_virtual_sensors_jinja2_02.jpg
[image-03]: /images/20210921_home_assistant_virtual_sensors_jinja2_03.jpg
[image-04]: /images/20210921_home_assistant_virtual_sensors_jinja2_04.jpg
