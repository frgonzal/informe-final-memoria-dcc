Este capítulo describe cómo opera actualmente el módulo de pabellón en la Plataforma Lahuén, considerando lo documentado en el _Manual Lahuén 2022_ (Capítulo 5. Atención Quirúrgica) y el levantamiento técnico presentado en el informe #emph[Informe CC6907].

== Cómo se realiza actualmente el proceso

En el estado actual, la atención quirúrgica se organiza como un flujo que conecta la lista de espera, la programación de pabellones, la admisión o aceptación de casos y la ejecución intraoperatoria hasta el cierre del caso. Este flujo convive con dos tipos de origen de pacientes: cirugías electivas (programadas desde lista de espera) y cirugías de urgencia (solicitadas desde urgencia y luego aceptadas por pabellón).

// Sugerencia de imagen: captura del Manual Lahuén (Cap. 5.1) con la "Lista de espera quirúrgica".
En la lista de espera quirúrgica, los casos se visualizan con datos clínicos y administrativos relevantes, y se actualizan según los eventos asistenciales del paciente (por ejemplo, cuando se programa una cirugía, se suspende o se finaliza). Este comportamiento permite que la lista refleje el estado operativo del proceso en lugar de un registro estático.

// Sugerencia de imagen: captura del Manual Lahuén (Cap. 5.2) de "Programación de pabellones" / tabla quirúrgica.
Desde esa lista se construye la tabla quirúrgica, asignando pacientes a bloques horarios, especialidad, pabellón y requerimientos asociados. El sistema permite editar el detalle de intervenciones ya programadas, modificar horarios y, en caso necesario, eliminar una asignación para devolver el caso a lista de espera.

// Sugerencia de imagen: captura del Manual Lahuén (Cap. 5.5) de la vista "Pacientes Quirúrgicos".
En la vista de atención de pacientes en pabellón, cada fila representa un caso quirúrgico con información de identificación, diagnóstico, programación, ubicación y estado. Sobre cada caso se habilitan acciones clínicas y operativas para avanzar el flujo, incluyendo recepción, ejecución de pasos quirúrgicos, recuperación, traslado o egreso según corresponda.

El avance intraoperatorio se modela mediante estados y transiciones explícitas. En términos prácticos, el equipo clínico va confirmando hitos secuenciales, como ingreso a pabellón, inicio y término de anestesia, inicio y término de cirugía, inicio y término de recuperación, y cierre del caso por traslado o egreso. Cada transición registra marcas de tiempo y responsable, lo que aporta trazabilidad operativa.

// Sugerencia de imagen: captura del Manual Lahuén (Cap. 5.7) o del Informe CC6907 (Figura de monitor) para el "Monitor de pabellones".
Como complemento, existe un monitor de pabellones que entrega una vista global por quirófano, mostrando estado actual, casos en curso y casos pendientes de la jornada. Esta vista está orientada a coordinación y jefaturas, ya que facilita decisiones de reasignación y manejo de atrasos.

Además del flujo de estados, el módulo integra formularios y documentos clínicos del proceso quirúrgico, como evaluación preanestésica, pausas quirúrgicas y protocolo operatorio, cuyos registros quedan asociados a la ficha clínica electrónica del paciente.

== Limitaciones del sistema actual

Aunque el módulo actual cubre funcionalmente gran parte del proceso, presenta restricciones relevantes para su evolución. La principal limitación es tecnológica: la orquestación del flujo quirúrgico depende de un motor de procesos propietario heredado, cuya mantención requiere conocimiento específico y dificulta cambios frecuentes o extensiones controladas.

Desde la perspectiva de arquitectura, existe una asimetría entre este componente heredado y el resto de la plataforma moderna basada en servicios, lo que incrementa el costo de integración y reduce la reutilización entre distintos establecimientos. En la práctica, esto tensiona la mantenibilidad, la estabilidad ante fallas complejas y la velocidad de incorporación de mejoras.

También se observan limitaciones de adaptabilidad: parte de la solución fue construida con fuerte acoplamiento a un contexto hospitalario particular. Como consecuencia, trasladar el mismo módulo a otros hospitales o ajustarlo a nuevas reglas operativas exige esfuerzos de personalización mayores a los deseables.

== Stakeholders y usuarios del proceso

El módulo de pabellón involucra usuarios clínicos y no clínicos que interactúan en distintos momentos del flujo:

- Equipos médicos quirúrgicos y de anestesia, responsables de decisiones clínicas y de hitos intraoperatorios.
- Personal de enfermería y apoyo clínico, que ejecuta y registra parte importante de las transiciones operativas.
- Coordinación y jefaturas de pabellón, que utilizan la tabla quirúrgica y el monitor para gestionar capacidad, atrasos y prioridades del día.
- Equipos de urgencia y admisión, que alimentan el flujo con casos nuevos y validan condiciones de ingreso al circuito quirúrgico.
- Equipos de calidad y gestión, que requieren trazabilidad para seguimiento de tiempos, auditoría de eventos y mejora continua.

Desde la perspectiva técnica y de producto, también participan desarrollo de software, QA, UX y liderazgo técnico, ya que la evolución del módulo requiere coordinación entre necesidades clínicas y decisiones de arquitectura.

== Procesos existentes en el módulo de pabellón

Considerando la operación documentada, el proceso actual puede resumirse en cuatro bloques principales:

- Lista de espera quirúrgica: registro, priorización y seguimiento de pacientes pendientes de cirugía.
- Programación de pabellones: construcción y ajuste de la tabla quirúrgica diaria por bloques de tiempo y recursos.
- Admisión y solicitudes: incorporación de casos electivos y de urgencia al circuito de atención quirúrgica.
- Atención quirúrgica y monitor: ejecución del flujo intraoperatorio con estados, acciones, formularios clínicos y visualización global del estado de pabellones.

// Sugerencia de imagen: secuencia de pantallas del Manual (5.1 -> 5.2 -> 5.5 -> 5.7) para mostrar el flujo de punta a punta.
En conjunto, estos bloques muestran que la plataforma ya dispone de una base funcional robusta para operar pabellón. Sin embargo, la situación actual también evidencia que la modernización del núcleo de orquestación y la reducción del acoplamiento tecnológico son condiciones necesarias para sostener la evolución del módulo a mediano y largo plazo.
