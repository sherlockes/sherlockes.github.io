---
title: "Bloquear YouTube desde HA vía Adguard Home"
date: "2026-10-12"
creation: "2026-10-12"
description: "He creado Bloquear YouTube desde HA vía Adguard Home para compartir mis opiniones y conocimientos."
thumbnail: "images/20261012_bloquear_youtube_desde_ha_via_adguard_home_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "home assistant"
tags:
- "home assistant"
- "youtube"
draft: true
weight: 5
---

Este documento resume los pasos necesarios para crear un interruptor en el panel de control de Home Assistant que permita activar o desactivar de forma manual y bajo demanda una lista de bloqueo DNS alojada en AdGuard Home.

<!--more-->
## 1. Contexto y Problema

La integración nativa de **AdGuard Home** en Home Assistant expone interruptores globales para la protección general, el filtrado DNS, SafeSearch o el control parental, pero **no crea entidades individuales para listas de filtros o servicios bloqueados específicos** (como YouTube, redes sociales o dominios personalizados).

Para habilitar o deshabilitar una lista específica sin tener que acceder al panel de AdGuard Home, podemos aprovechar las acciones del servicio de la integración oficial (`adguard.enable_url` y `adguard.disable_url`) en combinación con un ayudante (*Input Boolean*) y una automatización ligera.

## 2. Requisitos Previos

1. Integración de **AdGuard Home** configurada y funcionando en Home Assistant.
2. La lista de URLs debe estar previamente agregada y visible en el panel web de AdGuard Home.

### Añadir la lista en AdGuard Home
1. Abre el panel web de AdGuard Home y navega a **Filtros** > **Listas de bloqueo de DNS**.
2. Pulsa en **Añadir lista de bloqueo** > **Añadir una lista personalizada**.
3. Rellena los datos:
   - **Nombre:** Por ejemplo, `Bloqueo Regex Redes / Streaming`
   - **URL:** 
     ```text
     https://raw.githubusercontent.com/sherlockes/SherloScripts/refs/heads/master/pi-hole/regex_blocklist.txt
     ```
4. Guarda los cambios y asegúrate de que la lista aparece listada con sus reglas cargadas.

## 3. Paso 1: Crear el Ayudante (*Input Boolean*)

El ayudante actúa como el interruptor virtual en Home Assistant sobre el que interactuaremos en el dashboard.

1. En Home Assistant, dirígete a **Ajustes** > **Dispositivos y servicios** > pestaña **Ayudantes**.
2. Haz clic en **Crear ayudante** y selecciona **Interruptor** (*Toggle*).
3. Configura los siguientes campos:
   - **Nombre:** `Adguard Custom List`
   - **Icono:** `mdi:shield-lock-outline`
4. Pulsa en **Crear**. La entidad generada será:
   ```text
   input_boolean.adguard_custom_list
   ```

## 4. Paso 2: Crear la Automatización de Control

Esta automatización escucha el cambio de estado del ayudante y lanza la acción correspondiente a AdGuard Home.

1. Ve a **Ajustes** > **Automatizaciones y escenas** > **Crear automatización**.
2. En la esquina superior derecha, abre el menú de tres puntos verticales y selecciona **Editar en YAML**.
3. Pega la siguiente definición:

```yaml
alias: "Control Bloqueo Redes AdGuard"
description: "Activa o desactiva la lista de filtrado en AdGuard Home mediante ayudante"
mode: restart
trigger:
  - trigger: state
    entity_id: input_boolean.adguard_custom_list
actions:
  - choose:
      - conditions:
          - condition: state
            entity_id: input_boolean.adguard_custom_list
            state: "on"
        sequence:
          - action: adguard.enable_url
            data:
              url: "https://raw.githubusercontent.com/sherlockes/SherloScripts/refs/heads/master/pi-hole/regex_blocklist.txt"
          - action: adguard.refresh
      - conditions:
          - condition: state
            entity_id: input_boolean.adguard_custom_list
            state: "off"
        sequence:
          - action: adguard.disable_url
            data:
              url: "https://raw.githubusercontent.com/sherlockes/SherloScripts/refs/heads/master/pi-hole/regex_blocklist.txt"
          - action: adguard.refresh
```

4. Haz clic en **Guardar**.

> **Nota:** La acción `adguard.refresh` asegura que AdGuard aplique los cambios inmediatamente en la memoria caché sin esperar al ciclo de sincronización habitual.

## 5. Paso 3: Tarjeta en el Panel de Control (Dashboard)

Para operar el bloqueo con un solo toque desde la interfaz de usuario, añade una tarjeta de tipo botón en la vista deseada de tu cuadro de mandos:

```yaml
type: button
entity: input_boolean.adguard_custom_list
name: Bloqueo Redes
icon: mdi:shield-lock-outline
tap_action:
  action: toggle
```

## 6. Verificación del Funcionamiento

1. Pulsa la tarjeta creada en tu dashboard para ponerla en estado **ON** o **OFF**.
2. Abre la pestaña **Filtros** > **Listas de bloqueo de DNS** en el panel web de AdGuard Home y recarga la página.
3. Comprueba que el selector de activación de la lista cambia entre marcado (activo) y desmarcado (inactivo) según el estado del botón en Home Assistant.

### Enlaces de interés
- [enlace](www.sherblog.es)

[link]: https://www.google.es
