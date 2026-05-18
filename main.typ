#import "final.typ": agradecimientos, apendice, capitulo, conf, dedicatoria, end-doc, resumen, start-doc
#import "metadata.typ": metadata

#show: conf.with(metadata: metadata)

#resumen(metadata: metadata)[]

#dedicatoria[]

#agradecimientos[]

#show: start-doc


#capitulo(title: "Introducción")[
  == Contexto general

  La digitalización de procesos clínicos y hospitalarios se ha transformado en una necesidad prioritaria para los sistemas de salud. La creciente demanda asistencial, la presión por optimizar recursos escasos y la necesidad de contar con información oportuna para la toma de decisiones han impulsado el desarrollo de plataformas digitales capaces de integrar distintos ámbitos de la operación hospitalaria. En este escenario, los sistemas de información en salud han dejado de ser simples repositorios de datos para convertirse en herramientas activas de gestión clínica, coordinación operativa y trazabilidad de procesos.

  Dentro de los distintos ámbitos hospitalarios, la gestión quirúrgica representa uno de los procesos más complejos. Su ejecución requiere coordinar pacientes, equipos clínicos, pabellones, equipamiento, camas y tiempos de atención, todo ello en un contexto donde conviven actividades programadas y situaciones de urgencia. El proceso quirúrgico no se limita al acto operatorio, sino que comprende un flujo más amplio cuyos principales hitos son la indicación o programación de la cirugía, la atención en pabellón y el cierre postoperatorio del episodio asistencial.

  La correcta gestión de este flujo tiene consecuencias directas sobre la eficiencia hospitalaria, la calidad de la atención y la seguridad del paciente. Un sistema capaz de representar adecuadamente el proceso quirúrgico, registrar sus hitos y apoyar la coordinación entre sus distintos participantes puede transformarse en un componente clave para mejorar tanto la operación diaria como la capacidad de análisis y mejora continua de una institución de salud.

  == Organización

  El presente trabajo se desarrolla en el contexto de Lahuén Health SpA, una empresa chilena de tecnologías de información en salud con más de 15 años de experiencia en la digitalización de procesos hospitalarios. Su trabajo incluye la implementación de soluciones en distintos establecimientos del país, entre ellos el Hospital Exequiel González Cortés, el Hospital San Borja Arriarán y el Ministerio de Salud. La organización ha construido una plataforma modular que integra distintos componentes relacionados con la atención de pacientes, la gestión asistencial y la operación hospitalaria, con el objetivo de ofrecer una solución extensible e interoperable.

  Dentro de esta plataforma, el módulo de pabellón ocupa un lugar estratégico, ya que articula el trabajo quirúrgico con otros componentes clínicos y administrativos del sistema. Su función no es únicamente registrar eventos, sino también apoyar el seguimiento de los pacientes quirúrgicos, facilitar la coordinación entre equipos y entregar visibilidad del estado del proceso. Debido a ello, cualquier mejora o modernización de este módulo tiene un impacto relevante tanto en la operación clínica como en la evolución tecnológica de la plataforma en su conjunto.

  == Problema

  A pesar de contar con una implementación funcional del proceso quirúrgico, el módulo existente presenta limitaciones importantes desde el punto de vista tecnológico y de mantenibilidad. La solución actual se apoya en tecnología propietaria de la empresa, específicamente un motor de procesos propietario que permite ejecutar actividades asincrónicas, permanecer a la espera de eventos y mantener el estado de cada instancia de proceso. Si bien este enfoque resolvió necesidades operativas en su momento, hoy dificulta la evolución del sistema y encarece su mantención.

  Esta situación genera varios problemas. En primer lugar, la lógica del proceso quirúrgico se encuentra fuertemente acoplada a componentes específicos, lo que hace más costoso modificar el flujo, incorporar nuevas acciones o adaptar el módulo a otros contextos hospitalarios. En segundo lugar, la base tecnológica heredada limita la integración con la arquitectura moderna del resto de la plataforma, dificultando la reutilización de componentes y la incorporación de capacidades transversales como mejor observabilidad, manejo robusto de errores y sincronización eficiente con otras partes del sistema. En tercer lugar, la existencia de una solución especializada y dependiente de tecnologías antiguas introduce deuda técnica, afectando la estabilidad, la escalabilidad y la velocidad con que pueden implementarse mejoras.

  Desde una perspectiva funcional, esto se traduce en una brecha entre lo que el sistema ya logra hacer y lo que necesita ofrecer en el futuro. Aunque el módulo permite representar y operar el flujo quirúrgico, no cuenta todavía con una base suficientemente moderna, flexible y reusable como para sostener su evolución de manera segura y sostenible.

  == Motivación y relevancia

  La modernización del proceso quirúrgico resulta relevante por razones tanto operativas como tecnológicas. Desde el punto de vista del dominio clínico, la gestión de pabellones y del flujo intraoperatorio requiere una coordinación precisa y una trazabilidad clara de cada etapa del proceso. Disponer de una herramienta que refleje adecuadamente el estado de cada paciente, las transiciones relevantes y las acciones posibles en cada momento puede contribuir a mejorar la visibilidad del proceso y apoyar la toma de decisiones por parte de los equipos clínicos.

  Desde el punto de vista tecnológico, este proyecto responde a la necesidad de alinear el módulo quirúrgico con la arquitectura actual de la plataforma, reduciendo deuda técnica y sentando bases más sólidas para futuras extensiones. Modernizar este componente no solo mejora su mantenibilidad y confiabilidad, sino que también permite que el sistema evolucione hacia una solución más reusable y adaptable a distintos establecimientos de salud.

  La relevancia del trabajo también radica en que aborda un problema real dentro de un entorno de producción, donde las decisiones de diseño e implementación deben responder tanto a requerimientos técnicos como a necesidades operativas concretas. En ese sentido, el proyecto no se limita a proponer una solución teórica, sino que busca construir una mejora efectiva sobre un sistema que ya forma parte del trabajo cotidiano de una organización del sector salud.

  == Objetivos

  El objetivo general de este trabajo es modernizar el proceso de atención quirúrgica de una plataforma digital de salud, reemplazando una solución propietaria heredada de orquestación por una arquitectura más simple de mantener, más flexible para evolucionar y con un flujo completo y trazable para pacientes quirúrgicos, tanto en cirugías electivas como de urgencia.

  Para alcanzar este objetivo general, se plantean los siguientes objetivos específicos:

  - Modelar de forma explícita el flujo de atención quirúrgica mediante un conjunto coherente de estados y acciones.
  - Modernizar la vista de atención quirúrgica para integrarla adecuadamente a la plataforma y representar la información relevante de cada paciente.
  - Sustituir el motor de procesos propietario por una solución más sencilla de mantener y más adecuada para coordinar acciones complejas del flujo.
  - Reducir la dependencia de tecnología propietaria difícil de evolucionar, disminuyendo el costo técnico asociado a correcciones, mejoras y cambios futuros.
  - Mejorar la trazabilidad de los hitos del proceso quirúrgico, de modo que sea posible reconstruir el recorrido de un caso y disponer de información útil para análisis posteriores.
  - Validar la solución mediante pruebas funcionales y despliegues controlados que permitan verificar su uso en un entorno real.
  - Dejar una base técnica y documental que facilite la evolución futura del módulo de pabellón.

  == Resumen de la solución

  La solución propuesta consiste en modernizar el núcleo del proceso de atención quirúrgica sobre la arquitectura actual de la plataforma, manteniendo su valor clínico y operativo, pero reemplazando los componentes propietarios que dificultan su evolución. Para ello, se plantea modelar el flujo de atención quirúrgica como una secuencia explícita de estados y transiciones, donde cada acción relevante del usuario tenga un comportamiento claramente definido y trazable.

  En el backend, la modernización considera reemplazar el motor de procesos propietario por una solución más simple de operar y mantener para aquellas operaciones que requieren coordinar múltiples pasos o servicios. A diferencia del esquema anterior, donde cada proceso quirúrgico se instanciaba como una ejecución persistente que mantenía su propio estado y se controlaba mediante llamadas directas al motor, la nueva aproximación busca separar mejor la lógica del proceso, reducir la complejidad de corrección y disminuir el costo asociado a su soporte. En paralelo, se busca consolidar un modelo de dominio unificado para representar cada atención quirúrgica, integrando datos clínicos, de programación y de ubicación del paciente.

  En el frontend, la solución se materializa en una vista de atención quirúrgica integrada a la plataforma, concebida como una lista de trabajo que muestra el estado de los pacientes y permite ejecutar las acciones correspondientes a cada etapa. De esta manera, la solución busca combinar claridad operativa para los usuarios con una arquitectura más mantenible y extensible desde el punto de vista del desarrollo de software.

  == Alcance

  El alcance del trabajo se concentra en la modernización del proceso de atención quirúrgica, especialmente en el flujo intraoperatorio y en las etapas cercanas a este. Esto incluye la representación del flujo de pacientes quirúrgicos, la ejecución de acciones asociadas a cambios de estado y el registro de hitos relevantes para la trazabilidad del proceso.

  No forma parte del alcance una reconstrucción completa de todo el módulo de pabellón ni un rediseño integral del sistema de listas de espera quirúrgicas. En cambio, el proyecto se enfoca en una parte acotada pero fundamental del problema, buscando construir una base tecnológica moderna sobre la cual puedan apoyarse futuras mejoras y extensiones.

  Esta delimitación permite trabajar sobre un objetivo abordable dentro del contexto del proyecto, al mismo tiempo que deja preparado el terreno para continuar evolucionando el sistema en etapas posteriores.

  == Estructura del documento

  El presente informe se organiza de la siguiente manera. En primer lugar, se presenta el estado del arte y el contexto técnico y operativo del problema abordado. Luego, se describen los objetivos del trabajo y la solución propuesta, incluyendo el modelado del flujo de atención quirúrgica y las principales decisiones de diseño. A continuación, se expone el plan de trabajo y el desarrollo realizado, detallando los avances implementados tanto en la vista de atención quirúrgica como en la unificación de datos, el manejo de estados y acciones, y la nueva orquestación del proceso. Finalmente, se presentan la evaluación del trabajo realizado, las conclusiones y las posibles líneas de trabajo futuro.
]

#capitulo(title: "Contexto y situación actual")[
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

  Aunque el módulo actual cubre funcionalmente gran parte del proceso, presenta restricciones relevantes para su evolución. La principal limitación es tecnológica: la orquestación del flujo quirúrgico depende de un motor de procesos propietario de la empresa, que ejecuta actividades asincrónicas, mantiene el estado de cada instancia y espera señales externas para avanzar. Su mantención requiere conocimiento especializado y vuelve costosos tanto los cambios funcionales como la corrección de incidencias durante la operación.

  Desde la perspectiva de arquitectura, existe una asimetría entre este componente propietario y el resto de la plataforma moderna basada en servicios, lo que incrementa el costo de integración y reduce la reutilización entre distintos establecimientos. En la práctica, esto tensiona la mantenibilidad, la estabilidad ante fallas complejas y la velocidad de incorporación de mejoras, especialmente porque cada instancia de proceso debe ser consultada o actualizada mediante llamadas al propio motor para avanzar en su estado.

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
]

#capitulo(title: "Estado del arte / marco teórico")[
]

#capitulo(title: "Análisis del problema y requerimientos")[
]

#capitulo(title: "Diseño de la solución")[
]

#capitulo(title: "Implementación")[
]

#capitulo(title: "Evaluación y validación")[
]

#capitulo(title: "Resultados")[
]

#capitulo(title: "Conclusiones")[
]

#capitulo(title: "Trabajo futuro")[
]

#show: end-doc
