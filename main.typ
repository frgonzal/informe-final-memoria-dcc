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

#capitulo(title: "Contexto del proceso quirúrgico y situación actual")[
  Este capítulo presenta el contexto del proceso quirúrgico que motiva el trabajo. Primero se distinguen dos dimensiones relevantes de la atención quirúrgica en Chile: la priorización de pacientes en lista de espera y la eficiencia operativa del proceso en pabellón. La primera se considera solo como antecedente del flujo; la segunda entrega la motivación principal para contar con sistemas que permitan coordinación, trazabilidad y seguimiento. Luego se describe cómo la Plataforma Lahuén representa actualmente el flujo de atención quirúrgica. Finalmente, se identifican las principales limitaciones técnicas de la versión anterior y se explica por qué la modernización debe conservar el flujo funcional, pero reemplazar su mecanismo de implementación.

  == Proceso quirúrgico y listas de espera

  La atención quirúrgica electiva suele organizarse a partir de listas de espera, cuyo origen se relaciona con una demanda asistencial mayor que la capacidad disponible del sistema. Esta capacidad depende de recursos como especialistas, pabellones, camas, financiamiento y otros elementos clínicos necesarios para resolver una intervención @JulioWY2016. Desde una perspectiva de gestión, esto plantea al menos dos problemas complementarios: decidir con qué prioridad debe atenderse a cada paciente y ejecutar el proceso quirúrgico de manera eficiente una vez que la intervención se aproxima a pabellón.

  Este trabajo no aborda el diseño de criterios de priorización ni la gestión integral de listas de espera. La lista se considera como antecedente porque conecta la indicación quirúrgica con la programación y con la posterior atención en pabellón. Para el módulo quirúrgico, lo relevante es que esa transición quede representada como parte de un flujo continuo, donde el sistema permita conocer el estado del paciente, registrar eventos relevantes y mantener trazabilidad entre la programación, la atención intraoperatoria y el cierre del episodio.

  == Situación de pabellones quirúrgicos en Chile

  La eficiencia del proceso quirúrgico constituye un problema relevante a nivel país. El Sistema Nacional de Servicios de Salud atiende aproximadamente al 80% de la población chilena, por lo que las mejoras en el uso de pabellones pueden incidir directamente en la capacidad de atención disponible para una proporción mayoritaria de la población @CNP2020Quirofanos. En este contexto, los sistemas de información no solo cumplen una función administrativa: también pueden apoyar la coordinación de equipos, la visibilidad del estado de cada paciente y la disponibilidad de datos para gestionar mejor los recursos quirúrgicos.

  El informe de la Comisión Nacional de Productividad caracteriza el proceso de atención quirúrgica como una secuencia que se origina en la indicación médica, continúa con una etapa prequirúrgica de exámenes, evaluación, seguimiento y admisión, luego con la intervención quirúrgica y finalmente con el postquirúrgico, que incluye recuperación, estancia y egreso @CNP2020Quirofanos. Esta descripción refuerza que la operación de pabellón depende de múltiples etapas y actores, y que las fallas de coordinación en cualquiera de ellas pueden afectar la eficiencia general del proceso.

  El mismo diagnóstico destaca que una mejor gestión de pabellones requiere información confiable, trazabilidad de pacientes y uso de tecnologías de información para apoyar la coordinación del proceso @CNP2020Quirofanos. Esto entrega una motivación directa para sistemas como el módulo quirúrgico de Lahuén: registrar hitos, estados, responsables, horarios y documentos no es solo una necesidad administrativa, sino una condición para observar el proceso, identificar atrasos y sostener mejoras operativas.

  Los datos del informe muestran además un margen importante de mejora. Un quirófano electivo promedio en Chile usa 4,8 de 9 horas institucionales, mientras que el referente internacional usado como comparación alcanza 6,4 de 9 horas. Asimismo, Chile realiza cerca de 3,3 cirugías diarias por quirófano, en comparación con 5,1 en el referente considerado, y la primera cirugía comienza en promedio con 40 minutos de retraso @CNP2020Quirofanos. Estos indicadores muestran que la oportunidad de mejora no depende únicamente de aumentar infraestructura, sino también de mejorar programación, preparación de pacientes, coordinación, manejo de suspensiones, trazabilidad e información disponible para la gestión.

  == Plataforma Lahuén y atención quirúrgica

  Lahuén es una plataforma de software hospitalario y registro clínico electrónico orientada a apoyar distintos procesos asistenciales, incluyendo urgencia, hospitalización, atención ambulatoria, pabellón y aplicaciones móviles. El sistema organiza la información en torno al paciente y a las acciones realizadas durante sus atenciones, de modo que cada episodio clínico pueda integrarse con registros previos, documentos, indicaciones y eventos relevantes. Bajo esta lógica, el módulo quirúrgico no funciona de manera aislada: se integra con la ficha clínica electrónica, las atenciones de urgencia, la hospitalización, los documentos clínicos y los registros asociados al paciente.

  En su versión previa, el módulo de atención quirúrgica incorporaba un flujo funcional compuesto por lista de espera quirúrgica, programación de pabellones, admisión electiva, solicitudes quirúrgicas desde urgencia, atención de pacientes en pabellón, documentos de cirugía y monitor de pacientes en pabellón. Esta secuencia permite observar que la plataforma ya incorporaba una visión completa del proceso, desde el ingreso de una orden quirúrgica hasta el cierre o egreso del paciente.

  En la lista de espera quirúrgica, los pacientes se priorizan por especialidad y criterios clínicos. Para cada caso se despliega información como fecha de ingreso, ficha, RUT, nombre, edad, disponibilidad, diagnóstico, procedimiento, tipo de hospitalización y médico responsable. Además, el estado de la lista se actualiza a medida que ocurren eventos asistenciales: una orden ingresa cuando se crea, sale cuando el paciente es operado, vuelve si la cirugía se suspende y puede eliminarse si se cumplen condiciones ministeriales específicas.

  Desde la lista de espera se construye la programación de pabellones. El sistema permite seleccionar pacientes por especialidad, asignarlos a bloques horarios, definir pabellón, horario, insumos, instrumentación especial y otros datos de la intervención. También permite revisar y editar una intervención programada, modificar horarios, registrar información complementaria y eliminar una intervención de la tabla, lo que devuelve al paciente a la lista de espera y libera el horario asignado.

  El flujo contempla además dos vías principales de ingreso al circuito quirúrgico operativo. En las cirugías electivas, la pantalla de admisión precarga las intervenciones programadas para el día y permite completar datos administrativos y clínicos del paciente. En las cirugías originadas desde urgencia, la orden quirúrgica se despliega en la lista de trabajo de pabellón en estado solicitada; luego, el anestesista o equipo correspondiente revisa antecedentes, acepta la solicitud y programa pabellón, fecha y hora.

  == Flujo de atención en pabellón

  Una vez aceptados los casos de urgencia o admisionados los casos electivos, la atención continúa en la vista de pacientes quirúrgicos. En esta lista de trabajo se muestran datos como documento, nombre, edad, especialidad, diagnóstico, programación, ubicación, estado y acciones disponibles para cada paciente. Las acciones permiten ingresar a la ficha, suspender la cirugía, recepcionar al paciente, registrar pasos de la cirugía, iniciar y terminar recuperación, iniciar traslado, egresar al paciente y acceder a documentos quirúrgicos.

  #image("./imagenes/vista-pabellon-legacy-2.png")

  El flujo intraoperatorio se estructura mediante hitos secuenciales. Primero se recepciona al paciente en pabellón y se selecciona la ubicación donde se realizará la operación. Luego, el sistema permite marcar pasos de la cirugía tales como iniciar anestesia, iniciar cirugía, finalizar cirugía y finalizar anestesia. Cada confirmación avanza el proceso y registra automáticamente la hora del evento. Esta información es relevante porque permite conocer el estado de la cirugía en tiempo real y precargar datos posteriores en documentos como el protocolo operatorio.

  Después del término de la anestesia, el paciente puede iniciar recuperación en una ubicación definida. Al finalizar la recuperación, el sistema habilita el traslado a otra unidad o el egreso, según corresponda. Para pacientes que continúan su atención en urgencia u hospitalización, el inicio de traslado marca el fin del proceso quirúrgico y el caso desaparece de la lista de trabajo de pabellón. Para pacientes de cirugía mayor ambulatoria, el egreso se registra cuando el paciente libera el cupo y el estado de su cirugía queda finalizado.

  La plataforma también considera la suspensión de cirugía. Esta acción puede realizarse antes de iniciar la cirugía en pabellón y exige registrar motivos asociados a categorías como paciente, administración, unidades de apoyo clínico, equipo quirúrgico, infraestructura, gremiales o emergencias. Cuando una cirugía electiva es suspendida, la orden vuelve a la lista de espera para ser programada nuevamente. Este comportamiento muestra que el flujo no es estrictamente lineal: debe contemplar retornos, excepciones y estados alternativos.

  == Documentos clínicos y monitor de pabellón

  Además de los cambios de estado, el módulo quirúrgico integra documentos clínicos propios del proceso. Entre ellos se encuentran la evaluación preanestésica, las pausas quirúrgicas y el protocolo operatorio. La evaluación preanestésica permite registrar la aptitud del paciente para la cirugía y el manejo anestésico requerido. Las pausas quirúrgicas se registran secuencialmente en tres momentos, orientadas a resguardar la seguridad del paciente durante la cirugía. El protocolo operatorio puede completarse durante o después de la intervención y genera un documento disponible en la ficha del paciente.

  El monitor de pacientes en pabellón entrega una vista global del estado de los pabellones y de las cirugías en curso. Cada fila representa un pabellón y muestra tanto el caso actual como la lista de trabajo pendiente según la programación del día. En esta vista se despliega información de paciente, horario programado, requerimientos, diagnóstico, procedimiento, equipo quirúrgico, especialidad y estado de la cirugía. Su objetivo es entregar visibilidad a jefaturas y equipos de coordinación, permitiendo anticipar retrasos y tomar decisiones operativas durante la jornada.

  En conjunto, estas funcionalidades muestran que la versión existente del módulo no debe entenderse solo como un sistema antiguo. También representa una formalización del flujo quirúrgico construido a partir de experiencia operacional. La modernización, por tanto, debe distinguir entre dos dimensiones: por una parte, el conocimiento funcional del proceso, que conviene preservar; por otra, la implementación técnica que lo soportaba, que presentaba limitaciones para evolucionar.

  == Limitaciones de la versión anterior

  La principal limitación de la versión anterior no era la ausencia de un flujo quirúrgico, sino la forma en que este flujo estaba implementado. El módulo había sido construido originalmente alrededor de 2012, utilizando herramientas y patrones que, más de una década después, resultaban difíciles de mantener y extender. En particular, la aplicación frontend de atención quirúrgica estaba construida en JavaScript con una arquitectura menos definida que la utilizada actualmente por la plataforma, lo que dificultaba separar responsabilidades, reutilizar componentes y agregar nuevas funcionalidades de manera controlada.

  En el backend, la coordinación del proceso dependía de un motor de procesos propietario de la empresa. Este motor permitía instanciar flujos quirúrgicos, mantener el contexto de cada caso, ejecutar actividades asincrónicas y avanzar en función de señales o llamadas realizadas desde el sistema. Esta capacidad fue útil para representar un proceso de larga duración con múltiples estados, pero generaba una dependencia técnica importante: comprender, mantener o modificar el comportamiento del flujo requería conocimiento especializado sobre el motor y sobre la forma en que cada instancia de proceso era consultada o actualizada.

  La existencia de un motor de procesos propietario también generaba una asimetría respecto del resto de la plataforma moderna, orientada a microservicios y componentes reutilizables. Mientras otros módulos podían evolucionar mediante APIs, componentes frontend y servicios con responsabilidades más claras, el proceso quirúrgico mantenía parte de su lógica crítica vinculada a un mecanismo especializado. Esto aumentaba el costo de corrección, dificultaba incorporar nuevas acciones y reducía la flexibilidad para adaptar el flujo a nuevos requerimientos.

  Desde el punto de vista de producto, esta situación generaba una tensión importante: el flujo funcional era valioso y debía conservarse, pero su implementación limitaba la evolución del módulo. Por ello, el trabajo de modernización no buscó aprender y replicar cada detalle interno del software anterior, sino rescatar el flujo de atención quirúrgica validado por la experiencia y reconstruirlo con herramientas actuales de la plataforma.

  == Síntesis de la situación actual

  La situación actual puede resumirse en tres ideas. Primero, el proceso quirúrgico es un flujo complejo, longitudinal y crítico para la gestión hospitalaria, cuya operación requiere priorización, programación, coordinación de recursos, registro de hitos y trazabilidad. Segundo, la Plataforma Lahuén ya contaba con una versión funcional del módulo quirúrgico, capaz de representar lista de espera, programación, atención en pabellón, documentos clínicos y monitor de estado. Tercero, la implementación técnica de esa versión presentaba limitaciones relevantes de mantenibilidad, principalmente por el uso de un frontend antiguo y un motor de procesos propietario.

  En consecuencia, la modernización debe entenderse como una reconstrucción tecnológica de un flujo funcional existente. El objetivo no es descartar la experiencia acumulada en la versión anterior, sino implementarla sobre una base más mantenible, integrada y extensible, que permita sostener futuras mejoras del módulo de pabellón dentro de la Plataforma Lahuén.
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
