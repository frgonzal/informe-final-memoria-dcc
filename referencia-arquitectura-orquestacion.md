# Referencia de arquitectura de orquestacion

Este archivo resume los mecanismos de coordinacion entre servicios que deben considerarse al redactar los capitulos 3 y posteriores del informe. No es una fuente bibliografica publica: es una guia interna de redaccion basada en la arquitectura y el codigo revisado.

## Idea central

La arquitectura actual de Lahuén combina microservicios de backend, eventos Kafka, BPM, Temporal, orquestaciones dinamicas, el servicio de eventos `sseservice` hacia el frontend y algunos servicios orquestadores de dominio. La modernizacion del modulo quirurgico no introduce un unico mecanismo nuevo para todo, sino que utiliza y extiende esta arquitectura para coordinar acciones distribuidas de forma mas mantenible.

## Mecanismos de coordinacion

### Eventos Kafka

Los servicios de dominio pueden emitir eventos cuando ocurren cambios relevantes. Un ejemplo concreto es el metodo `sendKafkaEvent` del servicio de atenciones de salud. Ese metodo publica eventos en el topico `api.hlth.patient-service` con datos como paciente, atencion, estado, tipo de atencion, ubicacion y tipo de evento. Estos eventos permiten desacoplar al servicio que modifica datos de los componentes que reaccionan a esos cambios.

### Suscripciones BPM a eventos

La base de datos de BPM contiene configuraciones en la tabla `event_subscription`. Estas suscripciones permiten escuchar eventos Kafka, filtrarlos y transformarlos para iniciar procesos. En el material de trabajo aparecen suscripciones del modulo quirurgico que inician `DynamicOrchestratorWorkflow` ante eventos como creacion o finalizacion de atenciones quirurgicas, creacion de evaluaciones o finalizacion de transferencias.

La evidencia interna de estas configuraciones esta en los scripts SQL de trabajo recopilados durante el proyecto. No citar esas rutas en el informe.

### sseservice hacia frontend

El servicio de eventos `sseservice` consume eventos Kafka y los redistribuye a clientes frontend mediante Server-Sent Events. Esto permite que la lista de trabajo quirurgica y otros monitores se actualicen en tiempo real o casi real, sin depender solo de polling.

En particular, `sseservice` consume Kafka y emite a clientes suscritos, mientras sus definiciones de endpoints establecen topicos y filtros disponibles. En el informe se debe hablar del servicio `sseservice`, no de carpetas internas.

### Workflows de Temporal

Los workflows de Temporal se implementan en PHP y deben estar registrados en workers. BPM puede instanciarlos mediante llamadas POST a su API o mediante suscripciones a eventos configuradas en base de datos. Un workflow permite coordinar varias tareas que involucran servicios independientes, conservando historial, estado durable y capacidad de reintento.

### Orquestador dinamico

El orquestador dinamico es un workflow de Temporal. Recibe una lista de actividades y un objeto de entrada. Tambien puede recibir un identificador de orquestacion para obtener la lista de actividades desde la base de datos.

Su ventaja principal es acelerar la construccion de workflows simples compuestos por llamadas encadenadas a servicios existentes. La mayor parte de la logica de negocio ya vive en los microservicios de dominio; el orquestador dinamico permite conectarla en una unica accion de proceso sin crear una clase de workflow especifica para cada caso.

El endpoint agregado en BPM para iniciar orquestaciones dinamicas es:

`POST /bpm/dynamic-orchestrations/{id}`

En el informe basta indicar que BPM expone este endpoint y que internamente valida parametros, carga la definicion de orquestacion y crea una instancia del workflow de orquestador dinamico.

### Servicio orquestador HEGC

Existe tambien un mecanismo mas imperativo de orquestacion en el backend: el servicio `hegc`. Este servicio se ubica por encima de varios dominios y ofrece APIs que coordinan actividades usando clases de otros servicios. En el proceso quirurgico, la funcionalidad relevante es la integracion con Gestion Hospitales.

El metodo `runCrearAgendaAppointment` importa datos desde Gestion Hospitales y coordina informacion de XRM, HLTH y Agenda para crear citas quirurgicas. Este caso existe porque Gestion Hospitales es una plataforma separada, con base de datos y logica propia, que contiene informacion de listas de espera y programacion quirurgica. Para pasar desde una cirugia programada al proceso quirurgico de Lahuén se deben importar datos de pacientes, profesionales, diagnosticos, intervenciones, pabellon y agenda.

Este mecanismo es util para integraciones complejas y especificas, pero tiene limitaciones: concentra logica transversal en una clase de servicio, requiere cambios de codigo cuando cambia la forma de importar o transformar datos, y queda mas acoplado a dominios concretos que una orquestacion dinamica. En el trabajo fue necesario modificar este servicio, incluyendo `runCrearAgendaAppointment`, porque cambio la forma de manejar los datos del proceso quirurgico.

## Como usar esta informacion en el informe

Capitulo 3 debe presentar los mecanismos a nivel arquitectonico: eventos, BPM, Temporal, orquestador dinamico, `sseservice` y servicio HEGC como caso de orquestacion imperativa existente. No debe entrar aun en cada tabla, JSON o endpoint salvo como ejemplos breves.

Capitulo 5 debe explicar el diseno de la solucion: que acciones usan orquestacion dinamica, que eventos actualizan el frontend, como BPM instancia workflows y por que algunas integraciones siguen pasando por HEGC.

Capitulo 6 debe detallar la implementacion: endpoint `POST /bpm/dynamic-orchestrations/{id}`, estructura de actividades dinamicas, suscripciones BPM relevantes, consumo de eventos mediante `sseservice` en la lista de trabajo y cambios en el servicio HEGC para importacion desde Gestion Hospitales.

## Redaccion recomendada

Evitar presentar la arquitectura como si solo existiera un mecanismo de orquestacion. La explicacion correcta es que coexisten varios niveles:

- eventos para notificar cambios;
- suscripciones BPM para reaccionar a eventos e iniciar workflows;
- workflows de Temporal para procesos durables;
- orquestaciones dinamicas para secuencias simples y configurables;
- `sseservice` para propagar eventos al frontend;
- servicios orquestadores como `hegc` para integraciones imperativas y especificas.

El aporte del trabajo se debe posicionar como una extension de esta arquitectura, especialmente por la incorporacion de orquestaciones dinamicas y su uso en el nuevo proceso quirurgico, no como reemplazo absoluto de todos los mecanismos existentes.
