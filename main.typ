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

  El presente trabajo se desarrolla en el contexto de Lahuén Health SpA, una empresa chilena de tecnologías de información en salud con experiencia en la digitalización de procesos hospitalarios. Su trabajo se origina en proyectos de innovación desarrollados junto a equipos clínicos del Hospital Exequiel González Cortés, y actualmente se orienta a articular soluciones tecnológicas para el ecosistema de salud mediante su HIS disponible en la Plataforma Lahuén @LahuenHealthAbout. La organización ha construido una plataforma modular que integra distintos componentes relacionados con la atención de pacientes, la gestión asistencial y la operación hospitalaria, con el objetivo de ofrecer una solución extensible e interoperable.

  Dentro de esta plataforma, el módulo de pabellón ocupa un lugar estratégico, ya que articula el trabajo quirúrgico con otros componentes clínicos y administrativos del sistema. Su función no es únicamente registrar eventos, sino también apoyar el seguimiento de los pacientes quirúrgicos, facilitar la coordinación entre equipos y entregar visibilidad del estado del proceso. Debido a ello, cualquier mejora o modernización de este módulo tiene un impacto relevante tanto en la operación clínica como en la evolución tecnológica de la plataforma en su conjunto.

  == Problema

  A pesar de contar con una implementación funcional del proceso quirúrgico, el módulo existente presenta limitaciones importantes desde el punto de vista tecnológico y de mantenibilidad. La solución actual se apoya en tecnología propietaria de la empresa, específicamente un motor de procesos propietario que permite ejecutar actividades asincrónicas, permanecer a la espera de eventos y mantener el estado de cada instancia de proceso. Si bien este enfoque resolvió necesidades operativas en su momento, hoy dificulta la evolución del sistema y encarece su mantención.

  Esta situación genera varios problemas. En primer lugar, la lógica del proceso quirúrgico se encuentra fuertemente acoplada a componentes específicos, lo que hace más costoso modificar el flujo, incorporar nuevas acciones o adaptar el módulo a otros contextos hospitalarios. En segundo lugar, la base tecnológica previa limita la integración con la arquitectura moderna del resto de la plataforma, dificultando la reutilización de componentes y la incorporación de capacidades transversales como mejor observabilidad, manejo robusto de errores y sincronización eficiente con otras partes del sistema. En tercer lugar, la existencia de una solución especializada y dependiente de tecnologías antiguas introduce deuda técnica, afectando la estabilidad, la escalabilidad y la velocidad con que pueden implementarse mejoras.

  Desde una perspectiva funcional, esto se traduce en una brecha entre lo que el sistema ya logra hacer y lo que necesita ofrecer en el futuro. Aunque el módulo permite representar y operar el flujo quirúrgico, no cuenta todavía con una base suficientemente moderna, flexible y reusable como para sostener su evolución de manera segura y sostenible.

  == Motivación y relevancia

  La modernización del proceso quirúrgico resulta relevante por razones tanto operativas como tecnológicas. Desde el punto de vista del dominio clínico, la gestión de pabellones y del flujo intraoperatorio requiere una coordinación precisa y una trazabilidad clara de cada etapa del proceso. Disponer de una herramienta que refleje adecuadamente el estado de cada paciente, las transiciones relevantes y las acciones posibles en cada momento puede contribuir a mejorar la visibilidad del proceso y apoyar la toma de decisiones por parte de los equipos clínicos.

  Desde el punto de vista tecnológico, este proyecto responde a la necesidad de alinear el módulo quirúrgico con la arquitectura actual de la plataforma, reduciendo deuda técnica y sentando bases más sólidas para futuras extensiones. Modernizar este componente no solo mejora su mantenibilidad y confiabilidad, sino que también permite que el sistema evolucione hacia una solución más reusable y adaptable a distintos establecimientos de salud.

  La relevancia del trabajo también radica en que aborda un problema real dentro de un entorno de producción, donde las decisiones de diseño e implementación deben responder tanto a requerimientos técnicos como a necesidades operativas concretas. En ese sentido, el proyecto no se limita a proponer una solución teórica, sino que busca construir una mejora efectiva sobre un sistema que ya forma parte del trabajo cotidiano de una organización del sector salud.

  == Objetivos

  El objetivo general de este trabajo es modernizar el proceso de atención quirúrgica de una plataforma digital de salud, reemplazando la dependencia del motor de procesos propietario por una arquitectura más simple de mantener, más flexible para evolucionar y con un flujo completo y trazable para pacientes quirúrgicos, tanto en cirugías electivas como de urgencia.

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

  #figure(
    image("./imagenes/vista-pabellon-legacy-2.png", width: 100%),
    caption: "Vista de pacientes quirúrgicos en la versión previa del módulo de pabellón.",
  )

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

#capitulo(title: "Marco tecnológico y arquitectura de la plataforma")[
  Este capítulo presenta las tecnologías y conceptos arquitectónicos sobre los cuales se construye la modernización del módulo de atención quirúrgica. A diferencia del capítulo anterior, que describe el dominio clínico-operativo y la situación inicial del módulo, aquí se revisan los elementos técnicos que permiten implementar la nueva solución: microservicios, frontend modular, workflows, Temporal, eventos y coordinación configurable de procesos.

  El objetivo no es documentar toda la arquitectura interna de la Plataforma Lahuén, sino establecer el marco necesario para comprender las decisiones tomadas durante el desarrollo. En particular, interesa explicar por qué el reemplazo del motor de procesos propietario se apoya en una arquitectura distribuida, en un runtime de workflows durable y en definiciones declarativas que permiten coordinar acciones complejas sin codificar cada flujo de forma rígida.

  == Arquitectura general de Lahuén

  La Plataforma Lahuén se organiza como un conjunto de aplicaciones y servicios que colaboran para implementar procesos asistenciales. En el backend, la plataforma utiliza microservicios construidos principalmente en PHP, lenguaje orientado al desarrollo de aplicaciones web y servicios de servidor @PHPDocs. Estos servicios concentran responsabilidades por dominio funcional, por ejemplo agenda, registro clínico, hospitalización, formularios, procesos y tareas. Esta separación permite que cada servicio exponga operaciones específicas y que los módulos de la plataforma integren capacidades de distintos dominios sin concentrar toda la lógica en una aplicación monolítica.

  En términos generales, la arquitectura de microservicios busca dividir un sistema en servicios pequeños, desplegables y mantenibles de forma independiente. Esta decisión entrega flexibilidad, pero también introduce desafíos de coordinación: una acción de negocio puede requerir llamadas a varios servicios, manejo de estados intermedios, reintentos, trazabilidad y control de errores. La literatura sobre microservicios reconoce esta tensión entre autonomía de servicios y complejidad de interacción, especialmente cuando los flujos de negocio se distribuyen entre múltiples componentes @NadeemM2022.

  En el contexto de este trabajo, dicha tensión aparece con claridad en el proceso quirúrgico. Acciones como recepcionar un paciente, cambiar su ubicación, registrar hitos intraoperatorios, crear tareas clínicas o finalizar etapas del flujo no pertenecen necesariamente a un único servicio. Por ello, la modernización requiere una forma de coordinar operaciones distribuidas sin volver a construir un motor de procesos propietario acoplado a un módulo específico.

  == Backend y microservicios PHP <sec-backend-microservicios>

  Los microservicios backend de Lahuén están implementados principalmente en PHP y se estructuran en torno a APIs, entidades de negocio, servicios, stores y esquemas de validación. Entre los proyectos relevantes para este trabajo aparecen paquetes asociados a dominios como agenda, salud, gestión clínica y procesos. Estos servicios son responsables de consultar y modificar datos de negocio, aplicar reglas propias de cada dominio y emitir eventos cuando ocurren cambios relevantes.

  Para el módulo quirúrgico, los servicios backend más relevantes son aquellos que permiten consultar pacientes y atenciones, crear o actualizar citas, mover pacientes entre ubicaciones, registrar documentos clínicos y coordinar tareas del proceso. Esta distribución permite reutilizar capacidades existentes de la plataforma, pero también obliga a que ciertas acciones del flujo quirúrgico sean implementadas como coordinaciones entre servicios. Por ejemplo, una transición de estado puede requerir actualizar una atención clínica, liberar o utilizar una ubicación, registrar una tarea y dejar trazabilidad del evento.

  La decisión de mantener esta separación es importante para la modernización. En lugar de concentrar toda la lógica quirúrgica en una aplicación aislada, la nueva solución se integra con los servicios existentes y utiliza mecanismos de coordinación para acciones que cruzan límites de dominio. Esto permite conservar la modularidad de la plataforma y, al mismo tiempo, disponer de puntos explícitos para ejecutar flujos de negocio.

  Varias entidades de la plataforma incluyen un campo de datos extendidos, o `extendedData`, almacenado como JSON. Este campo permite guardar información estructurada que depende del contexto de uso de la entidad, sin mezclarla con los atributos comunes del modelo. En el módulo quirúrgico, la información específica del flujo se almacena principalmente bajo la propiedad `pabellon`, de modo que datos como estado operacional, programación, intervenciones, diagnósticos, responsable, origen y hitos queden agrupados en una sección propia. Esto es especialmente relevante en entidades reutilizadas por distintos módulos, como la atención de paciente, porque permite agregar información quirúrgica sin afectar otros contextos clínicos.

  Junto a los microservicios de dominio, la plataforma también cuenta con servicios que cumplen funciones de coordinación más específicas. Un caso relevante para el proceso quirúrgico es el servicio HEGC, que integra información proveniente de Gestión Hospitales con servicios de Lahuén como HLTH, XRM y Agenda. Esta forma de coordinación es más imperativa y acoplada al caso de uso, pero resulta necesaria cuando el origen de datos se encuentra en una aplicación anterior de la plataforma, con base de datos, tablas y esquemas distintos a los usados por los microservicios actuales.

  == Arquitectura frontend: aplicaciones, listas de trabajo y plugins <sec-arquitectura-frontend>

  El frontend moderno de Lahuén se construye sobre una arquitectura modular basada en componentes Vue 2 @Vue2Docs. La base compartida de esa arquitectura se encuentra en `shared`, proyecto que concentra elementos reutilizables por distintas aplicaciones: componentes genéricos de interfaz, como tablas, selectores, datepickers y typeaheads; formateadores; utilidades JavaScript; proxies de API; estilos; imágenes; íconos y skins. Las skins agrupan CSS y recursos visuales para adaptar una aplicación a una institución o contexto visual específico.

  Dentro de `shared` también se define `WebApp`, clase reutilizable para construir aplicaciones modernas de la plataforma. `WebApp` inicializa el ciclo de vida de una aplicación, carga configuración, prepara APIs, store, rutas, recursos visuales, autenticación y eventos. Como se observa en la @fig-arquitectura-web-app, una aplicación puede construirse directamente sobre `WebApp` para obtener estas capacidades comunes y luego agregar su propia estructura, componentes y comportamiento.

  La personalización de una aplicación también se apoya en configuración. Cada proyecto frontend incluye un archivo de manifiesto y la plataforma mantiene una configuración asociada en MongoDB; `WebApp` combina ambas fuentes para obtener la configuración final. En general, el manifiesto define información del paquete y APIs disponibles, mientras que la configuración de MongoDB define variables usadas por la aplicación o por sus plugins, como plugins activos y parámetros de comportamiento.

  #figure(
    image("./imagenes/arquitectura_web_app_1.png", width: 80%),
    caption: [Relación entre `WebApp`, aplicaciones, plugins y recursos compartidos en la arquitectura frontend de Lahuén.],
  ) <fig-arquitectura-web-app>

  `WebApp` también soporta plugins. La clase base `Plugin`, ubicada en `shared`, entrega a cada plugin acceso a la aplicación, store, APIs y eventos. Con este mecanismo, una aplicación puede cargar piezas de funcionalidad separadas y permitir que cada plugin registre comportamiento específico. Los plugins sirven para extender una aplicación sin mezclar toda la lógica en su base común.

  Un tipo frecuente de aplicación en Lahuén son las listas de trabajo, o worklists. Estas aplicaciones organizan la operación diaria alrededor de una grilla de casos, filtros, navegación, panel de acciones, paginación, ordenamiento y actualización de filas. Para este patrón existe una aplicación base de worklists construida sobre `WebApp`, junto con `WorklistPlugin`, una extensión de `Plugin` que agrega comportamiento común para plugins de listas de trabajo.

  La personalización de una worklist se realiza mediante plugins. Un plugin de worklist puede registrar módulos, componentes, menús, filtros, grillas, formularios, suscripciones a eventos y reglas del dominio. De esta forma, la aplicación base conserva la estructura común, mientras que cada plugin define cómo se muestran y operan los casos de un proceso específico.

  En las worklists también existen plugins comunes, como `standard`, que permiten reutilizar modelos y formularios entre aplicaciones. Estos componentes viven en un plugin porque son más específicos que los componentes genéricos de `shared`: por ejemplo, secciones de formularios asociadas a paciente, clínico, ubicación o admisión. En cambio, `shared` contiene piezas más transversales, como componentes de tabla, datepicker, select, typeahead, formateadores, utilidades, skins e íconos.

  == Procesos de negocio y workflows

  Un proceso quirúrgico no corresponde a una única operación puntual. Se trata de un flujo de larga duración compuesto por eventos, decisiones, esperas, excepciones y cambios de estado. Además, por motivos legales y de trazabilidad, el sistema debe registrar tiempos, hitos y otras acciones relevantes del proceso. Eso exige modelar la operación como una secuencia verificable de estados y transiciones, más que como una acción aislada.

  En sistemas de microservicios, existen dos formas comunes de coordinar este tipo de procesos: coreografía y orquestación. En una coreografía, los servicios reaccionan a eventos y cada uno decide localmente qué hacer. En una orquestación, existe un componente que coordina explícitamente la secuencia de actividades. La coreografía reduce dependencias directas, pero puede dificultar la observación global del proceso cuando el flujo queda distribuido entre múltiples servicios. La orquestación, en cambio, permite representar el proceso de forma más explícita y facilita entender qué actividades se ejecutaron, cuáles fallaron y en qué estado se encuentra una instancia @NadeemM2022.

  Para el caso del módulo quirúrgico, la orquestación resulta adecuada porque muchas acciones requieren una secuencia definida y trazable. La recepción de un paciente, el avance de hitos intraoperatorios, la suspensión de una cirugía o la creación de tareas asociadas al protocolo operatorio son ejemplos de acciones donde importa el orden, el resultado de pasos previos y el estado final del proceso. Por ello, los workflows durables son una alternativa técnica pertinente para coordinar operaciones distribuidas sin concentrar toda la lógica en la interfaz de usuario ni repartirla de forma implícita entre servicios.

  == Temporal como runtime de workflows

  Temporal es una plataforma para ejecutar workflows durables, diseñada para coordinar procesos de negocio que pueden involucrar llamadas a servicios, reintentos, esperas y fallas parciales @TemporalDocs. En Temporal, un workflow define la lógica de coordinación, mientras que las actividades encapsulan operaciones que pueden interactuar con sistemas externos. Los workers son procesos que registran workflows y actividades, consumen tareas desde una cola de trabajo y ejecutan el código correspondiente. Para PHP, Temporal provee un SDK específico que permite implementar workflows y workers en ese lenguaje @TemporalPHPDocs.

  La principal ventaja de Temporal para este proyecto es que permite separar la lógica de coordinación de las operaciones concretas realizadas por los microservicios. El workflow puede representar la secuencia general y delegar en actividades las llamadas HTTP, transformaciones, validaciones o actualizaciones necesarias. Además, Temporal mantiene historial de ejecución y estado durable, lo que ayuda a observar y depurar procesos distribuidos. Esta característica es relevante en microservicios, donde los errores de interacción entre servicios suelen ser difíciles de diagnosticar cuando el flujo no está representado de manera explícita @NadeemM2022.

  En la arquitectura de Lahuén, los workflows de Temporal se implementan utilizando PHP y el SDK de Temporal para ese lenguaje. Estos workflows y sus actividades son registrados por workers, que consumen tareas desde una cola de trabajo y ejecutan el código correspondiente. De este modo, la ejecución del proceso queda fuera del frontend y de los microservicios de dominio, pero puede invocar a estos servicios cuando una actividad lo requiere.

  La instanciación de workflows se centraliza en el microservicio BPM. Esto puede ocurrir mediante llamadas directas a su API o mediante suscripciones configuradas en la base de datos de BPM, que permiten iniciar workflows a partir de eventos definidos por la plataforma. Así, BPM actúa como puerta de entrada para iniciar workflows de Temporal, mientras que los workers se encargan de procesarlos.

  == Coordinación mediante eventos, BPM y SSE

  Dentro de la solución, el microservicio BPM cumple el rol de punto de integración para procesos. Su responsabilidad no es reemplazar a todos los servicios de dominio, sino ofrecer un mecanismo común para iniciar workflows de Temporal. En términos prácticos, el frontend o un servicio de la plataforma puede solicitar la ejecución de una acción de negocio; BPM recibe la solicitud, instancia el workflow correspondiente y deja su ejecución a cargo de Temporal y de los workers registrados.

  La plataforma también utiliza mecanismos de mensajería para comunicar eventos entre componentes. Los microservicios actuales emiten eventos relevantes cuando ejecutan acciones sobre entidades de negocio, por ejemplo cambios en citas, atenciones, indicaciones o evaluaciones. Estos eventos se publican como mensajes en tópicos Kafka, y Kafka se encarga de ponerlos a disposición de los consumidores interesados. De esta manera, otros componentes pueden reaccionar sin acoplarse directamente al servicio que produjo el cambio. Por ejemplo, cuando una atención cambia de estado, el servicio de salud puede emitir un evento que informa el paciente, la atención, el tipo de atención, el estado y el tipo de operación realizada.

  Estos eventos pueden ser utilizados de dos maneras relevantes para este trabajo. Primero, BPM puede escuchar eventos mediante suscripciones configuradas en base de datos. Cada suscripción define el tópico, filtros y una transformación que permite iniciar un workflow de Temporal cuando ocurre una condición de negocio. Segundo, existe un servicio de SSE, sigla de Server-Sent Events, que actúa como consumidor de eventos Kafka y los entrega al frontend mediante un canal persistente. Este servicio expone un endpoint al que el navegador se conecta mediante una solicitud `GET`; desde ese momento, el servidor puede escribir mensajes en la conexión abierta. En la nueva lista de trabajo quirúrgica, SSE se utiliza para reaccionar ante cambios en atenciones, citas, indicaciones o evaluaciones, actualizando la vista con menor latencia y mejorando la coordinación operativa.

  Esta combinación permite separar tres tipos de comunicación. Los eventos comunican que algo ocurrió en el sistema y permiten que otros componentes reaccionen. Las suscripciones BPM convierten ciertos eventos en inicios de procesos. Los workflows, en cambio, coordinan acciones que deben ejecutarse como parte de un flujo durable. En el módulo quirúrgico estas ideas conviven: algunos cambios se publican como eventos de negocio, algunos eventos gatillan workflows y ciertas acciones críticas se ejecutan mediante orquestaciones explícitas.

  == Workflows configurables y DSL

  Una forma de reducir el acoplamiento en procesos repetitivos es describir parte de la coordinación mediante configuraciones interpretadas por un workflow. En vez de codificar cada secuencia como una implementación distinta, una definición puede indicar qué actividades ejecutar, con qué datos, en qué orden y bajo qué condiciones. Este tipo de enfoque permite separar la infraestructura durable del workflow de la descripción concreta de cada acción de negocio.

  Esta idea se relaciona con el uso de lenguajes específicos de dominio, o DSL, para modelar problemas recurrentes con abstracciones cercanas al dominio. En arquitecturas de microservicios, los DSL pueden ayudar a describir componentes, conexiones y reglas de ejecución de manera más modular y comprensible, reduciendo parte de la complejidad accidental del sistema @SolisCK2025. De forma similar, los workflows guiados por datos permiten que ciertas decisiones de ejecución dependan de la estructura y contenido de los mensajes o configuraciones, moviendo parte de la lógica desde código rígido hacia definiciones interpretadas en tiempo de ejecución @SafinaMM2015.

  En una arquitectura basada en Temporal, este enfoque no reemplaza al runtime de workflows. Temporal entrega ejecución durable, historial, workers y reintentos; la configuración describe la secuencia específica que debe interpretarse. Esta separación resulta útil cuando distintas acciones comparten un patrón similar: recibir parámetros, validar entrada, consultar datos, llamar servicios, usar respuestas previas y decidir si ciertos pasos deben ejecutarse. En esos casos, una coordinación configurable puede reducir la repetición de código y hacer más explícita la relación entre pasos.

  == Servicios orquestadores de dominio

  No toda coordinación de la plataforma se resuelve mediante Temporal. En la arquitectura existente también hay servicios de dominio que cumplen un rol orquestador cuando deben integrar aplicaciones o bases de datos con estructuras distintas. Para el proceso quirúrgico, el caso más importante es el servicio HEGC, que contiene lógica para relacionar Gestión Hospitales con componentes actuales de Lahuén.

  Gestión Hospitales es una aplicación de Lahuén desarrollada previamente para apoyar la gestión de listas de espera. Utiliza una base de datos más antigua, con tablas y esquemas distintos a los usados por los microservicios actuales. Como la programación quirúrgica electiva se registra allí, iniciar el proceso quirúrgico en la nueva lista requiere leer las órdenes programadas para el día, transformar sus datos y vincularlos con servicios como HLTH, XRM y Agenda.

  El servicio HEGC resuelve este tipo de integración mediante clases PHP que llaman a otros servicios y construyen las estructuras necesarias para la plataforma. Este enfoque permite resolver integraciones específicas, como la creación de citas de Agenda a partir de órdenes quirúrgicas, la finalización de una cirugía o la suspensión de una orden. Sin embargo, también tiene limitaciones: la lógica queda codificada en una clase concreta, los cambios de datos requieren modificar código y la coordinación queda más acoplada al caso de uso que en una orquestación declarativa. Por esta razón, en el desarrollo fue necesario modificar este servicio cuando cambió la forma de importar los datos quirúrgicos.

  == Relación con la modernización del módulo quirúrgico

  Los elementos descritos en este capítulo explican la base técnica necesaria para modernizar el módulo quirúrgico. El problema combina una interfaz de trabajo clínico, entidades distribuidas entre servicios, integración con sistemas previos, coordinación de acciones complejas y actualización oportuna de la información mostrada al usuario.

  Por ello, la solución debía apoyarse en componentes existentes de la plataforma: una aplicación frontend modular para construir la lista de trabajo, microservicios de dominio para operar sobre datos clínicos y administrativos, eventos para comunicar cambios, BPM y Temporal para coordinar procesos, y servicios específicos para adaptar información proveniente de Gestión Hospitales.

  Esta base tecnológica conecta con los capítulos siguientes. Primero se traduce el problema en requerimientos concretos y luego se explica cómo el diseño del nuevo módulo organiza estados, entidades, acciones, formularios, eventos y coordinación.
]

#capitulo(title: "Análisis del problema y requerimientos")[
  Este capítulo traduce la situación descrita en los capítulos anteriores en un conjunto de necesidades concretas para la nueva versión del módulo de atención quirúrgica. El problema abordado no corresponde a la ausencia de un flujo quirúrgico, sino a la necesidad de reconstruir un flujo ya validado sobre una base técnica más mantenible, más integrada con la plataforma actual y capaz de reaccionar oportunamente a los cambios que ocurren durante la operación clínica.

  La definición de requerimientos se realizó durante el desarrollo del proyecto, mediante reuniones de trabajo con los supervisores. Uno de ellos cumplía un rol principalmente técnico y conocía tanto la plataforma como el flujo quirúrgico anterior; el otro aportaba una visión más cercana al negocio y al funcionamiento operativo del proceso. A partir de reuniones de avance, discusiones técnicas y revisión de cada problema funcional, se definieron las tareas necesarias para reconstruir partes del flujo anterior con herramientas nuevas y para resolver las brechas que aparecían al adaptar el proceso a la arquitectura actual de la plataforma.

  == Problema actual

  La versión previa del módulo quirúrgico cumplía una función operacional relevante. Permitía representar solicitudes quirúrgicas, programación, atención en pabellón, recuperación, traslado, documentos clínicos y monitorización. Sin embargo, su implementación presentaba limitaciones que dificultaban la evolución del producto. Estas limitaciones se concentraban en cuatro dimensiones: el motor de procesos propietario, el frontend antiguo, la forma de representar el estado del proceso y la falta de actualización reactiva en la interfaz.

  En primer lugar, el flujo quirúrgico dependía del motor de procesos propietario. Este motor mantenía instancias de proceso de larga duración, conservaba datos en memoria o en el contexto interno de cada ejecución y permitía avanzar el flujo mediante señales o acciones específicas. Aunque esta solución permitió implementar el proceso en su momento, generaba un costo alto de mantención. Resolver errores o modificar datos asociados a una instancia podía ser complejo, ya que parte del estado operativo no se encontraba directamente representado en entidades de dominio consultables mediante servicios estándar, sino dentro de la ejecución del proceso. En consecuencia, una corrección aparentemente simple podía requerir comprender la estructura interna del motor, el estado de la instancia y la forma exacta en que el flujo había llegado hasta ese punto.

  En segundo lugar, la interfaz anterior estaba construida sobre una base tecnológica antigua, con menor separación entre vista, acciones, modelo y lógica de integración. Esto dificultaba agregar nuevas funcionalidades sin afectar comportamiento existente, reutilizar componentes comunes de la plataforma y mantener una experiencia consistente con otras aplicaciones. El problema no era solo visual: un frontend poco modular también aumenta el costo de diagnosticar errores, aplicar reglas por estado y ajustar la disponibilidad de acciones según el contexto clínico.

  En tercer lugar, el modelo de datos anterior dependía en gran medida de la instancia del proceso para conocer información como el estado, el paciente o la etapa de la atención. Esta dependencia era una limitación importante para la nueva arquitectura. La plataforma actual organiza sus capacidades alrededor de servicios de dominio, tales como salud, agenda, evaluaciones y tareas. Por ello, la nueva versión debía dejar de depender de la instancia del motor como fuente principal de verdad y pasar a reconstruir la atención quirúrgica a partir de entidades explícitas: indicaciones quirúrgicas, citas de agenda y atenciones de pacientes.

  En cuarto lugar, la interfaz no contaba con un mecanismo suficientemente reactivo para escuchar cambios relevantes del sistema. En un proceso quirúrgico, una acción realizada por otro usuario, un cambio de ubicación, la creación de una cita, la modificación de una atención o el registro de una evaluación pueden alterar lo que debe mostrarse en la lista de trabajo. Sin eventos hacia el frontend, la aplicación depende de recargas manuales o de consultas periódicas, lo que reduce la capacidad de reacción y puede mostrar información desactualizada en un contexto operacional sensible.

  La combinación de estos problemas generaba una tensión central: el flujo funcional debía conservarse, porque representaba conocimiento operativo acumulado, pero la implementación no ofrecía una base adecuada para evolucionar. La nueva solución debía, por tanto, reconstruir el flujo sin cambiar innecesariamente la experiencia esperada por los usuarios, pero reemplazando los mecanismos que dificultaban mantención, corrección y adaptación futura.

  == Necesidades de modernización

  A partir del problema anterior, la modernización debía satisfacer varias necesidades generales. La primera era preservar el comportamiento funcional del proceso quirúrgico. Los usuarios debían poder operar el flujo desde la nueva lista de trabajo, incluyendo acciones de programación, recepción, avance intraoperatorio, recuperación, cierre, suspensión, documentación clínica y consulta de ficha. La nueva versión no buscaba rediseñar el proceso clínico completo, sino mantener su lógica y reconstruirlo con una arquitectura más clara.

  La segunda necesidad era representar el estado mediante entidades del dominio. Las solicitudes de urgencia debían leerse desde indicaciones; las atenciones ya iniciadas debían leerse desde atenciones de pacientes; y las cirugías programadas debían representarse mediante citas de Agenda. Este cambio era necesario porque, al dejar de depender del motor de procesos propietario, ya no era adecuado obtener la información principal desde una instancia de proceso. La nueva lista de trabajo debía ser capaz de reunir esas fuentes, adaptarlas y presentarlas como una única atención quirúrgica coherente.

  La tercera necesidad era coordinar acciones que involucran múltiples servicios. En el flujo quirúrgico, una acción visible para el usuario puede requerir consultar datos, actualizar una cita, crear una atención, modificar una ubicación, registrar hitos, crear tareas BPM o completar información en Gestión Hospitales. En la versión anterior, parte de esta coordinación se encontraba dentro del motor. En la nueva versión, debía existir un mecanismo capaz de ejecutar esas secuencias de forma mantenible, validando entradas y reduciendo código repetido.

  La cuarta necesidad era mejorar la reactividad operacional. La lista de trabajo quirúrgica debía poder recibir eventos relevantes y actualizarse cuando cambiaran las entidades que componen la atención quirúrgica. Esto implicaba integrar el frontend con un canal persistente de eventos basado en SSE, y mejorar los filtros para que una suscripción pudiera recibir eventos asociados a listas de valores, no solo a valores únicos.

  La quinta necesidad era mejorar la experiencia de uso sin alterar de manera innecesaria el flujo conocido. Además de reconstruir las acciones existentes, la nueva lista de trabajo debía incorporar mejoras acotadas para apoyar situaciones operacionales concretas, como revertir un ingreso accidental a pabellón y registrar digitalmente los cuidados intraoperatorios definidos para la atención de pabellón.

  == Requerimientos funcionales del flujo quirúrgico

  El requerimiento funcional principal fue reconstruir el flujo de atención quirúrgica sobre la nueva lista de trabajo. Esto implicaba soportar los dos orígenes principales del proceso: solicitudes de urgencia y atenciones electivas programadas. En el primer caso, el flujo comienza con una indicación quirúrgica originada desde urgencia. En el segundo, el flujo comienza con una orden quirúrgica programada en Gestión Hospitales, aplicación de Lahuén usada para trabajar con la lista de espera quirúrgica.

  Para las atenciones electivas, se requirió integrar las órdenes de Gestión Hospitales con la nueva versión del flujo. Gestión Hospitales cuenta con una base de datos anterior, orientada a la lista de espera, que contiene información de clínicos, pacientes y órdenes quirúrgicas. En particular, la tabla de órdenes contiene datos necesarios para iniciar la programación en la nueva lista, como fecha de intervención, paciente, cirujano e información asociada a la orden. Como esa estructura no corresponde al esquema actual de microservicios, se diseñó una transformación que toma las órdenes programadas para el día, adapta sus datos y crea una cita programada de atención quirúrgica en Agenda. Esta acción se expuso mediante un endpoint del servicio HEGC, invocado periódicamente cada madrugada por un script ejecutado en uno de los servidores del hospital.

  Para las solicitudes de urgencia, el requerimiento fue dejar de depender de información importada a la instancia del proceso y utilizar directamente los datos de indicaciones. Antes, parte de la información de una solicitud quirúrgica podía incorporarse al flujo mediante eventos o estructuras asociadas al motor. En la nueva versión, la lista de trabajo debía leer indicaciones vigentes, extraer de ellas paciente, ubicación, intervenciones, diagnósticos y datos de origen, y convertir esa información en una representación compatible con el resto de atenciones quirúrgicas.

  En ambos casos, el módulo debía mostrar una visión unificada del paciente quirúrgico. Para lograrlo, se requirió normalizar información proveniente de tres fuentes: indicaciones, citas de Agenda y atenciones de pacientes. Esta normalización debía resolver diferencias de estructura, estado, ubicación, programación, diagnósticos, intervenciones, responsable y datos de creación. El usuario no debía distinguir internamente si una fila provenía de una indicación, una cita o una atención ya iniciada; debía ver una atención quirúrgica con estado, datos relevantes y acciones disponibles.

  El flujo debía conservar los estados y transiciones principales de la versión previa. Entre ellos se consideran estados como solicitada, programada, en espera, preoperatorio, en pabellón, etapas de anestesia y cirugía, recuperación, espera de alta, espera de traslado, espera de egreso, finalizada y suspendida. Cada estado debía habilitar solo las acciones coherentes con el momento clínico-operativo del caso. Por ejemplo, la evaluación preanestésica debe estar disponible antes del ingreso a pabellón, las pausas quirúrgicas deben estar asociadas a etapas intraoperatorias, el protocolo quirúrgico debe poder completarse cuando corresponde y la suspensión debe limitarse a los estados donde aún tiene sentido operacional.

  Además, se requirió implementar acciones explícitas para operar el flujo desde la interfaz. La lista de trabajo debía permitir:

  - Aceptar órdenes.
  - Recepcionar pacientes.
  - Ingresar a pabellón.
  - Iniciar anestesia.
  - Iniciar cirugía.
  - Finalizar cirugía.
  - Finalizar anestesia.
  - Iniciar recuperación.
  - Finalizar recuperación.
  - Iniciar traslado.
  - Devolver al paciente a su unidad de origen.
  - Egresar pacientes.
  - Suspender cirugías.
  - Reagendar intervenciones.
  - Cambiar ubicación.
  - Revertir ingreso a pabellón.
  - Imprimir brazalete.
  - Abrir la ficha clínica del paciente.
  - Cargar y guardar evaluación preanestésica, pausas quirúrgicas, protocolo quirúrgico y cuidados intraoperatorios.
  - Abrir el PDF del protocolo quirúrgico cuando el documento ya existe.

  La mayoría de estas acciones ya existían funcionalmente en la versión anterior y debían comportarse de forma equivalente desde el punto de vista del usuario. Otras, como la reversa de ingreso a pabellón y el formulario de cuidados intraoperatorios, se incorporaron como mejoras de la nueva lista de trabajo para apoyar casos operacionales específicos y facilitar el trabajo de los usuarios.

  == Requerimientos de información y modelo de datos

  Un requerimiento central de la nueva versión fue separar la atención quirúrgica como modelo frontend de las entidades reales que la originan. La atención quirúrgica visible en la grilla no corresponde a una entidad única de base de datos, sino a una representación construida a partir de fuentes de dominio. Esto exigió definir adaptadores capaces de tomar datos desde HLTH, Agenda e indicaciones, y producir una estructura común para la interfaz.

  Este modelo debía incluir información clínica y operacional suficiente para ejecutar acciones. Entre los datos relevantes se encuentran paciente, documento, nombre social, edad, ubicación actual, ubicación de origen, responsable, programación, intervenciones, diagnósticos, estado, evaluaciones asociadas, hitos cumplidos, tipo de origen, modalidad CMA u hospitalizado y datos de creación. También debía conservar referencias a la entidad original, de modo que cada acción pudiera saber si debía operar sobre una indicación, una cita o una atención de paciente.

  La incorporación de Agenda fue un cambio especialmente relevante. En el modelo anterior, la programación podía quedar asociada a la instancia del proceso. En la nueva versión, una cirugía programada se representa como una cita de Agenda, lo que permite consultar, actualizar, reagendar, iniciar, cancelar o finalizar una programación mediante servicios de dominio. Para ello se requirió soportar tipos de cita quirúrgica, referencias externas, participantes, pabellones como participantes y filtros por tipo de cita.

  La información de intervenciones y diagnósticos también requirió normalización. En el flujo quirúrgico conviven datos provenientes de indicaciones, órdenes de Gestión Hospitales y atenciones ya creadas. La nueva versión debía presentar estos datos de manera comprensible para el usuario, evitando duplicidades, ocultando códigos cuando no aportaban a la operación diaria y priorizando la visualización de intervenciones como dato principal de la grilla.

  == Requerimientos de orquestación y coordinación

  La nueva solución debía reemplazar parte de lo que antes resolvía el motor de procesos propietario. Para ello, se requirió un mecanismo capaz de ejecutar acciones complejas formadas por múltiples llamadas a servicios. Estas acciones no debían quedar codificadas íntegramente en el frontend, porque eso acoplaría la interfaz a detalles de backend y dificultaría cambios futuros. Tampoco era conveniente crear código específico para cada variación del flujo si muchas acciones seguían el mismo patrón: validar entrada, consultar datos, construir payloads, ejecutar llamadas HTTP y usar respuestas previas para pasos posteriores.

  Por esta razón, se definió como requerimiento contar con un mecanismo de coordinación ejecutado fuera del frontend y apoyado en la capa de procesos de la plataforma. Este mecanismo debía recibir parámetros, validarlos, resolver datos de contexto, ejecutar condiciones y llamar a servicios de la plataforma. Debía permitir acciones como aceptar una orden de urgencia, recepcionar pacientes, finalizar recuperación, iniciar traslado, devolver a unidad de origen, suspender, finalizar una atención, crear tareas BPM para completar protocolo quirúrgico y operar una orden en Gestión Hospitales cuando corresponde.

  La coordinación debía soportar encadenamiento de respuestas. Muchas acciones requieren que el resultado de una llamada sea usado por la siguiente: por ejemplo, consultar una cita para obtener participantes, buscar un clínico, crear o iniciar una atención y luego actualizar datos extendidos. Por lo tanto, el mecanismo elegido debía permitir referencias a respuestas previas, asignaciones intermedias, valores por defecto, transformaciones de tipos, condiciones de ejecución y construcción de cuerpos de solicitud.

  También se requirió que el mecanismo fuera reutilizable. El objetivo no era construir un nuevo motor de procesos propietario, sino contar con una forma común de coordinar acciones acotadas que siguieran patrones similares. Esto permitiría agregar nuevas acciones simples o medianamente complejas sin depender siempre de una implementación específica para cada caso.

  == Requerimientos de eventos y actualización de la interfaz

  La lista de trabajo quirúrgica debía reaccionar ante cambios realizados por otros componentes de la plataforma. Para ello, se requirió escuchar eventos de negocio relacionados con atenciones, indicaciones, citas y evaluaciones. Estos eventos son necesarios porque el proceso quirúrgico no ocurre solo dentro de una pantalla: un cambio puede originarse desde Agenda, EHR, HLTH, BPM, una acción de otro usuario o una integración externa.

  En la práctica, la interfaz debía conectarse a un canal persistente de eventos hacia frontend. La implementación de la plataforma se apoya en el servicio de SSE ya descrito, que consume eventos desde Kafka y permite que el navegador reciba mensajes a través de una conexión mantenida abierta. Lo importante desde el punto de vista del requerimiento es que la lista pueda suscribirse a eventos relevantes y actualizar la grilla cuando cambie una entidad asociada al flujo quirúrgico.

  Los filtros de eventos debían ser suficientemente expresivos para evitar recargas innecesarias. Durante el desarrollo se identificó que los filtros existentes eran limitados, porque permitían comparar contra valores únicos, pero no contra listas de valores. Para el flujo quirúrgico esto era insuficiente: una lista de trabajo puede necesitar escuchar varios pacientes, varias citas, varias atenciones o varios tipos de eventos. Por ello se incorporó como requerimiento que el servicio de eventos permitiera filtros con listas, de modo que un cliente pudiera recibir eventos que coincidieran con cualquiera de los valores relevantes.

  Además, el frontend debía evitar recargas excesivas. En un sistema basado en eventos, una misma acción puede generar varios eventos consecutivos. Por lo tanto, la lista de trabajo debía aplicar mecanismos como debounce para agrupar actualizaciones y evitar que la interfaz se recargara múltiples veces de forma innecesaria. Este requerimiento se relaciona tanto con rendimiento como con experiencia de usuario.

  Los eventos también debían habilitar acciones automáticas en BPM. Algunas suscripciones configuradas debían permitir iniciar coordinaciones de proceso al ocurrir eventos relevantes. Por ejemplo, al crearse una atención quirúrgica puede generarse una tarea para completar el protocolo; al guardarse el protocolo puede completarse una tarea BPM y operar la orden en Gestión Hospitales; al finalizar un traslado puede finalizarse la atención quirúrgica; y al finalizar una atención quirúrgica puede notificarse o actualizarse Gestión Hospitales. Estos requerimientos muestran que los eventos no solo actualizan la interfaz, sino que también coordinan efectos posteriores del proceso.

  == Requerimientos de aplicaciones y monitores

  La modernización frontend no debía limitarse a una única pantalla de operación. El proceso quirúrgico requiere distintos niveles de visibilidad según el tipo de usuario y el contexto de uso. Por ello, se requirió construir tres aplicaciones complementarias: la aplicación principal de pabellón, el Monitor de pabellones y el Monitor de pacientes.

  La primera aplicación corresponde a la vista de pabellón. Su objetivo es permitir que los equipos clínicos y operacionales gestionen el flujo quirúrgico desde una lista de trabajo, ejecutando acciones sobre cada caso, revisando documentos, cambiando estados, registrando hitos y consultando atenciones anteriores. Esta aplicación concentra la operación activa del proceso.

  La segunda aplicación corresponde al Monitor de pabellones. Su objetivo es entregar una vista de coordinación interna orientada al uso de pabellones. A diferencia de la lista de trabajo, esta aplicación no busca exponer todas las acciones disponibles, sino mostrar qué pabellones existen, cuáles están siendo utilizados, qué cirugía se encuentra en curso en cada uno y qué cirugías están programadas o próximas. El requerimiento principal de este monitor fue entregar información rápida para jefaturas y equipos de coordinación, de modo que pudieran identificar ocupación de quirófanos, ubicación del paciente, estado de la cirugía e información relevante para anticipar el flujo de la jornada.

  La tercera aplicación corresponde al Monitor de pacientes. Esta vista está orientada a familiares o acompañantes que esperan fuera del área clínica. Su objetivo es informar de manera simple en qué etapa del proceso se encuentra la persona atendida, sin exponer detalles clínicos innecesarios ni acciones operacionales. Por ello, el requerimiento fue construir una pantalla de lectura, adecuada para sala de espera, que mostrara una identificación acotada del paciente, su estado general y su ubicación o etapa visible del proceso.

  Estas tres aplicaciones comparten la necesidad de leer entidades quirúrgicas desde los servicios de la plataforma, adaptarlas a modelos frontend y mantenerse actualizadas ante eventos. Sin embargo, cada una presenta la información con un propósito distinto: operar el flujo, coordinar pabellones o informar a familiares. Esta separación permite responder a necesidades de usuarios diferentes sin sobrecargar una sola interfaz con todos los usos posibles.

  == Requerimientos de documentos y formularios clínicos

  El proceso quirúrgico incluye documentos y evaluaciones clínicas que pertenecen a la ficha del paciente. Entre ellos se encuentran evaluación preanestésica, protocolo quirúrgico, pausas quirúrgicas y cuidados intraoperatorios. Por ello, la nueva lista de trabajo no podía implementar formularios aislados sin integración con EHR. Debía existir una forma de abrir formularios de la ficha desde el módulo quirúrgico, manteniendo la relación con la atención del paciente y con los tipos de evaluación correspondientes.

  Para resolver esto, se requirió cargar formularios de la aplicación EHR desde la lista quirúrgica, utilizando una integración embebida mediante `iframe`. Este enfoque permite reutilizar capacidades de la ficha clínica y mantener los documentos dentro del sistema donde pertenecen. Al mismo tiempo, exigió crear o mejorar formularios, estilos, datos precargados y lógica específica para el flujo quirúrgico.

  Los formularios debían corresponder a nuevas versiones de documentos previos, conservando su objetivo clínico pero adaptándolos a la nueva arquitectura. La evaluación preanestésica debía cargar datos del paciente y de la cirugía; el protocolo quirúrgico debía precargar información del proceso y permitir generar documento; las pausas quirúrgicas debían representarse como secciones de checklist de seguridad; y los cuidados intraoperatorios debían registrarse como evaluación asociada al caso cuando correspondiera.

  También se requirió controlar la disponibilidad de cada evaluación por estado. No todos los documentos tienen sentido en cualquier momento del proceso. Por ejemplo, la evaluación preanestésica debe estar disponible antes del ingreso a pabellón, las pausas quirúrgicas durante el avance intraoperatorio y el protocolo quirúrgico durante o después de la intervención. Esta regla evita que los usuarios ejecuten acciones fuera de contexto y ayuda a mantener consistencia clínica.

  == Requerimientos de experiencia de usuario

  La nueva aplicación debía integrarse a la experiencia visual y operacional del hospital donde se implementa. Esto incluye utilizar el estilo característico del establecimiento, colores, banner, iconografía, distribución de columnas y mensajes coherentes con el resto de la plataforma. La modernización no debía percibirse como una herramienta aislada, sino como una evolución natural del sistema usado por los equipos clínicos.

  La grilla principal debía presentar información suficiente sin sobrecargar al usuario. Para ello se requirió ordenar acciones, limitar la cantidad de acciones expuestas directamente y mover acciones secundarias a menús adicionales. También se requirió mejorar columnas como programación, ubicación, estado e intervenciones, de modo que el usuario pudiera comprender rápidamente qué ocurre con cada paciente.

  Los mensajes de confirmación y error debían ser operacionales. En una interfaz clínica, mostrar respuestas técnicas de API puede confundir al usuario y dificultar la resolución de problemas. Por ello se requirió entregar mensajes orientados a la acción, indicando qué ocurrió, qué no se pudo realizar y, cuando corresponde, qué paciente, ubicación o etapa está involucrada.

  Algunas capacidades nuevas responden directamente a requerimientos de experiencia de usuario y apoyo operacional. La acción de revertir ingreso a pabellón permite corregir un ingreso accidental sin tratarlo como suspensión. El formulario de cuidados intraoperatorios permite registrar dentro de la plataforma información que antes podía quedar fuera del flujo digital. Ambas mejoras son acotadas, pero contribuyen a que la nueva lista sea más práctica para los equipos que operan el proceso.

  == Requerimientos no funcionales

  La mantenibilidad fue uno de los requerimientos no funcionales principales. La solución debía reducir el acoplamiento entre frontend, motor de procesos y reglas de negocio. Para ello, se requería un modelo explícito de estados y acciones, adaptadores de datos por fuente, servicios de dominio reutilizables y orquestaciones configurables para acciones complejas. Esta separación permite modificar una parte del sistema sin afectar innecesariamente las demás.

  La extensibilidad también era esencial. El módulo quirúrgico debía quedar preparado para incorporar nuevos estados, acciones, formularios, eventos o integraciones. Esto se relaciona con el uso de registros de estados y acciones en frontend, con la necesidad de coordinar acciones mediante definiciones reutilizables y con la reutilización de componentes compartidos de la plataforma.

  La interoperabilidad fue otro requisito clave. La solución debía integrarse con Gestión Hospitales, Agenda, HLTH, la aplicación EHR para formularios clínicos, BPM, Temporal, el servicio de SSE y los mecanismos de eventos de la plataforma. Esta integración debía hacerse sin concentrar toda la lógica en un único componente, respetando las responsabilidades de cada parte de la plataforma.

  La trazabilidad debía mejorar respecto de la versión anterior, especialmente en el registro de fechas y horas de hitos relevantes del proceso. El sistema debía conservar información sobre recepción, ingreso a pabellón, hitos de anestesia y cirugía, recuperación, traslado, egreso y otros momentos clínico-operativos. Esta trazabilidad permite reconstruir el recorrido del paciente y apoyar análisis posteriores. Sin embargo, el alcance del trabajo no resuelve completamente toda la auditoría posible del proceso. Aún existen mejoras futuras, como registrar de manera más sistemática quién ejecuta cada acción y cubrir hitos que se producen como reacción a eventos y no siempre quedan guardados con el mismo nivel de detalle.

  La continuidad operacional fue una restricción transversal. El módulo debía integrarse con una plataforma existente y con procesos reales del hospital. Por ello, la modernización debía preservar el comportamiento esperado por los usuarios, evitar rupturas innecesarias con el flujo anterior y permitir ajustes progresivos durante la puesta en marcha.

  Finalmente, la confidencialidad y el resguardo de información interna condicionan la forma de documentar e implementar la solución. El informe describe la arquitectura, los requerimientos y las decisiones principales sin exponer detalles sensibles que no son necesarios para comprender el aporte técnico del trabajo.

  == Síntesis de requerimientos

  En síntesis, la nueva versión del módulo de atención quirúrgica debía cumplir con los siguientes requerimientos principales:

  - Conservar el flujo quirúrgico funcional de la versión previa, incluyendo estados, acciones, hitos y documentos relevantes.
  - Soportar atenciones originadas tanto en solicitudes de urgencia como en programaciones electivas.
  - Importar datos desde Gestión Hospitales mediante el servicio HEGC y representarlos como citas quirúrgicas de Agenda.
  - Normalizar información proveniente de indicaciones, citas y atenciones de pacientes en una única representación de atención quirúrgica.
  - Ejecutar acciones del proceso quirúrgico desde la lista de trabajo, manteniendo comportamiento equivalente para los usuarios.
  - Incorporar mejoras operacionales acotadas, como revertir ingreso a pabellón y registrar cuidados intraoperatorios.
  - Reemplazar la dependencia del motor de procesos propietario por coordinaciones ejecutadas mediante BPM y Temporal.
  - Permitir que las orquestaciones validen entradas, llamen a múltiples servicios, usen respuestas previas y ejecuten condiciones.
  - Escuchar eventos relevantes en el frontend mediante un canal persistente de eventos y actualizar la grilla con menor latencia.
  - Mejorar los filtros de eventos para aceptar listas de valores y reducir eventos irrelevantes.
  - Reaccionar a eventos desde BPM para ejecutar coordinaciones asociadas a tareas, protocolo, traslados y cierre de atenciones.
  - Implementar tres aplicaciones frontend complementarias: vista operativa de pabellón, Monitor de pabellones y Monitor de pacientes.
  - Entregar visibilidad interna sobre ocupación de pabellones, cirugías en curso y próximas atenciones quirúrgicas.
  - Entregar una visualización pública y acotada del estado del proceso para familiares o acompañantes en sala de espera.
  - Integrar formularios clínicos de EHR mediante una carga embebida y adaptar evaluación preanestésica, pausas quirúrgicas, protocolo y cuidados intraoperatorios.
  - Aplicar el estilo visual del hospital y mejorar la experiencia de uso de la grilla, acciones, mensajes y filtros.
  - Registrar fechas de hitos relevantes del flujo quirúrgico, dejando la auditoría completa de responsables y algunos hitos automáticos como trabajo futuro.
  - Mantener una arquitectura extensible, interoperable y compatible con la continuidad operacional de la plataforma.

  Estos requerimientos establecen el puente entre el diagnóstico del problema y el diseño de la solución. La siguiente etapa consiste en explicar cómo se organizaron los componentes de frontend, backend, eventos y orquestación para satisfacer estas necesidades sin reconstruir un motor de procesos propietario, pero conservando el flujo quirúrgico que la plataforma ya había validado en su operación.
]

#capitulo(title: "Diseño de la solución")[
  Este capítulo presenta el diseño conceptual de la solución propuesta para modernizar el módulo de atención quirúrgica. El foco está en explicar cómo se organiza el flujo, qué componentes participan y cómo se conectan para sostener la operación clínica.

  La intención es mostrar las decisiones de diseño antes de entrar en detalles técnicos. La implementación concreta de acciones, servicios, eventos, formularios y orquestaciones se desarrolla en el capítulo siguiente.

  == Estados del flujo quirúrgico

  El proceso quirúrgico se representó como una secuencia de estados. Estos estados ya existían en la versión anterior del módulo y fueron diseñados por la empresa a lo largo de años de trabajo con el flujo de pabellón. La modernización los mantuvo porque entregan una forma validada de modelar un proceso complejo. Cada estado indica la etapa del paciente, los datos relevantes para la grilla y las acciones disponibles para el usuario.

  La @fig-estados-proceso-quirurgico muestra una versión simplificada del flujo, centrada en la acción principal de cada estado cuando el caso avanza sin excepciones. El flujo real incluye acciones adicionales, como completar formularios o suspender la atención, y también puede verse afectado por eventos externos. En el diseño, el origen del caso, las acciones disponibles y las condiciones de salida determinan cómo avanza cada paciente.

  #figure(
    image("./imagenes/diagrama-simplificado-estados-proceso-quirurgico.png", width: 100%),
    caption: [Flujo simplificado de estados principales del proceso quirúrgico y transiciones esperadas.],
  ) <fig-estados-proceso-quirurgico>

  Los estados se organizaron en grupos funcionales:

  - *Estados de ingreso*: 'Solicitada' representa una orden quirúrgica de urgencia pendiente de aceptación. 'Programada' representa una cirugía electiva ya agendada.
  - *Estados de preparación*: 'En espera' representa un paciente incorporado al circuito quirúrgico, pero aún no recepcionado en pabellón. 'Preoperatorio' indica que el paciente ya fue recepcionado y puede ingresar a quirófano.
  - *Estados intraoperatorios*: 'En pabellón' marca la entrada al quirófano. Luego el caso avanza por 'Anestesia iniciada', 'Cirugía iniciada', 'Cirugía finalizada' y 'Anestesia finalizada'. Estos estados registran los hitos temporales del acto quirúrgico.
  - *Estado de recuperación*: 'En recuperación' indica que terminó la etapa intraoperatoria. La acción principal es finalizar recuperación, lo que determina el camino posterior del paciente.
  - *Estados de salida*: 'Esperando alta' corresponde a pacientes ambulatorios a los que no se les indica hospitalización, por lo que deben recibir el alta para retirarse. 'Esperando egreso' indica que el caso está listo para egresar al paciente. 'Esperando traslado' representa la espera de movimiento hacia otra unidad. 'En tránsito' indica que el paciente ya inició el traslado. 'Finalizada' marca el cierre del caso.
  - *Estado de excepción*: 'Suspendida' representa una atención quirúrgica que fue suspendida. En la aplicación se utiliza en el módulo de atenciones anteriores para identificar esos casos y consultar su información, pero no tiene acciones relevantes dentro del flujo.

  Con estos estados, la lista de trabajo muestra rápidamente quién está pendiente de aceptación, preparado para pabellón, en cirugía, en recuperación o en etapa de salida. También permite reconstruir el recorrido del paciente mediante ubicación, programación, hitos, evaluaciones y documentos disponibles.

  == Entradas del flujo quirúrgico

  La nueva lista de trabajo quirúrgica obtiene los casos desde entidades explícitas y servicios existentes. Con esto se reemplaza la dependencia de instancias del motor de procesos propietario como fuente principal para representar el caso en la grilla.

  === Flujo de urgencia

  En urgencia, las atenciones solicitadas se construyen desde Indicaciones, una entidad del microservicio HLTH.

  Cuando un clínico indica un procedimiento quirúrgico de urgencia para un paciente, la nueva lista toma esa Indicación y la adapta al modelo de atención quirúrgica. Así se utiliza la entidad clínica existente para representar la solicitud, sin crear otra entidad para modelar la misma información. Desde el estado solicitado, el usuario puede aceptar la orden y continuar el flujo operativo.

  === Flujo electivo

  En el flujo electivo, la entrada principal es una orden proveniente de Gestión Hospitales. Esta aplicación registra la programación quirúrgica electiva en una base de datos anterior, con estructuras distintas a las de los microservicios actuales. Para incorporarla al nuevo flujo se diseñó un endpoint de importación que transforma órdenes de procedimientos en citas del microservicio Agenda.

  La importación lee las órdenes que deben operarse durante el día y que aún no han sido importadas. Luego adapta datos como paciente, cirujano, programación, pabellón, intervención, diagnóstico y modalidad de atención, y crea citas de Agenda con esa información.

  Como la importación se ejecuta por día, se mantuvo el mecanismo operacional usado previamente: un script programado se ejecuta cada mañana y llama al endpoint con la información de los pacientes a importar. Es una solución simple y adecuada para el flujo electivo, porque deja disponibles las cirugías programadas antes del inicio de la operación diaria.

  == Modelo unificado de atención quirúrgica

  La lista de trabajo construye una atención quirúrgica de frontend a partir de tres entidades: `Indication`, `Appointment` y `PatientService`. Cada una pertenece a un servicio distinto y representa una parte diferente del flujo.

  Como se explicó en @sec-backend-microservicios, estas entidades pueden incorporar información contextual mediante `extendedData`. El diseño aprovecha esa capacidad para guardar variables propias del flujo quirúrgico sin alterar los atributos generales de cada entidad. Entre esas variables están los datos de programación, intervenciones, diagnósticos, responsable, origen del caso, estado operacional e hitos de pabellón.

  === Indication: solicitudes de urgencia

  `Indication` pertenece a HLTH y se usa para representar atenciones solicitadas. La grilla consulta indicaciones en estado 'Indicada' de la categoría 'Intervención en pabellón'. Esa categoría agrupa los tipos 'Electiva ambulatoria', 'Electiva' y 'Urgencia'.

  En la lista de trabajo, estas indicaciones se muestran en el estado 'Solicitada'. El adaptador toma el paciente, la ubicación, el clínico solicitante, la especialidad y la información quirúrgica almacenada en `extendedData`, como intervención, diagnósticos y tiempo operatorio.

  Cuando la orden se acepta, la indicación pasa al estado 'En Curso' y deja de mostrarse en la lista. Desde ese punto, la cita quirúrgica creada pasa a ser la entidad utilizada por el flujo.

  === Appointment: programaciones quirúrgicas

  `Appointment` pertenece a Agenda y representa cirugías programadas. La grilla consulta citas agendadas de tipo quirúrgico, tanto electivas como de urgencia. En esta etapa son relevantes los estados 'Programada' y 'En espera'.

  La cita concentra la información de programación: fecha, pabellón, paciente, clínico responsable, tipo de intervención y referencias al origen. En su `extendedData.pabellon` se almacena información propia del flujo quirúrgico, como datos de creación, intervenciones, diagnósticos, tiempo operatorio y estado operacional cuando corresponde.

  La cita se utiliza mientras el caso se mantiene como programación o espera de ingreso al flujo operativo. Cuando el caso pasa a 'Preoperatorio', la entidad principal del flujo pasa a ser `PatientService`.

  === PatientService: atención quirúrgica iniciada

  `PatientService` pertenece a HLTH y representa la atención del paciente desde preoperatorio en adelante. Es la entidad más relevante del caso iniciado, porque concentra ubicación, programación, responsable, intervenciones, diagnósticos, ubicación de origen, datos de creación y estado operacional.

  La propiedad `stateKey` guarda el estado que utiliza el frontend para conocer la etapa actual del proceso. Las evaluaciones generadas durante el flujo también quedan relacionadas con esta atención, incluyendo evaluación preanestésica, pausas quirúrgicas, protocolo quirúrgico y alta quirúrgica.

  Los hitos temporales de pabellón también se registran en el `extendedData` de `PatientService` a medida que el caso avanza. Los hitos principales son entrada a pabellón, inicio de anestesia, inicio de cirugía, fin de cirugía, fin de anestesia e inicio de recuperación. Estos datos permiten mostrar tiempos relevantes durante la intervención y reutilizarlos luego en documentos clínicos como el protocolo quirúrgico.

  Para obtener estas entidades se utilizan APIs y filtros disponibles en los microservicios, de modo que cada fuente entregue casos en los estados relevantes para la lista de trabajo. El capítulo de implementación detalla cómo se obtienen esos datos y cómo se unifican en una sola atención quirúrgica para la grilla.

  == Diseño frontend, estados y acciones

  El frontend se diseñó como un conjunto de tres aplicaciones complementarias, cada una orientada a un uso distinto del proceso quirúrgico. La decisión de separarlas evita concentrar en una sola pantalla necesidades que tienen audiencias y niveles de detalle diferentes: operación clínica, coordinación interna de pabellones e información para familiares.

  La primera aplicación es la vista operativa de pabellón. Esta se diseñó como una especialización de la aplicación base de listas de trabajo descrita en la @sec-arquitectura-frontend. La estructura común aporta navegación, filtros, grilla y paneles; la lógica quirúrgica queda concentrada en el plugin `surgical_process`.

  El diseño de esta aplicación usa dos plugins. `standard` aporta modelos y componentes comunes para listas de trabajo, como paciente, clínicos, ubicaciones, admisión y secciones reutilizables de formularios. `surgical_process` define los módulos del flujo quirúrgico, la carga de datos, la adaptación de casos, los componentes de lista, los estados, las acciones, los formularios propios y las suscripciones a eventos.

  En la aplicación de pabellón se definen dos módulos. *Atención quirúrgica* muestra los casos activos del flujo diario de pabellón y permite ejecutar acciones. *Atenciones anteriores* permite consultar casos finalizados o suspendidos y revisar documentos clínicos registrados. Cada módulo monta componentes sobre los espacios provistos por la worklist: banner, barra de filtros y grilla. La grilla prioriza información operacional: paciente, documento, ubicación, especialidad, intervenciones, programación, estado y acciones disponibles. Los estilos e íconos se ubican en la skin de la aplicación dentro de `shared`, lo que permite adaptar la interfaz al hospital sin mezclar presentación con lógica de flujo.

  La atención quirúrgica adaptada por el frontend contiene un estado, representado por una clase de estado. Como se mostró en la @fig-estados-proceso-quirurgico, cada estado corresponde a una etapa del proceso. Cada clase de estado declara las acciones disponibles para esa etapa, por lo que la lista de trabajo solo muestra acciones válidas para el caso seleccionado.

  Cada acción se modela como una clase independiente con nombre, etiqueta, visibilidad, condición de ejecución e interacción esperada. Las acciones simples se resuelven con una operación directa o la apertura de una vista existente. Las acciones complejas se delegan a orquestaciones. Un registro común ordena las acciones para priorizar las principales y agrupar las secundarias.

  La segunda aplicación es el Monitor de pabellones. Su diseño responde a una necesidad distinta: entregar visibilidad agregada sobre el uso de quirófanos. Esta aplicación se construye sobre `WebApp`, carga pabellones desde ubicaciones del área de pabellón y obtiene atenciones quirúrgicas desde atenciones clínicas y citas de Agenda. Luego agrupa la información por pabellón, separando la cirugía en curso de las cirugías programadas o próximas. Con ello, la pantalla permite identificar rápidamente qué pabellones están ocupados, cuál está disponible, qué paciente se encuentra en cada quirófano, en qué estado está la cirugía y qué atenciones siguen en la programación.

  En este monitor, los estados no se usan para habilitar acciones, sino para clasificar la información mostrada. Los estados intraoperatorios permiten identificar la cirugía en curso dentro de un pabellón, mientras que los estados de preparación y programación permiten listar próximas cirugías. La visualización incorpora tiempos relevantes, como el tiempo transcurrido desde el ingreso a pabellón y la comparación con la duración operatoria planificada cuando esa información está disponible. Por esto, el monitor funciona como una herramienta de coordinación interna y no como una interfaz de edición del caso.

  La tercera aplicación es el Monitor de pacientes, orientado a familiares o acompañantes en sala de espera. Esta aplicación también se construye sobre `WebApp`, consulta atenciones quirúrgicas y citas, y adapta los datos a un modelo reducido. A diferencia de la vista operativa, su diseño elimina acciones clínicas y restringe la información visible a datos necesarios para orientación general: nombre abreviado del paciente, estado del proceso y ubicación o etapa actual. La pantalla se presenta como una tabla de lectura, con paginación automática cuando existen más casos que los que caben en una sola vista.

  El Monitor de pacientes reutiliza los estados del flujo, pero los simplifica para un público no clínico. Por ejemplo, los estados intraoperatorios se presentan como una etapa general de pabellón, evitando exponer detalles que no aportan a la comprensión de los familiares. Esta decisión mantiene la utilidad informativa de la pantalla y al mismo tiempo reduce el riesgo de mostrar información clínica innecesaria.

  Las tres aplicaciones comparten un principio de diseño: todas dependen del mismo estado operacional del proceso quirúrgico, pero cada una lo traduce a una experiencia distinta. La aplicación de pabellón permite operar; el Monitor de pabellones permite coordinar; y el Monitor de pacientes permite informar. Esta separación mantiene la coherencia del flujo y evita duplicar reglas clínicas, pero permite ajustar componentes, columnas, filtros y nivel de detalle según el usuario al que se dirige cada pantalla.

  == Formularios y documentos clínicos <sec-diseno-formularios-documentos-clinicos>

  El flujo quirúrgico requiere formularios con distintos niveles de complejidad. Por eso, el diseño usa tres mecanismos según el tipo de información que se debe registrar.

  Los formularios propios del plugin se usan cuando la interacción pertenece solo al flujo quirúrgico y requiere comportamiento específico de la lista de trabajo. Un caso de este tipo es la recepción del paciente, que opera con datos del caso y selección de ubicación dentro del contexto de pabellón.

  Los formularios tipo checklist se usan para registros simples basados en preguntas, opciones y observaciones. Este mecanismo resulta adecuado para pausas quirúrgicas y cuidados intraoperatorios, porque permite guardar respuestas estructuradas con menor costo de desarrollo.

  Los formularios clínicos más completos se integran usando un componente compartido de `shared` para cargar evaluaciones de EHR. Internamente, ese componente utiliza el elemento `iframe` para cargar el formulario desde una ruta configurada; este elemento permite embeber otro documento HTML dentro del documento actual mediante una ruta `src` @W3SchoolsIframe. En la plataforma este mecanismo ya existía: los formularios se configuran por base de datos mediante configuraciones JSON que definen la ruta, parámetros y comportamiento de carga. En el módulo quirúrgico se reutilizó para documentos que pertenecen directamente a la ficha clínica del paciente, como evaluación preanestésica y protocolo quirúrgico. Con esta separación, cada formulario usa el mecanismo más adecuado para su complejidad y para el lugar donde debe persistirse la información.

  == Diseño del orquestador dinámico

  Las acciones complejas del flujo se diseñaron como orquestaciones dinámicas. En este contexto, una orquestación ejecuta una lista de actividades en orden, usando parámetros de entrada, respuestas previas y condiciones de ejecución. Ejemplos de este tipo son aceptar una orden, recepcionar un paciente, finalizar recuperación o suspender una cirugía.

  El punto de entrada es BPM y la ejecución durable se apoya en Temporal. Sobre esa base, el orquestador dinámico interpreta una definición configurada con validaciones, llamadas HTTP, asignaciones, condiciones y transformaciones de datos. Así, una acción visible para el usuario puede ejecutarse como una secuencia controlada de operaciones.

  El inicio de una orquestación puede venir desde una acción de usuario en la lista de trabajo o desde una automatización basada en eventos. En ambos casos, BPM recibe el identificador de la orquestación y los parámetros de negocio, instancia el workflow correspondiente y delega la ejecución al worker de Temporal. Como se observa en la @fig-inicio-orquestacion-dinamica, el frontend y las automatizaciones solicitan el inicio a la capa de procesos, que queda a cargo de ejecutar la secuencia completa.

  #figure(
    image("./imagenes/inicio_e_instanciacion_de _a_orquestacion.drawio.png", width: 100%),
    caption: [Inicio e instanciación de una orquestación dinámica desde una acción de usuario o una automatización basada en eventos.],
  ) <fig-inicio-orquestacion-dinamica>

  Este diseño entrega varias ventajas. Primero, permite reutilizar capacidades existentes: una orquestación puede llamar endpoints ya disponibles y combinarlos para construir una acción de mayor nivel. Segundo, permite ejecutar muchas actividades en una secuencia explícita, usando resultados anteriores para construir los pasos siguientes. Tercero, permite conectar microservicios distintos sin repartir la lógica del flujo entre ellos. Esta diferencia es relevante frente a una coreografía, donde cada servicio reacciona a eventos y el flujo completo queda distribuido entre varios componentes; con orquestación, el orden de ejecución queda descrito en un workflow, lo que mejora la visibilidad y depuración del proceso @NadeemM2022.

  Otra ventaja es la velocidad de desarrollo. Muchas acciones del módulo siguen patrones similares: recibir parámetros, consultar contexto, llamar uno o más servicios, actualizar entidades y registrar resultado. Definir esa secuencia como configuración permite agregar acciones nuevas con menos código específico. Además, ejecutar la secuencia en Temporal entrega un entorno más confiable que el frontend: el navegador no queda a cargo de completar varios pasos críticos y una pérdida de conexión del usuario no interrumpe por sí sola la ejecución ya iniciada.

  El diseño también tiene compromisos. La ejecución es asincrónica: cuando el frontend solicita a BPM iniciar una orquestación, la respuesta confirma la instanciación del workflow, no el término de todas sus actividades. Por eso, el diseño se apoya en eventos de dominio: cuando la orquestación actualiza citas, atenciones, traslados o evaluaciones, esos servicios emiten eventos que permiten refrescar la lista de trabajo y mostrar el resultado real de la acción.

  Otro compromiso es la ausencia de rollback automático entre operaciones independientes. Si una orquestación ejecuta varios cambios y falla entre pasos, puede quedar parcialmente ejecutada. Por eso, las definiciones deben diseñarse con operaciones seguras, condiciones de ejecución claras y pasos que puedan reintentarse o detenerse sin dejar inconsistencias difíciles de resolver. El orquestador debe poder decidir cuándo ejecutar una actividad y cuándo omitirla según el estado real del caso.

  == Eventos y actualización de la lista de trabajo

  El diseño considera que la lista de trabajo debe mantenerse sincronizada con cambios que pueden originarse en distintos servicios de la plataforma. Cuando un servicio de dominio actualiza una entidad relevante, envía un mensaje a Kafka. Kafka publica ese evento en la cola correspondiente, desde donde puede ser consumido por más de un servicio backend.

  En la @fig-diseno-eventos-lista-trabajo se observa este enfoque general. El servicio de SSE consume eventos desde Kafka, mantiene conexiones persistentes con las listas de trabajo mediante `EventSource` y reenvía cada evento solo a los canales cuyos filtros se cumplen. En paralelo, BPM Event Starter consume eventos desde Kafka, revisa sus suscripciones configuradas y decide si corresponde instanciar el workflow asociado.

  #figure(
    image("./imagenes/diagrama_diseno_eventos_1.png", width: 100%),
    caption: [Modelo conceptual de eventos para actualizar la lista de trabajo y activar coordinaciones de proceso.],
  ) <fig-diseno-eventos-lista-trabajo>

  Las listas de trabajo abren conexiones persistentes con filtros. Al abrir la conexión, cada lista indica qué eventos le interesan. Cuando el servicio de SSE recibe un evento de Kafka, revisa los canales abiertos, identifica aquellos cuyos filtros se cumplen y envía el evento solo por esos canales.

  BPM Event Starter carga suscripciones al iniciar o reiniciar y usa sus filtros para decidir si instancia el workflow configurado. Ese workflow puede corresponder a una orquestación dinámica, ya que las orquestaciones dinámicas se ejecutan como workflows de Temporal.

  Este modelo permite que un mismo evento tenga efectos distintos según sus consumidores. Para la lista de trabajo, el evento actualiza la información visible del caso. Para BPM, el evento puede activar acciones automáticas, como crear o completar tareas del protocolo quirúrgico, finalizar una atención luego de un traslado o actualizar sistemas relacionados cuando se cierra el flujo.

  La motivación de este diseño es mejorar la eficiencia del flujo quirúrgico. La operación de pabellón requiere que la información visible esté actualizada cuando ocurre un cambio relevante, especialmente si ese cambio afecta el estado del paciente, su programación o las acciones disponibles. Además, el mismo mecanismo de eventos permite reaccionar automáticamente ante hitos del proceso, como la finalización de un traslado, para ejecutar coordinaciones posteriores como el cierre de atenciones de pabellón.

]

#capitulo(title: "Implementación")[
  Este capítulo describe cómo se materializó el diseño presentado anteriormente. La implementación combinó cambios en la aplicación frontend, ajustes en microservicios existentes, configuraciones de datos, integración con Gestión Hospitales, uso de BPM y Temporal, definición de orquestaciones dinámicas y suscripciones a eventos. El objetivo no fue construir un sistema aislado, sino incorporar el nuevo flujo quirúrgico dentro de la arquitectura vigente de la Plataforma Lahuén.

  La implementación se realizó de manera incremental. Primero se construyó una lista de trabajo capaz de mostrar casos quirúrgicos desde fuentes distintas. Luego se agregaron acciones clínicas y operacionales, se integraron formularios, se incorporaron eventos para actualización de la grilla y se definieron orquestaciones para las acciones que requerían coordinar varios servicios. Finalmente, se conectó el flujo electivo con Gestión Hospitales y Agenda, permitiendo que las programaciones quirúrgicas ingresaran al nuevo módulo.

  == Implementación de la aplicación de proceso quirúrgico

  Esta sección describe la implementación frontend de la aplicación de proceso quirúrgico. La aplicación corresponde a una lista de trabajo operativa de pabellón, construida sobre la arquitectura de worklists de la plataforma y especializada mediante el plugin `surgical_process`. En ella se concentra la visualización diaria de solicitudes, programaciones y atenciones quirúrgicas, junto con los elementos visuales necesarios para operar el flujo desde pabellón.

  === Modelo unificado de atención quirúrgica <sec-impl-modelo-unificado-atencion-qx>

  `AtencionQuirurgica` implementa el contrato común que usa la aplicación para operar casos quirúrgicos provenientes de HLTH, Agenda o `PatientService`. La clase normaliza entidades de origen distintas en una estructura estable para grilla, filtros, estados, acciones y formularios de la aplicación de proceso quirúrgico.

  La @fig-clase-atencion-qx muestra la estructura implementada. `AtencionQuirurgica` actúa como agregado frontend: contiene datos del paciente, submodelos clínico-operacionales, referencias de trazabilidad y una instancia de `EstadoBase` que resuelve comportamiento dependiente del estado.

  #figure(
    image("./imagenes/cap06-DiagramaDeClaseAtencionQx.png", width: 95%),
    caption: [Diagrama de clases del modelo unificado de atención quirúrgica implementado en la aplicación de proceso quirúrgico.],
  ) <fig-clase-atencion-qx>

  El modelo se divide en subclases para aislar reglas de normalización. `Patient` se reutiliza desde el módulo estándar y adapta pacientes de HLTH o participantes de Agenda mediante `loadHLTHRaw` y `loadAgendaRaw`, evitando duplicar reglas de identificación y formato de nombres. `DatosIntervenciones` encapsula intervenciones, diagnósticos y tiempo operatorio; filtra registros incompletos, conserva campos mínimos para operación y normaliza la duración como número positivo o `null`, porque esos datos pueden venir desde indicaciones, citas o atenciones clínicas. `DatosEvaluaciones` adapta evaluaciones HLTH, filtra tipos válidos del proceso quirúrgico y centraliza consultas por tipo, borradores, evaluaciones válidas y signos vitales; esto permite que estados y acciones dependan de documentos clínicos existentes sin recorrer respuestas crudas de HLTH. `PausasQuirurgicas` deriva desde `DatosEvaluaciones` si las tres pausas quirúrgicas existen y calcula la siguiente pausa pendiente, usando como fuente el registro clínico ya almacenado en HLTH.

  La clase también mantiene metadatos de trazabilidad. `externalReference` guarda un identificador de relación con otra entidad cuando la fuente lo requiere; en citas de Agenda corresponde a la referencia externa usada para vincular la cita con entidades de otros servicios, mientras que en indicaciones y `PatientService` se completa con el identificador propio de la entidad adaptada. `origenCarga` registra la entidad desde la cual se construyó la atención, su identificador, la atención `PatientService` relacionada, el `careManager` y la ubicación de referencia cuando corresponde; `datosCreacion` conserva vínculos usados para reconstruir cómo se creó el caso, como la indicación, la cita o el `PatientService` original. Estas propiedades permiten ejecutar acciones posteriores sin que la grilla conozca si la operación debe actuar sobre Agenda, HLTH o sobre datos extendidos de pabellón.

  La información operacional se mantiene en propiedades explícitas. `tabla` identifica el origen funcional de la atención: `electiva` para casos que ingresan desde Gestión Hospitales y `urgencia` para casos generados desde una indicación quirúrgica. Esta distinción permite aplicar reglas distintas de construcción, admisión y estado inicial. `programacion` almacena fecha, término y ubicación programada con fechas `DateTime` válidas; `ubicacion` normaliza la ubicación HLTH actual del paciente; `especialidad`, `responsable`, `service`, `crmId` y `esCma` alimentan columnas y reglas de operación; `extendedData` conserva el bloque de pabellón persistido para que las acciones reutilicen datos sin reinterpretar la entidad original.

  Los getters evitan repetir lógica en componentes y acciones. `patientService` entrega una referencia segura a la atención clínica solo cuando corresponde; en otros orígenes retorna un objeto vacío con forma conocida. `seRealizoEvaluacionPreAnestesica` y `seRealizoProtocoloQx` consultan `DatosEvaluaciones` para habilitar o restringir operaciones según documentos clínicos registrados.

  La construcción de instancias se concentra en tres adaptadores. `adaptFromIndication` crea una atención solicitada desde HLTH, usando paciente, ubicación, `PatientService` original, intervención indicada, diagnósticos, especialidad y responsable. `adaptFromAppointment` adapta una cita de Agenda, interpreta el tipo de cita, obtiene paciente, pabellón y responsable desde participantes, carga programación e intervenciones y resuelve el estado desde `stateKey` o reglas por defecto. `adaptFromPatientService` adapta una atención clínica existente, cargando programación, ubicación vigente, evaluaciones, pausas, intervenciones, especialidad, responsable y datos extendidos; luego decide el estado efectivo considerando `stateKey`, finalización, cancelación y alta quirúrgica.

  `state` mantiene la instancia de estado operacional asociada al caso. La lógica específica de estados y acciones se describe en las subsecciones siguientes.

  Con esta estructura, cada fila de la lista de trabajo se construye desde una `AtencionQuirurgica` normalizada. Los adaptadores y submodelos concentran la integración con HLTH y Agenda, mientras los componentes visuales consumen propiedades homogéneas del modelo.

  === Modelo base de estados de atención quirúrgica

  Los estados se implementaron como clases que extienden `EstadoBase`. Cada estado conoce la instancia de `AtencionQuirurgica` asociada y define su identificador, descripción, texto complementario, estilo visual y acciones disponibles. La @fig-modelo-estados-acciones muestra la relación entre el estado base, las acciones, los registros de orden y el plugin de la lista de trabajo.

  #figure(
    image("./imagenes/cap06-modelo_estados_acciones.png", width: 95%),
    caption: [Modelo de clases utilizado para estados, acciones y registros de orden en la aplicación de proceso quirúrgico.],
  ) <fig-modelo-estados-acciones>

  El estado persistido en las entidades no se guarda como instancia de clase, sino como `stateKey` dentro de `extendedData`. Ese valor conserva la información mínima del estado, principalmente `id` y `description`, porque originalmente los estados se representaban mediante un identificador y una descripción. Para mantener esa forma de persistencia y diferenciar cada estado de manera única, cada clase de estado conserva ambos valores y `toJSON()` entrega la estructura que necesita el formateador de estado para mostrarlo con diseño en la tabla de trabajo.

  A partir de esa persistencia fue necesario implementar un mecanismo que tradujera el `stateKey` guardado en la entidad a una clase de estado de la aplicación. Para esto se implementó `RegistroEstados`, una clase que mantiene de forma global el conjunto de estados disponibles y su orden operacional. Con ese registro, la lista de trabajo puede obtener el orden de un estado para ordenar filas según la secuencia del flujo quirúrgico, y también puede instanciar el estado específico de una fila usando el `stateKey` recibido desde `extendedData`.

  `EstadoBase` concentra el contrato común de los estados. La clase expone `id`, `description`, `text` y `textClass`, y mantiene una referencia a la atención quirúrgica asociada. `text` y `textClass` se agregaron para que algunos estados puedan mostrar un mensaje adicional en la tabla de trabajo. Con esto se implementó, por ejemplo, la visualización de un aviso cuando el protocolo quirúrgico sigue pendiente y la atención ya se encuentra en etapas finales.

  Los estados que representan hitos relevantes del flujo también exponen `nombreHito`. Esta propiedad permite registrar el momento en que comienza un hito de pabellón: cuando una atención avanza de estado, la acción que realiza el cambio puede usar `nombreHito` junto con la fecha actual para guardar el inicio de ese hito en los datos de la atención.

  El estado también centraliza el manejo de acciones mediante `setActions()`. Cada estado declara las acciones que pueden aplicar a esa etapa del flujo; luego inyecta la instancia del plugin, ordena las acciones con `RegistroAcciones`, descarta las que no cumplen `canExecute()` y construye el mapa que recibe la fila. Esta centralización es relevante porque la lista de trabajo tiene muchas acciones posibles, pero solo tres espacios visuales para acciones con ícono. El estado que contiene las acciones muestra las tres primeras acciones más relevantes y mantiene colapsadas las restantes como acciones secundarias.

  === Modelo base de acciones de atención quirúrgica <sec-modelo-base-acciones-atencion-quirurgica>

  Las acciones se implementaron como clases derivadas de `AccionBase`, según la estructura mostrada en la @fig-modelo-estados-acciones. Cada instancia mantiene una referencia al estado que la creó y, por medio de ese estado, accede a la `AtencionQuirurgica` sobre la cual opera. La clase base define el contrato común de una acción: nombre interno, etiqueta visible, tooltip, visibilidad, condición de ejecución, inicio de ejecución, confirmación y despacho de eventos hacia el plugin.

  La disponibilidad de una acción se determina en dos niveles. El primero es el estado operacional: una acción solo puede aparecer si el estado actual la declaró dentro de sus acciones posibles mediante `setActions()`, como se describió en la sección anterior. Esto representa las operaciones que tienen sentido para una etapa del flujo quirúrgico.

  El segundo nivel corresponde a las condiciones propias de la acción. Para esto se implementó `canExecute()`, que permite decidir si una acción declarada por el estado debe mostrarse efectivamente para una atención específica. Esta comprobación usa los datos de la `AtencionQuirurgica` y permite ocultar acciones cuando faltan condiciones necesarias, como información de traslado, evaluaciones requeridas o datos específicos en `extendedData`. De esta forma, los estados definen el conjunto posible de acciones y cada acción decide si cumple las condiciones para quedar disponible en la fila.

  El flujo de ejecución se implementó en dos fases. `trigger()` inicia la acción y controla la interacción inicial con la interfaz. Su responsabilidad es preparar la operación, solicitar datos cuando corresponde y delegar al plugin la apertura del componente necesario. `commit()` ejecuta la operación confirmada con los datos ya capturados y con el usuario de sesión agregado por el plugin. Para coordinar ambas fases, los componentes emiten `surgical_process:commit_action`; el plugin recibe ese evento y llama a `action.commit(data, { sessionUser })`. Así, la acción conserva la lógica de negocio de la operación, mientras el plugin actúa como intermediario para ejecutar efectos sobre la aplicación, servicios y formularios.

  `dispatchEvent()` recibe el nombre del evento y su carga útil, y delega la llamada en la instancia del plugin asociada a la acción. Se usa para enviar al `WorklistSurgicalProcessPlugin` la instrucción que debe ejecutarse y los datos necesarios para resolverla. El plugin atiende esos eventos con las funciones registradas en `worklistInit()` para manejarlos.

  === Módulo de atención quirúrgica

  El módulo de atención quirúrgica corresponde a la vista operativa principal de la aplicación. En este módulo se muestran los casos activos o próximos del flujo diario de pabellón, provenientes de indicaciones quirúrgicas, citas de Agenda y atenciones clínicas. Su objetivo es concentrar en una misma grilla los casos que requieren seguimiento operacional durante la jornada.

  La @fig-vista-pabellon-dev-1 muestra la aplicación de pabellón en el módulo de atención quirúrgica. La navegación lateral, el encabezado institucional y la estructura base de la pantalla provienen de la worklist genérica. La implementación específica del módulo define el título de la vista, el banner, los filtros, las columnas de la tabla y la información que se obtiene para poblarla.

  #figure(
    image("./imagenes/vista-pabellon-dev-1.png", width: 100%),
    caption: [Aplicación de pabellón en el módulo de atención quirúrgica.],
  ) <fig-vista-pabellon-dev-1>

  La ruta `atencion_quirurgica` monta tres componentes principales sobre la worklist: el banner de pabellón, la barra de filtros `CPatientsFilterbar` y la grilla `CPatientsGrid`. El comportamiento general de filtros y tabla es provisto por la infraestructura común de worklists, incluyendo renderizado, estados de carga, mensajes sin resultados, ordenamiento y ejecución de acciones. La implementación quirúrgica define qué filtros existen y qué columnas se muestran. La información que consume la grilla ya viene adaptada desde el modelo `AtencionQuirurgica`, por lo que cada columna puede leer datos normalizados de paciente, programación, ubicación, intervenciones, estado y acciones sin procesar directamente respuestas de HLTH o Agenda.

  En este módulo, la barra de filtros permite acotar la vista por sector y por fecha de programación. El filtro de sector está construido a partir de las áreas operacionales CMA, Pabellón y Recuperación, mientras que el filtro de fecha permite revisar la programación quirúrgica de un día específico.

  La grilla de este módulo muestra la información operacional necesaria para coordinar el flujo activo. Las columnas visibles son:

  - *Documento*: muestra el documento de identificación del paciente.
  - *Nombre*: muestra el nombre completo del paciente y el nombre social si existe.
  - *Edad*: calcula la edad a partir de la fecha de nacimiento del paciente.
  - *Especialidad*: muestra la especialidad de la intervención que se realizará.
  - *Intervención(es)*: muestra primero las intervenciones asociadas al caso, que corresponden a la información quirúrgica principal, y luego los diagnósticos principales del paciente como información secundaria en gris.
  - *Programación*: agrupa en una misma celda el nombre abreviado del clínico responsable, la fecha programada y el pabellón donde se programó la intervención. Si la intervención corresponde al día actual, la fecha se muestra como hora; si corresponde a otro día, se muestra también el día de la intervención.
  - *Ubicación*: muestra el área y cupo actual del paciente. Esta columna permite identificar rápidamente la ubicación del paciente dentro del flujo clínico-operacional.
  - *Estado*: muestra la descripción del estado actual con el estilo estándar de estados y el color definido por la empresa para cada estado.
  - *Acciones*: muestra las acciones disponibles para la fila. Las acciones expuestas se presentan como íconos visibles; las acciones no expuestas se muestran al presionar los tres puntos del final como un listado con la descripción de cada acción.

  Todas las filas de la tabla se construyen usando el modelo común `AtencionQuirurgica`, detallado en la @sec-impl-modelo-unificado-atencion-qx.

  === Obtención y adaptación de datos de atención quirúrgica

  La carga de datos del módulo principal se implementó en `fetchAtencionesQuirurgicas`. Este método recibe los criterios activos de la lista de trabajo y construye filtros específicos para cada fuente de datos: atenciones quirúrgicas activas de HLTH, indicaciones quirúrgicas de HLTH, citas quirúrgicas de Agenda y atenciones finalizadas con protocolo quirúrgico pendiente. Para ello se implementaron funciones adaptadoras de filtros, que combinan los filtros seleccionados por el usuario con los filtros que siempre aplica el módulo para buscar datos quirúrgicos.

  El filtro de fecha se usa como fecha operacional de búsqueda. Cuando existe una fecha válida, las consultas se acotan al día seleccionado: las atenciones `PatientService` se solicitan con `date`, las indicaciones con un rango diario en `timeRange` y las citas de Agenda con `scheduledStartDate`. Cuando no se selecciona fecha, la lista consulta una ventana reciente para evitar cargar todo el histórico: las atenciones activas, indicaciones y citas se buscan desde los últimos `SURGICAL_CARE_MAX_AGE_DAYS`, mientras que las atenciones finalizadas con protocolo pendiente usan una ventana más acotada desde el día anterior.

  El filtro de sector se traduce a `areaId` para las consultas de atenciones `PatientService`. Cuando existe filtro de área, el método consulta solo atenciones clínicas abiertas, porque son las entidades que tienen ubicación en las áreas relevantes de pabellón. Las indicaciones y citas representan casos que todavía no tienen una ubicación asociada a esas áreas, por lo que no aportan a una búsqueda por sector de pabellón. Cuando no existe filtro de área, se consultan también indicaciones activas y citas agendadas, permitiendo que la lista muestre tanto casos ya iniciados como solicitudes y programaciones pendientes de admisión.

  Los filtros implementados se mantuvieron acotados a áreas relevantes de pabellón y fecha. Se consideró incorporar filtros capaces de buscar otras ubicaciones, pero no se implementaron por la complejidad de coordinar tres entidades con modelos de consulta distintos. Filtrar simultáneamente indicaciones, citas y atenciones implica adaptar criterios entre servicios, evitar resultados inconsistentes y respetar comportamientos diferentes para un mismo filtro. Por esto, la implementación mantuvo una combinación limitada de filtros, suficiente para la operación diaria del módulo y más controlable técnicamente.

  Las consultas principales se ejecutan en paralelo. El método obtiene atenciones activas, indicaciones, citas y atenciones con protocolo pendiente; luego normaliza la forma de las respuestas para trabajar con arreglos. Las atenciones activas y pendientes se obtienen desde HLTH con tipo quirúrgico y estados configurados para el módulo. Las indicaciones se filtran por categoría quirúrgica y estado activo. Las citas se filtran por tipos de intervención quirúrgica y estado agendado, incluyendo servicio, tipo de cita y participantes necesarios para reconstruir paciente, pabellón y clínico responsable.

  Después de obtener las respuestas, cada grupo se adapta al modelo común `AtencionQuirurgica`. Las indicaciones se transforman con `adaptFromIndication`, las citas con `adaptFromAppointment` y las atenciones clínicas con `adaptFromPatientService`. La adaptación se ejecuta por registro y captura errores individualmente, de modo que un registro mal formado no impide construir el resto de la lista. El resultado final es un arreglo homogéneo de instancias `AtencionQuirurgica` que la grilla puede consumir directamente.

  Todas las filas deben mostrar una ubicación, aunque no provengan de una atención `PatientService`. En citas quirúrgicas, si el paciente tiene una programación y aún no ha sido admisionado, la ubicación se muestra como domicilio; si ya fue admisionado, se muestra como sala de espera; y si el paciente cuenta con una ubicación activa en HLTH, se debe mostrar esa ubicación. Como las citas de Agenda no incluyen la ubicación clínica vigente, `fetchAtencionesQuirurgicas` obtiene los identificadores de pacientes de citas e indicaciones y solicita a HLTH la información del paciente con un embed de su ubicación actual, si existe. Cuando se obtiene esa ubicación, la información se guarda en la `AtencionQuirurgica` creada para la fila. Esto permite mostrar casos en que el paciente ya llegó o fue hospitalizado aunque la cita no contenga esa información. En indicaciones se realiza la misma carga adicional para mantener actualizada la ubicación visible. En atenciones abiertas de pabellón esta consulta adicional no es necesaria, porque la ubicación actual ya viene en la entidad `PatientService`.

  === Módulo de atenciones anteriores

  El módulo de atenciones anteriores se implementó como una vista de consulta para casos que ya no pertenecen a la operación activa del día. Este módulo muestra atenciones `PatientService` finalizadas o canceladas.

  La @fig-vista-pabellon-dev-2 muestra la aplicación en el módulo de atenciones anteriores. Respecto del módulo operativo, cambia el título de la vista, el banner, los filtros disponibles, las columnas visibles y la información consultada para construir la tabla.

  #figure(
    image("./imagenes/vista-pabellon-dev-2.png", width: 100%),
    caption: [Aplicación de pabellón en el módulo de atenciones anteriores.],
  ) <fig-vista-pabellon-dev-2>

  La ruta `atenciones_anteriores` monta el mismo banner y la misma grilla base, pero usa la barra de filtros `CPatientsPreviousFilterbar`. A diferencia del módulo de atención quirúrgica, que está orientado a operar sobre los casos activos del día, este módulo funciona como una búsqueda histórica de atenciones cerradas.

  La tabla reutiliza el mismo componente `CPatientsGrid`, pero oculta la columna `Ubicación`. Como las atenciones mostradas ya están finalizadas o canceladas, no corresponde mostrar una ubicación actual para atenciones que no están activas. La vista muestra solo datos históricos conservados de la atención. Por la misma razón, el módulo elimina los filtros asociados a sector o ubicación y mantiene solo el filtro por fecha de programación.

  === Obtención de datos de atenciones anteriores

  La carga de atenciones anteriores se implementó en `fetchAtencionesAnteriores`. A diferencia del módulo operativo, este método exige una fecha válida antes de consultar datos; si no existe fecha, retorna una lista vacía. Con esto la búsqueda histórica queda acotada a una ventana explícita y no carga atenciones cerradas sin criterio temporal.

  El método construye un filtro histórico para `PatientService` usando el tipo de atención quirúrgica, los estados finalizada y cancelada, y la fecha seleccionada. Luego consulta HLTH y adapta los registros de la misma forma que el resto de atenciones que provienen de un `PatientService`. El método de adaptación identifica si la atención está finalizada o cancelada y devuelve la instancia de `AtencionQuirurgica` con el estado correspondiente. El resultado es la misma estructura de fila usada por el módulo principal, pero construida solo desde atenciones clínicas ya cerradas.

  == Aplicaciones de monitoreo

  Además de la lista de trabajo operativa, se implementaron dos aplicaciones de monitoreo sobre el mismo flujo quirúrgico: el Monitor de pabellones y el Monitor de pacientes. Como la versión actual dejó de utilizar instancias de workflows del motor de procesos propietario, las aplicaciones anteriores de monitoreo ya no eran compatibles con la nueva representación del proceso. Por ello, se reconstruyeron sobre la arquitectura frontend actual de Lahuén, leyendo atenciones clínicas y citas quirúrgicas desde los servicios de la plataforma.

  En ambas aplicaciones se reutilizó la barra superior de la plataforma y se agregó un componente de fecha y hora visible en la esquina superior derecha. El diseño visual de las tablas y de la estructura de los monitores se implementó a partir de diseños entregados por el líder del proyecto, complementados con recomendaciones de una persona del área de diseño. La implementación buscó replicar esos diseños con el mayor detalle posible.

  El Monitor de pabellones permite identificar rápidamente qué pabellones se están utilizando, cuáles están disponibles y cuántas atenciones hay programadas en cada pabellón. Además, muestra información relevante del procedimiento, como intervención, especialidad, tiempos programados y tiempo transcurrido, como se observa en la @fig-vista-monitor-pabellones.

  #figure(
    image("./imagenes/vista-monitor-pabellones-2.png", width: 100%),
    caption: [Monitor de pabellones.],
  ) <fig-vista-monitor-pabellones>

  El Monitor de pacientes está orientado a informar a familiares o acompañantes. Muestra una versión reducida de la atención quirúrgica, limitada al nombre visible del paciente, su estado general y la ubicación o etapa del proceso, sin exponer acciones clínicas ni detalles operatorios, como muestra la @fig-vista-monitor-pabellones-publico.

  #figure(
    image("./imagenes/vista-monitor-pabellones-publico-2.png", width: 100%),
    caption: [Monitor de pacientes para familiares o acompañantes.],
  ) <fig-vista-monitor-pabellones-publico>

  Las dos aplicaciones se actualizan con eventos de atenciones y citas, usando el mismo enfoque de suscripciones SSE descrito para la lista de trabajo. De esta forma se obtiene la información de los pacientes y los pabellones en tiempo real.

  == Acciones implementadas en la lista de trabajo

  Las acciones se presentan en el mismo orden definido por el registro canónico de la aplicación, salvo la acción de admisión, que se documenta aquí aunque se implementó en otra aplicación. Todas las acciones propias de la aplicación de proceso quirúrgico se implementan como clases derivadas de `AccionBase`, descrita en la @sec-modelo-base-acciones-atencion-quirurgica.

  Para las acciones que modifican el estado de una atención, la interfaz solicita confirmación antes de ejecutar la operación. Esta decisión se alinea con la heurística de prevención de errores, que recomienda pedir confirmación antes de acciones potencialmente propensas a error @BaloianPino2024Usabilidad. Además, una vez ejecutada la acción, la aplicación muestra retroalimentación explícita de éxito o fracaso, siguiendo el principio de visibilidad del estado del sistema y las recomendaciones sobre mensajes de error comprensibles @BaloianPino2024Usabilidad. La @fig-ejemplo-mensaje-exito muestra un ejemplo de confirmación visual después de egresar correctamente a un paciente.

  #figure(
    image("./imagenes/cap06-ejemplo-de-mensaje-exito.png", width: 50%),
    caption: [Mensaje de éxito mostrado después de egresar a un paciente.],
  ) <fig-ejemplo-mensaje-exito>

  === Ver ficha

  La acción `Ver ficha` permite abrir la ficha clínica asociada a la atención quirúrgica. La @fig-accion-ver-ficha-icon muestra la acción disponible en la lista de trabajo. Como esta acción solo abre una vista y no modifica datos, su implementación se resuelve en `trigger()` y no define el método `commit`: obtiene la atención quirúrgica, resuelve el `PatientService` que debe usarse para abrir la ficha y emite `surgical_process:view_patient_profile` con ambos datos.

  #figure(
    image("./imagenes/cap06-ver-ficha-icon.png", width: 30%),
    caption: [Acción para abrir la ficha clínica desde la lista de trabajo quirúrgica.],
  ) <fig-accion-ver-ficha-icon>

  La acción es común para los estados que incorporan acciones por defecto, pero solo puede ejecutarse si existe un `PatientService` disponible para abrir la ficha. `canExecute()` exige un identificador de atención y un `careManager.id`; para resolverlos, la acción prioriza la atención quirúrgica actual y, si no existe, usa la atención original almacenada en los datos de creación. Esto permite abrir la ficha cuando el paciente ya fue recepcionado o cuando el caso proviene de urgencia u hospitalización, donde existe una atención abierta relacionada. En cambio, las cirugías electivas que aún deben admisionarse no tienen una atención clínica abierta asociada, por lo que la acción no se muestra. Esta disponibilidad es útil para revisar antecedentes de la ficha mientras el paciente espera la recepción en pabellón.

  === Aceptar orden

  La acción `Aceptar orden` está declarada para el estado `Solicitada`, por lo que se muestra sobre indicaciones quirúrgicas de urgencia que aún no han sido aceptadas. La @fig-accion-aceptar-orden-icon muestra la acción disponible en la lista de trabajo. Su objetivo es programar la intervención y convertir la indicación en una cita quirúrgica operable por el resto del flujo.

  #figure(
    image("./imagenes/cap06-aceptar-orden-icon.png", width: 30%),
    caption: [Acción para aceptar una orden quirúrgica solicitada desde la lista de trabajo.],
  ) <fig-accion-aceptar-orden-icon>

  Al seleccionarla, `trigger()` abre un panel lateral mediante `surgical_process:show_action_panel`, siguiendo el mecanismo de formularios laterales definido en la @sec-diseno-formularios-documentos-clinicos. En ese panel se carga `CFormProcesoQuirurgicoProgramarIntervencion`, como se observa en la @fig-accion-aceptar-orden. La sección de información del paciente se reutiliza desde el plugin `standard`; el resto del formulario recibe desde la `AtencionQuirurgica` las intervenciones y el tiempo operatorio estimado. Con esos datos permite seleccionar el pabellón y la fecha de inicio de la intervención.

  #figure(
    image("./imagenes/cap06-aceptar-orden.png", width: 100%),
    caption: [Panel para programar la intervención al aceptar una orden quirúrgica de urgencia.],
  ) <fig-accion-aceptar-orden>

  Al confirmar, el método `commit` construye el cuerpo de la orquestación con el usuario ejecutor, la fecha de inicio, el pabellón seleccionado, el identificador de la indicación y los diagnósticos exportados desde los datos de intervención. Luego emite `surgical_process:execute_panel_action` con la acción API `bpm.postDynamicOrchestration` y el identificador de la orquestación de aceptación de orden de urgencia. La operación se confirma como acción asíncrona y no fuerza la actualización inmediata de la grilla; la actualización queda asociada a los eventos emitidos por los servicios involucrados. La secuencia backend que crea la cita y marca la indicación como iniciada se describe en la @sec-orquestacion-aceptar-orden-urgencia.

  === Recepcionar paciente

  La acción `Recepcionar paciente` se muestra sobre atenciones quirúrgicas que ya pasaron por admisión y quedaron en estado `En espera`. La @fig-accion-recepcionar-paciente-icon muestra la acción disponible en la lista de trabajo. Esta acción registra el ingreso operacional del paciente a una ubicación de la unidad quirúrgica.

  #figure(
    image("./imagenes/cap06-recepcion-paciente-icon.png", width: 30%),
    caption: [Acción para recepcionar al paciente desde la lista de trabajo quirúrgica.],
  ) <fig-accion-recepcionar-paciente-icon>

  Al seleccionarla, `trigger()` abre un panel lateral mediante `surgical_process:show_action_panel` y carga `CFormProcesoQuirurgicoCambiarUbicacionPaciente`, como se observa en la @fig-accion-recepcionar-paciente. La sección de información del paciente se reutiliza desde el plugin `standard`; el resto del formulario recibe la `AtencionQuirurgica` y permite seleccionar la ubicación de destino. Para esta acción se habilitaron como sectores posibles CMA y Recuperación, usando un filtro de ubicaciones restringido a esas áreas, y la etiqueta de confirmación del panel se configuró como `Ingresar`.

  #figure(
    image("./imagenes/cap06-recepcion-paciente.png", width: 100%),
    caption: [Panel de recepción de paciente, con selección de sector y ubicación de destino.],
  ) <fig-accion-recepcionar-paciente>

  Al confirmar, el método `commit` construye el cuerpo de la orquestación con `appointmentId`, `locationId`, `locationDescription`, `username`, `tabla` y `patientId`. Luego emite `surgical_process:execute_panel_action` con la acción API `bpm.postDynamicOrchestration` y el identificador de la orquestación de recepción. La acción se ejecuta como confirmación asíncrona y espera antes de resolver para dar tiempo a que se completen los cambios y eventos asociados. La secuencia backend que deriva entre flujo electivo y de urgencia se describe en la @sec-orquestacion-recepcionar-paciente.

  === Ingresar a Pabellón

  La acción `Ingresar a Pabellón` se muestra en estado `Preoperatorio` y permite pasar al paciente desde la ubicación preparatoria al quirófano donde se realizará la intervención. La @fig-accion-ingresar-a-pabellon-icon muestra el ícono de la acción.

  #figure(
    image("./imagenes/cap06-accion-ingresar-a-pabellon-icon.png", width: 30%),
    caption: [Acción para ingresar al paciente a pabellón desde la lista de trabajo quirúrgica.],
  ) <fig-accion-ingresar-a-pabellon-icon>

  Al seleccionarla, `trigger()` abre un panel lateral con `CFormProcesoQuirurgicoCambiarUbicacionPaciente`, reutilizando la información del paciente desde `standard` y mostrando el sector `Pabellón` con su ubicación correspondiente, como se observa en la @fig-accion-ingresar-a-pabellon. El pabellón se precarga con el programado, pero el usuario puede seleccionar otro cuando la operación finalmente se realice en un quirófano distinto.

  #figure(
    image("./imagenes/cap06-accion-ingresar-a-pabellon.png", width: 100%),
    caption: [Panel para ingresar al paciente a pabellón.],
  ) <fig-accion-ingresar-a-pabellon>

  El método `commit` ejecuta la acción API `hlth.patchPatientServiceChangeLocation`, que llama al endpoint de HLTH para cambiar la ubicación del paciente al pabellón seleccionado. Esta operación aprovecha la funcionalidad descrita en la @sec-hlth-atencion-quirurgica-ubicacion-datos-extendidos, que permite actualizar el `extendedData` de la atención en el mismo momento en que se produce el cambio de ubicación. Gracias a esto, además del movimiento del paciente, la acción registra el hito de ingreso a pabellón con la fecha y hora actuales; guarda en `extendedData.pabellon.programacion.ubicacionUtilizada` el pabellón efectivamente utilizado, que puede diferir del programado y se requiere para reportes; conserva en `extendedData.pabellon.ubicacionPreOperatoria` la ubicación anterior para poder revertir un ingreso accidental; y actualiza `stateKey` al estado `EstadoEnQuirofanoEntrada`, de modo que el caso queda listo para continuar con los hitos intraoperatorios.

  === Continuar cirugía

  La acción `Continuar cirugía` agrupa el avance de los hitos intraoperatorios del proceso quirúrgico. Se trata de una misma clase de acción parametrizada que se instancia de forma distinta en cada estado intraoperatorio, por lo que su etiqueta visible cambia según la etapa actual: `Iniciar anestesia` cuando el paciente acaba de ingresar a pabellón, `Iniciar cirugía` cuando la anestesia ya comenzó, `Finalizar cirugía` cuando la intervención está en curso y `Finalizar anestesia` cuando la cirugía ya terminó. La @fig-accion-continuar-cirugia-icon muestra el ícono de la acción en estado `Anestesia iniciada`, donde la etiqueta corresponde a `Iniciar cirugía`.

  #figure(
    image("./imagenes/cap06-accion-continuar-cirugia-icon.png", width: 30%),
    caption: [Acción `Continuar cirugía` mostrada como `Iniciar cirugía` en estado `Anestesia iniciada`.],
  ) <fig-accion-continuar-cirugia-icon>

  `trigger()` abre un panel lateral con `CFormProcesoQuirurgicoContinuarCirugia`. El formulario muestra la información del paciente, los datos de programación de la intervención y una sección denominada `Hitos del proceso`, que presenta una línea de tiempo con las etapas intraoperatorias: recepción en pabellón, anestesia iniciada, cirugía iniciada, cirugía finalizada y anestesia finalizada. El hito que corresponde al estado actual se resalta, mientras que los hitos ya completados muestran su fecha y hora de registro, y los hitos pendientes aparecen deshabilitados. Esta visualización permite al equipo confirmar en qué momento del proceso se encuentra el paciente antes de avanzar. Además, el panel muestra el tiempo transcurrido de la intervención y el tiempo total en pabellón, como se observa en la @fig-accion-continuar-cirugia.

  #figure(
    image("./imagenes/cap06-accion-continuar-cirugia.png", width: 100%),
    caption: [Panel de `Continuar cirugía` con los hitos del proceso y la etapa actual resaltada.],
  ) <fig-accion-continuar-cirugia>

  El método `commit` actualiza el `extendedData` de la atención mediante `hlth.patchPatientServiceExtendedData`, registrando la fecha y hora actuales en el hito que corresponde al siguiente estado y actualizando el `stateKey`. Después de cada avance, excepto tras `Finalizar anestesia`, la acción vuelve a abrir automáticamente el formulario para permitir que el equipo registre los hitos de forma continua sin tener que volver a seleccionar la acción en la grilla. Así, una sola clase de acción coordina todo el avance intraoperatorio, adaptando su etiqueta y su hito objetivo al estado en que se encuentre la atención.

  === Iniciar recuperación

  La acción `Iniciar recuperación` se muestra cuando el paciente ha finalizado la etapa intraoperatoria y debe trasladarse desde el pabellón a una ubicación de recuperación. La @fig-accion-iniciar-recu-icon muestra el ícono de la acción disponible en la lista de trabajo.

  #figure(
    image("./imagenes/cap06-accion-iniciar-recu-icon.png", width: 30%),
    caption: [Acción para iniciar la recuperación del paciente desde la lista de trabajo quirúrgica.],
  ) <fig-accion-iniciar-recu-icon>

  Al seleccionarla, `trigger()` abre un panel lateral con `CFormProcesoQuirurgicoCambiarUbicacionPaciente`, reutilizando la información del paciente desde `standard` y mostrando el sector `Recuperación` con su ubicación correspondiente, como se observa en la @fig-accion-iniciar-recu.

  #figure(
    image("./imagenes/cap06-accion-iniciar-recu.png", width: 100%),
    caption: [Panel para iniciar la recuperación del paciente.],
  ) <fig-accion-iniciar-recu>

  El método `commit` ejecuta la acción API `hlth.patchPatientServiceChangeLocation`, que llama al endpoint de HLTH para cambiar la ubicación del paciente a la ubicación de recuperación seleccionada. Al igual que en el ingreso a pabellón, esta operación aprovecha la funcionalidad descrita en la @sec-hlth-atencion-quirurgica-ubicacion-datos-extendidos, que permite actualizar el `extendedData` de la atención en el mismo momento del cambio de ubicación. Con esto, además del movimiento del paciente, la acción registra el hito de inicio de recuperación con la fecha y hora actuales y actualiza `stateKey` al estado `EstadoEnRecuperacion`, de modo que el caso queda listo para finalizar la recuperación una vez que el paciente esté en condiciones de continuar su egreso o traslado.

  === Finalizar recuperación

  La acción `Finalizar recuperación` permite cerrar la etapa de recuperación del paciente una vez que ya no requiere permanecer en esa unidad. Se muestra sobre atenciones en estado `En recuperación` y, al seleccionarla, despliega un diálogo de confirmación con el nombre del paciente.

  #figure(
    image("./imagenes/cap06-accion-finalizar-recuperacion-icon.png", width: 30%),
    caption: [Acción para finalizar la recuperación desde la lista de trabajo quirúrgica.],
  ) <fig-accion-finalizar-recuperacion-icon>

  El diálogo no pide datos adicionales: solo confirma la acción antes de ejecutarla, como muestra la @fig-accion-finalizar-recuperacion. Al aceptar, el método `commit` instancia la orquestación de finalizar recuperación. Esa orquestación decide en qué estado dejar la atención, ya sea `Esperando Alta` o `Esperando traslado`, según la situación del paciente. Cuando el resultado es `Esperando traslado`, además conserva la referencia al traslado activo para que esa información pueda reutilizarse en el frontend.

  #figure(
    image("./imagenes/cap06-accion-finalizar-recuperacion.png", width: 50%),
    caption: [Confirmación para finalizar la recuperación del paciente.],
  ) <fig-accion-finalizar-recuperacion>

  === Iniciar traslado

  La acción `Iniciar traslado` permite dar comienzo al traslado del paciente cuando ya no debe permanecer en pabellón o en recuperación. Se muestra solo si la atención tiene un traslado asociado pendiente, y se presenta como acción secundaria en la lista de trabajo, como muestra la @fig-accion-iniciar-traslado-icon.

  #figure(
    image("./imagenes/cap06-accion-iniciar-traslado-icon.png", width: 30%),
    caption: [Acción para iniciar el traslado del paciente desde la lista de trabajo quirúrgica.],
  ) <fig-accion-iniciar-traslado-icon>

  Al seleccionarla, `trigger()` abre un diálogo de confirmación con el destino del traslado, como se observa en la @fig-accion-iniciar-traslado. El mensaje solo pide validar la operación antes de ejecutarla y no solicita información adicional.

  #figure(
    image("./imagenes/cap06-accion-iniciar-traslado.png", width: 55%),
    caption: [Confirmación para iniciar el traslado del paciente.],
  ) <fig-accion-iniciar-traslado>

  Al confirmar, el método `commit` instancia la orquestación de iniciar traslado. Esa orquestación ejecuta el movimiento del paciente, registra el hito `enTransito` y actualiza la atención al estado `En tránsito`. De esta forma, el frontend solo dispara el inicio del traslado y la lógica de transición queda concentrada en la orquestación.

  === Devolver a unidad de origen

  La acción `Devolver a unidad de origen` permite retornar al paciente a la unidad desde la que provenía. Antes de ejecutarla, muestra una confirmación con la ubicación de destino.

  #figure(
    image("./imagenes/cap06-accion-devolver-a-unidad-de-origen-icon.png", width: 30%),
    caption: [Acción para devolver al paciente a su unidad de origen.],
  ) <fig-accion-devolver-unidad-origen-icon>

  #figure(
    image("./imagenes/cap06-accion-devolver-a-unidad-de-origen.png", width: 60%),
    caption: [Confirmación para devolver al paciente a la unidad de origen.],
  ) <fig-accion-devolver-unidad-origen>

  Al aceptar, el sistema inicia la devolución, registra el traslado correspondiente y actualiza la atención para reflejar que el paciente queda en tránsito hacia su unidad de origen.

  === Egresar paciente

  La acción `Egresar paciente` ejecuta el egreso del paciente y cierra la atención. Antes de realizar el cierre, solicita confirmación al usuario.

  #figure(
    image("./imagenes/cap06-accion-egresar-pacinte-icon.png", width: 30%),
    caption: [Acción para egresar al paciente desde la lista de trabajo.],
  ) <fig-accion-egresar-paciente-icon>

  #figure(
    image("./imagenes/cap06-accion-egresar-paciente.png", width: 60%),
    caption: [Confirmación para egresar al paciente.],
  ) <fig-accion-egresar-paciente>

  Al aceptar, el sistema cierra la atención y muestra el mensaje de éxito correspondiente.

  === Cargar evaluación

  La acción `Cargar evaluación` no representa un único formulario fijo. Es una clase parametrizada por tipo de evaluación, de modo que el mismo modelo de acción puede mostrarse con etiquetas, títulos y condiciones distintas. En la implementación actual se usa para la evaluación preanestésica y el protocolo quirúrgico. Ambas comparten el mismo mecanismo de carga y se diferencian principalmente por el tipo de evaluación, el momento del flujo en que se muestran y la información clínica que registran.

  El comportamiento común de la acción es el siguiente. `canExecute()` verifica que la atención aún no tenga registrada una evaluación completa del tipo correspondiente, por lo que la acción se muestra solo si todavía no existe una evaluación de ese tipo. `trigger()` busca el último borrador existente para ese tipo de evaluación y emite `surgical_process:load_evaluation` con el tipo, el título, los identificadores del paciente, el `PatientService`, el `careManager` y el borrador cuando existe. El plugin recibe el evento y delega la carga a `loadModalEvaluation`, reutilizando el mecanismo de formularios embebidos descrito en la @sec-diseno-formularios-documentos-clinicos. El formulario se muestra dentro de un modal de paciente: a la izquierda se presenta la cápsula con datos básicos del paciente y al centro se carga el formulario clínico de EHR mediante `iframe`.

  Para la evaluación preanestésica, la acción se muestra en el estado `Preoperatorio`, antes del ingreso a pabellón, bajo la etiqueta `Evaluación preanestésica`, como se observa en la @fig-accion-eval-pre-icon. El formulario permite registrar información de la intervención, antecedentes médicos y revisión por sistemas, como muestra la @fig-accion-eval-pre.

  #figure(
    image("./imagenes/cap06-accion-eval-pre-icon.png", width: 35%),
    caption: [Acción para cargar la evaluación preanestésica en estado preoperatorio.],
  ) <fig-accion-eval-pre-icon>

  #figure(
    image("./imagenes/cap06-accion-eval-pre.png", width: 100%),
    caption: [Formulario embebido para registrar la evaluación preanestésica desde la lista de trabajo quirúrgica.],
  ) <fig-accion-eval-pre>

  Para el protocolo quirúrgico, la acción se muestra durante y después de la etapa intraoperatoria, bajo la etiqueta `Protocolo quirúrgico`, como se observa en la @fig-accion-protocolo-qx-icon. El formulario carga el documento operatorio asociado a la intervención, precargando algunos datos de la sección `Detalle de la intervención`, como muestra la @fig-accion-protocolo-qx.

  #figure(
    image("./imagenes/cap06-accion-protocolo-qx-icon.png", width: 30%),
    caption: [Acción para cargar el protocolo quirúrgico durante la etapa intraoperatoria o de recuperación.],
  ) <fig-accion-protocolo-qx-icon>

  #figure(
    image("./imagenes/cap06-accion-protocolo-qx.png", width: 100%),
    caption: [Formulario embebido para registrar el protocolo quirúrgico desde la lista de trabajo.],
  ) <fig-accion-protocolo-qx>

  En ambos casos, al finalizar el registro la evaluación queda asociada a la atención clínica del paciente y la lista de trabajo se actualiza.

  === Pausa quirúrgica

  La acción `Pausa quirúrgica` permite registrar las tres pausas de seguridad del acto quirúrgico durante la etapa intraoperatoria. Es una acción parametrizada: al instanciarse, consulta el número de la siguiente pausa pendiente de la atención y ajusta su etiqueta y su comportamiento para registrar la pausa correspondiente. Se muestra como acción secundaria en estados intraoperatorios, como se observa en la @fig-accion-pausa-qx-icon.

  #figure(
    image("./imagenes/cap06-accion-pausa-qx-icon.png", width: 30%),
    caption: [Acción para registrar una pausa quirúrgica desde la lista de trabajo.],
  ) <fig-accion-pausa-qx-icon>

  Para soportar cada pausa se configuraron tres tipos de signo vital: `Primera Pausa Quirúrgica`, `Segunda Pausa Quirúrgica` y `Tercera Pausa Quirúrgica`. Cada uno define, dentro de la escala `pausaQuirurgica`, una checklist con las verificaciones propias de su momento: antes de la inducción anestésica, antes de la incisión de la piel y antes de que el paciente abandone el pabellón. Las preguntas cubren identidad del paciente, sitio quirúrgico, consentimiento, funcionamiento de equipos, conteo de elementos, muestras biológicas y destino posterior, entre otros aspectos de seguridad.

  `trigger()` dispara `surgical_process:show_scale_form` con el nombre de la escala, el tipo de signo vital que corresponde a la pausa actual y el identificador del `PatientService`. El formulario se presenta como un modal con la información del paciente a la izquierda y las secciones de la checklist a la derecha, como muestra la @fig-accion-pausa-qx.

  #figure(
    image("./imagenes/cap06-accion-pausa-qx.png", width: 100%),
    caption: [Formulario de registro de la primera pausa quirúrgica.],
  ) <fig-accion-pausa-qx>

  La acción solo está disponible mientras exista una pausa pendiente por registrar; una vez completadas las tres, deja de mostrarse. Al guardarse, cada pausa queda asociada a la atención clínica del paciente y la lista de trabajo se actualiza para reflejar el avance del checklist de seguridad quirúrgica.

  === Cuidados intraoperatorios

  La acción `Cuidados intraoperatorios` permite registrar, durante la etapa intraoperatoria, una serie de cuidados de enfermería asociados al paciente en quirófano. Se presenta como acción secundaria dentro del menú de tres puntos cuando la atención se encuentra en estado `En pabellón`, como se observa en la @fig-accion-cuidados-intraoperatorios-icon.

  #figure(
    image("./imagenes/cap06-accion-cuidados-intraoperatorios-icon.png", width: 30%),
    caption: [Acción para registrar cuidados intraoperatorios disponible como acción secundaria.],
  ) <fig-accion-cuidados-intraoperatorios-icon>

  La acción reutiliza el mecanismo de formularios de escala o checklist de la plataforma. Para este caso se configuró un tipo de signo vital denominado `Cuidados intraoperatorios`, cuyo `vstp_abbreviation` identifica la escala y cuyos datos extendidos definen una checklist con las preguntas operacionales relevantes: riesgo de lesión por presión en pabellón, posición quirúrgica, protección de puntos de apoyo, protección ocular y limpieza de piel preoperatoria, cada una con sus opciones y, en algunos casos, campo de observaciones. El registro se guarda como una evaluación de tipo checklist asociada a la atención del paciente.

  Al ejecutarla, `trigger()` dispara `surgical_process:show_scale_form` con el identificador de la escala, el tipo de signo vital y el `patientServiceId`. El formulario se muestra como un modal con la información del paciente a la izquierda y las preguntas de la checklist a la derecha, como se observa en la @fig-accion-cuidados-intraoperatorios.

  #figure(
    image("./imagenes/cap06-accion-cuidados-intraoperatorios.png", width: 100%),
    caption: [Formulario de registro de cuidados de enfermería intraoperatorios.],
  ) <fig-accion-cuidados-intraoperatorios>

  `canExecute()` verifica que la atención aún no tenga registrado un signo vital de este tipo, de modo que la acción deja de mostrarse una vez que los cuidados intraoperatorios fueron guardados. Este comportamiento es consistente con el resto de las evaluaciones del proceso quirúrgico, que se ocultan después de ser completadas para evitar duplicidades.

  === Cambiar ubicación

  La acción `Cambiar ubicación` permite mover al paciente dentro de las ubicaciones operacionales disponibles para su etapa actual. Se declara en estados donde ya existe una atención quirúrgica con ubicación clínica, como preoperatorio, recuperación, espera de traslado o estados intraoperatorios. La acción se presenta como secundaria en el menú de tres puntos, como muestra la @fig-accion-cambiar-ubicacion-icon.

  #figure(
    image("./imagenes/cap06-cambiar-ubicacion-icon.png", width: 35%),
    caption: [Acción secundaria para cambiar la ubicación del paciente desde la lista de trabajo.],
  ) <fig-accion-cambiar-ubicacion-icon>

  Al seleccionarla, `trigger()` abre un panel lateral mediante `surgical_process:show_action_panel`. El panel carga `CFormProcesoQuirurgicoCambiarUbicacionPaciente`, como se observa en la @fig-accion-cambiar-ubicacion. La sección de información del paciente proviene del plugin `standard`; el resto del formulario usa la `AtencionQuirurgica` para restringir las áreas disponibles. Si el paciente está en pabellón, solo permite ubicaciones de pabellón; en otros casos permite CMA y Recuperación.

  #figure(
    image("./imagenes/cap06-cambiar-ubicacion.png", width: 100%),
    caption: [Panel para seleccionar una nueva ubicación del paciente.],
  ) <fig-accion-cambiar-ubicacion>

  Al confirmar, el método `commit` envía al plugin una acción `hlth.patchPatientServiceChangeLocation` con el identificador del `PatientService`, la nueva ubicación, la ruta descriptiva y el usuario ejecutor. Si la operación finaliza correctamente, la grilla se actualiza para reflejar la nueva ubicación.

  === Reagendar cirugía

  La acción `Reagendar cirugía` permite modificar la fecha, hora y pabellón de una cita quirúrgica programada. La @fig-accion-reagendar-icon muestra la acción disponible en la lista de trabajo para una atención programada.

  #figure(
    image("./imagenes/cap06-accion-reagendar-icon.png", width: 30%),
    caption: [Acción para abrir el reagendamiento de una cirugía desde la tabla de atención quirúrgica.],
  ) <fig-accion-reagendar-icon>

  La @fig-accion-reagendar muestra el formulario de reagendamiento. En él se presenta información de la atención quirúrgica, incluyendo datos del paciente, intervenciones, duración estimada, pabellón programado y fecha de intervención.

  #figure(
    image("./imagenes/cap06-accion_reagendar.png", width: 100%),
    caption: [Formulario de reagendamiento de cirugía desde la lista de trabajo de pabellón.],
  ) <fig-accion-reagendar>

  Al seleccionar la acción, `trigger()` abre un panel lateral de programación de intervención mediante `surgical_process:show_action_panel`. La sección de información del paciente proviene del plugin `standard`, mientras que los datos quirúrgicos se obtienen desde la `AtencionQuirurgica`: intervenciones, tiempo operatorio, pabellón programado y fecha de inicio programada. Esa información permite conservar el contexto de la cirugía y modificar solo la nueva programación.

  Al confirmar el formulario, el método `commit` recibe la nueva ubicación y la nueva fecha de inicio. Con esos datos construye el cuerpo de actualización de la cita: usuario ejecutor, nueva fecha `scheduledStart`, participantes actualizados y datos extendidos. En Agenda, el pabellón se representa como un participante de la cita; por ello, para cambiarlo se reconstruye y reenvía la lista completa de participantes, reemplazando el participante de pabellón por la nueva ubicación seleccionada y manteniendo el participante paciente asociado a la atención.

  La ejecución se delega al plugin mediante `surgical_process:execute_panel_action`, usando la acción API `agenda.patchAppointmentReschedule`. Esa acción termina llamando al endpoint de Agenda `PATCH /agenda/appointments/{id}/_reschedule`, donde `{id}` corresponde a la cita de origen de la atención quirúrgica. Si la operación finaliza correctamente, el panel informa la nueva fecha y pabellón, y la grilla se actualiza.

  === Revertir ingreso a Pabellón

  La acción `Revertir Ingreso a Pabellón` permite corregir un ingreso accidental al quirófano devolviendo al paciente a la etapa preoperatoria. Se presenta como acción secundaria dentro del menú de tres puntos cuando la atención se encuentra en estado `En pabellón`, como se observa en la @fig-accion-revertir-ingreso-pabellon-icon.

  #figure(
    image("./imagenes/cap06-revertir-ingreso-pabellon-icon.png", width: 30%),
    caption: [Acción para revertir el ingreso a pabellón disponible como acción secundaria.],
  ) <fig-accion-revertir-ingreso-pabellon-icon>

  Al seleccionarla, `trigger()` abre un panel lateral con `CFormProcesoQuirurgicoCambiarUbicacionPaciente`, como muestra la @fig-accion-revertir-ingreso-pabellon. El formulario precarga como ubicación de destino la `ubicacionPreOperatoria` guardada previamente al momento del ingreso, de modo que el usuario pueda devolver al paciente exactamente a donde estaba. También permite seleccionar otra ubicación de CMA o Recuperación si la situación operativa lo requiere.

  #figure(
    image("./imagenes/cap06-revertir-ingreso-pabellon.png", width: 100%),
    caption: [Panel para revertir el ingreso de un paciente a pabellón.],
  ) <fig-accion-revertir-ingreso-pabellon>

  El método `commit` ejecuta la acción API `hlth.patchPatientServiceChangeLocation`, reutilizando el mismo endpoint de cambio de ubicación pero indicando `revertLocationChange: true` para que HLTH trate el movimiento como una reversión. Aprovechando la funcionalidad descrita en la @sec-hlth-atencion-quirurgica-ubicacion-datos-extendidos, la misma operación actualiza el `extendedData` de la atención, estableciendo el `stateKey` de vuelta a `EstadoPreOperatorio`. De este modo, el paciente regresa tanto físicamente como operativamente a la etapa previa al ingreso a pabellón.

  === Ver PDF protocolo

  La acción `Ver PDF protocolo` permite abrir el documento generado a partir del protocolo quirúrgico ya registrado. Se presenta como acción secundaria en la lista de trabajo, como muestra la @fig-accion-ver-pdf-icon.

  #figure(
    image("./imagenes/cap06-accion-ver-pdf-icon.png", width: 30%),
    caption: [Acción para ver el PDF del protocolo quirúrgico.],
  ) <fig-accion-ver-pdf-icon>

  `canExecute()` valida que la atención ya tenga realizado el protocolo y que exista una evaluación de protocolo con datos completos, por lo que la acción solo aparece cuando el documento puede generarse. Al seleccionarla, `trigger()` abre un modal de espera indicando que el PDF se está generando, como se observa en la @fig-accion-ver-pdf.

  #figure(
    image("./imagenes/cap06-accion-ver-pdf.png", width: 40%),
    caption: [Modal mostrado mientras se genera el PDF del protocolo quirúrgico.],
  ) <fig-accion-ver-pdf>

  Una vez preparado, el sistema entrega el protocolo en formato PDF. El documento reúne la información clínica y operacional registrada durante la intervención, incluyendo los datos principales de la atención, el equipo clínico y el detalle del acto quirúrgico. Un ejemplo del PDF generado se incluye en el @anexo-pdf-protocolo.

  === Imprimir brazalete

  La acción `Imprimir brazalete` se incorporó para reutilizar el mecanismo de impresión ya existente en la plataforma. La @fig-accion-imprimir-brazalete-icon muestra la acción disponible en la lista de trabajo.

  #figure(
    image("./imagenes/cap06-imprimir-brazalete-icon.png", width: 30%),
    caption: [Confirmación para imprimir el brazalete del paciente desde la lista de trabajo quirúrgica.],
  ) <fig-accion-imprimir-brazalete-icon>

  Al seleccionarla, `trigger()` abre un diálogo de confirmación mediante `surgical_process:run_dialogs`, como se observa en la @fig-accion-imprimir-brazalete. Si el usuario confirma, la acción emite `surgical_process:print_wristband` con la `AtencionQuirurgica`. El plugin recibe ese evento y llama a la clase compartida `BrazaleteBpm`, pasando el identificador del paciente y la acción BPM de impresión. No se implementó un mecanismo nuevo de impresión; solo se conectó la acción del módulo quirúrgico con la clase ya disponible porque pabellón necesita imprimir el brazalete durante el flujo.

  #figure(
    image("./imagenes/cap06-imprimir-brazalete.png", width: 50%),
    caption: [Diálogo de confirmación antes de enviar a imprimir el brazalete.],
  ) <fig-accion-imprimir-brazalete>

  === Suspender cirugía

  La acción `Suspender cirugía` permite cancelar operacionalmente una intervención desde la lista de trabajo. Esta acción se presenta como acción secundaria, dentro del menú de tres puntos, como muestra la @fig-accion-suspender-icon.

  #figure(
    image("./imagenes/cap06-accion-suspender-icon.png", width: 30%),
    caption: [Acción de suspensión disponible como acción secundaria en la tabla de atención quirúrgica.],
  ) <fig-accion-suspender-icon>

  Al seleccionar la acción, `trigger()` abre un diálogo de confirmación mediante `surgical_process:run_dialogs`. El diálogo muestra el paciente asociado y carga el formulario `CFormSurgicalProcessSuspend`, que solicita motivo, motivo específico y observaciones, como se observa en la @fig-accion-suspender. Los motivos de suspensión se obtienen desde la terminología `causa-suspension-qx` almacenada en MongoDB; el formulario carga solo términos activos y filtra subcausas activas para el motivo seleccionado.

  #figure(
    image("./imagenes/cap06-accion-suspender.png", width: 90%),
    caption: [Diálogo de confirmación y formulario de motivos para suspender una intervención quirúrgica.],
  ) <fig-accion-suspender>

  Al confirmar, el diálogo emite `surgical_process:commit_action` con los datos del formulario. El método `commit` construye el cuerpo para la suspensión con el paciente, el clínico ejecutor, la cita asociada, la atención `PatientService` cuando existe, la causa, la subcausa y las observaciones. La acción mapea causa y subcausa al formato que espera la orquestación, conservando identificador, descripción y códigos disponibles.

  Finalmente, el método `commit` emite `surgical_process:execute_api_call` con la acción API `bpm.postDynamicOrchestration`, el identificador de la orquestación de suspensión y el cuerpo normalizado por la acción. La secuencia ejecutada por esa orquestación se describe en la @sec-orquestacion-suspender-cirugia.

  == Acciones implementadas fuera de la lista de espera

  La acción `Recepcionar paciente` de admisión se implementó en una aplicación legacy de admisión de pacientes, fuera de la aplicación de proceso quirúrgico. Esa aplicación no comparte el mismo modelo de `Accion` ni de `Estado` usado por la nueva lista de trabajo, por lo que la adaptación se limitó a agregar lógica para obtener intervenciones programadas de pabellón que ahora se representan como citas de Agenda, sin realizar cambios visuales en la interfaz existente.

  Para soportarla, la lista legacy se extendió para mostrar citas quirúrgicas electivas junto con las admisiones, instancias y traslados que ya manejaba. La @fig-admision-paciente-lista muestra una cita de Agenda que representa una atención quirúrgica programada y que puede recepcionarse desde esa aplicación. Al seleccionarla, se abre el formulario de admisión con los datos de la cita y del paciente; al confirmar, se ejecuta la admisión y la cita queda lista para continuar con la recepción en pabellón dentro del flujo quirúrgico.

  #figure(
    image("./imagenes/cap06-admision-paciente-lista.png", width: 100%),
    caption: [Lista de admisión con una cita quirúrgica de Agenda disponible para recepcionar al paciente.],
  ) <fig-admision-paciente-lista>

  Para alimentar esta vista también se ajustó el backend de admisión de HEGC, de modo que se puedan obtener las citas quirúrgicas electivas agendadas para el día desde la aplicación legacy.

  == Extensiones backend para el flujo quirúrgico

  La implementación backend incorporó mejoras en servicios existentes y configuraciones de base de datos para soportar la nueva versión del módulo de pabellón. Estas mejoras permitieron representar programaciones quirúrgicas, atenciones clínicas, evaluaciones, traslados, eventos y datos de integración dentro de la plataforma. Los principales cambios se agrupan a continuación como inventario de implementación; cada punto corresponde a una capacidad incorporada o ajustada durante el desarrollo.

  === Agenda: participantes de citas quirúrgicas

  En Agenda se ajustó la forma de asociar participantes a una cita quirúrgica. El problema no era desconocer la identidad del paciente: las personas de XRM, los pacientes de HLTH y los participantes de Agenda comparten una referencia funcional común. En la práctica, el identificador de persona, el identificador de paciente y la `externalReference` del participante corresponden al mismo valor. Lo que podía faltar era el registro de participante en Agenda, cuyo identificador interno es un UUID propio del microservicio.

  Esta brecha aparecía porque Agenda es un microservicio más reciente y, durante el desarrollo del trabajo, no existía todavía un mecanismo transversal que mantuviera sincronizados todos los pacientes entre XRM, HLTH y Agenda. Por eso un paciente podía existir en XRM y HLTH, pero no como participante de Agenda. Esto afectaba tanto a programaciones electivas importadas desde Gestión Hospitales como a pacientes de urgencia, ya que ambos flujos necesitan crear una cita asociada al paciente.

  Para resolverlo, el adaptador de participantes permite recibir participantes sin UUID interno de Agenda, siempre que incluyan `externalReference` y `typeId`. Agenda busca con esa dupla porque es segura como identificador único del participante dentro de su tipo. Si el participante existe, se reutiliza; si no existe y el tipo corresponde a paciente, se crea en Agenda con la referencia externa y los datos disponibles. Además, `DefaultAppointmentStore` usa el comportamiento común de entidades participables para reemplazar las relaciones en `appointment_participant` al guardar la cita. Con esto, las citas quirúrgicas quedan vinculadas al paciente aunque este no hubiera estado sincronizado previamente en Agenda.

  === HLTH: atención quirúrgica, ubicación y datos extendidos <sec-hlth-atencion-quirurgica-ubicacion-datos-extendidos>

  En HLTH se realizaron tres ajustes principales para soportar la atención quirúrgica como entidad operativa del flujo. Primero, se extendió la actualización de datos extendidos de `PatientService` mediante `updateDataPathMode`. Este parámetro permite indicar cómo debe combinarse el nuevo contenido con el objeto existente en una ruta determinada de `extendedData`. Los modos soportados son `replace`, `append`, `merge-replace`, `merge-deep` y `merge-ignore`. En el flujo quirúrgico fue especialmente útil `merge-deep`, porque permite combinar objetos de forma recursiva: una acción puede modificar valores internos de `extendedData.pabellon`, como un hito o un `stateKey`, sin reconstruir ni sobrescribir ramas completas como programación, diagnósticos o intervenciones.

  Segundo, se modificó el cambio de ubicación de una atención para permitir actualizar `extendedData` durante la misma operación. Esto fue necesario porque varias etapas del flujo quirúrgico combinan movimiento físico y cambio de estado operacional. Por ejemplo, al ingresar a pabellón se cambia la ubicación del paciente, pero también debe registrarse el nuevo estado del flujo y el hito correspondiente. Por eso `setLocation` acepta una sección `extendedData` con `path`, `data` y `updateDataPathMode`, y reutiliza `setExtendedData` después de realizar el movimiento.

  Tercero, se incorporó soporte para revertir un ingreso a pabellón. Esta capacidad permite corregir un ingreso accidental y devolver al paciente a su ubicación anterior, por ejemplo CMA. Para que los reportes y consultas posteriores reflejen que el paciente permaneció en esa unidad, `LocationHistory` puede registrar una nueva entrada usando como fecha de inicio la del registro anterior. Este cambio introdujo un bug acotado: cuando dos registros de historial tenían la misma fecha de inicio, la consulta de `PatientService` podía duplicar resultados porque no filtraba correctamente los registros cerrados. La corrección consistió en ajustar esa consulta para considerar solo el historial de ubicación vigente.

  == Integración con Gestión Hospitales

  La integración con Gestión Hospitales se implementó para incorporar al nuevo flujo las cirugías electivas programadas en una aplicación anterior de la plataforma. La dificultad principal era que Gestión Hospitales no utiliza el mismo modelo de datos que los microservicios actuales: las órdenes quirúrgicas, pacientes, diagnósticos, intervenciones, pabellones y datos de lista de espera se encuentran en una base histórica, mientras que la nueva lista de trabajo opera sobre citas de Agenda, pacientes de HLTH, participantes de Agenda y datos extendidos del flujo quirúrgico.

  Para resolver esta brecha, el servicio HEGC actúa como adaptador entre ambos modelos. El método de importación obtiene desde Gestión Hospitales las órdenes quirúrgicas del día que aún no han sido exportadas, filtrando por estados válidos y por fecha de tabla. Para cada orden, normaliza el RUT del paciente, busca o crea la persona en XRM, asegura la existencia del paciente en HLTH y prepara el participante tipo paciente en Agenda. Esta lógica fue necesaria porque Agenda no siempre tenía sincronizados todos los pacientes existentes en XRM y HLTH, y la creación de la cita requiere que el paciente quede asociado como participante.

  Luego, la integración construye los participantes requeridos para la cita quirúrgica. Además del paciente, busca el clínico solicitante en XRM, usando el cirujano de la orden o, si no existe, un anestesista asociado al equipo médico. También traduce la sala de pabellón de Gestión Hospitales a una ubicación conocida por la plataforma mediante un mapeo interno. Con esto, la cita queda relacionada con paciente, responsable clínico y pabellón sin que la nueva aplicación de pabellón tenga que conocer directamente las tablas antiguas.

  La transformación también prepara la información clínica y operacional de la orden. Se consultan diagnósticos e intervenciones desde las tablas de relación de Gestión Hospitales y se normalizan en estructuras usadas por `extendedData.pabellon`. Cuando no existen datos estructurados, se utilizan campos de texto libre como respaldo, extrayendo códigos y descripciones cuando es posible. Además, se conserva información de la orden original, como identificador, condición GES, ambulatoriedad, fecha de ingreso a lista de espera, servicio de origen y tiempos operatorios. Estos datos permiten que la cita creada en Agenda conserve trazabilidad hacia Gestión Hospitales y pueda ser mostrada correctamente en la lista quirúrgica.

  Antes de crear la cita, el servicio revisa si el paciente ya tiene una atención activa de hospitalización. Esto es relevante porque, en cirugías electivas, algunos pacientes son recepcionados con anticipación y permanecen hospitalizados hasta su ingreso a pabellón. En esos casos no corresponde admisionarlos nuevamente al iniciar el flujo quirúrgico. Por ello, si existe una atención activa, la cita se crea con estado inicial `En espera`, conserva la ubicación de hospitalización como ubicación de origen y registra los datos de la atención previa. Si no existe una atención activa, el caso se considera cirugía mayor ambulatoria y queda inicialmente como `Programada`, para que luego pueda pasar por la admisión correspondiente.

  Finalmente, HEGC construye el payload de Agenda y crea una cita quirúrgica mediante el endpoint de citas. La cita incluye programación, servicio de Agenda, ubicación base, participantes, referencia externa a la orden de Gestión Hospitales y el `extendedData` necesario para el flujo de pabellón. Después de crearla, se actualiza la orden original en Gestión Hospitales con el identificador de la cita creada, evitando que vuelva a ser importada y manteniendo una relación explícita entre la orden histórica y la nueva representación del proceso quirúrgico.

  == Implementación del orquestador dinámico

  El orquestador dinámico se implementó mediante cambios en BPM, un workflow de Temporal, una actividad principal de ejecución, validaciones de entrada y un formato configurable de actividades.

  === Registro del workflow en la base de datos

  Para instanciar el orquestador desde BPM, se agregó una definición en la base de datos de BPM que asocia un identificador de proceso con la clase `DynamicOrchestratorWorkflow`. Esta definición permite que BPM reciba una solicitud, resuelva qué clase de workflow debe iniciar y reutilice su mecanismo estándar de creación de instancias.

  Con este registro, el orquestador dinámico quedó integrado al mismo mecanismo usado por otros procesos de la plataforma: BPM recibe la solicitud, construye el mensaje de creación, lo envía mediante RabbitMQ y el worker de Temporal ejecuta el workflow registrado.

  === Endpoint para iniciar una orquestación dinámica

  Para simplificar el consumo desde frontend y desde otros componentes, se disponibilizó el endpoint `POST /bpm/dynamic-orchestrations/{id}`. El identificador de la ruta corresponde a la definición de orquestación dinámica que se desea ejecutar. El cuerpo de la solicitud contiene solo los parámetros de negocio requeridos por esa definición.

  Internamente, el endpoint carga la configuración desde `dynamic_orchestration`, obtiene `dorch_param_schema` y `dorch_activities`, valida los parámetros recibidos y construye el input que será enviado al workflow. Luego reutiliza la clase existente de BPM para crear instancias de workflows de Temporal, indicando el proceso registrado para el orquestador dinámico. De este modo, el frontend no necesita conocer la clase del workflow ni enviar la lista completa de actividades; solo debe conocer qué orquestación ejecutar y con qué parámetros.

  === Restricción de payload de Temporal

  La implementación debió considerar una restricción importante de Temporal: el tamaño de los payloads enviados como argumentos o retornos de workflows y actividades. La documentación de Temporal para instalaciones self-hosted indica que estos payloads generan advertencias desde 256 KB y errores desde 2 MB @TemporalSelfHostedDefaults. Este límite muestra que los datos intercambiados entre workflow y actividades no deben crecer sin control.

  Esta restricción condicionó la implementación del orquestador. Las orquestaciones dinámicas acumulan respuestas de actividades para que pasos posteriores puedan utilizar resultados previos. Si cada paso configurado fuera una actividad de Temporal independiente, el workflow tendría que enviar a cada actividad un contexto cada vez más grande, compuesto por los parámetros originales y la lista acumulada de respuestas. En acciones que consultan pacientes, citas, atenciones, traslados o evaluaciones, ese contexto podía crecer rápidamente.

  === Loop en una sola actividad de Temporal

  Para reducir el riesgo de exceder límites de payload, el loop completo se implementó dentro de una única actividad de Temporal. En vez de programar una actividad Temporal por cada paso dinámico, el workflow envía una vez el input inicial a una actividad principal. Esa actividad ejecuta internamente todas las actividades configuradas y solo devuelve un resultado final cuando la configuración lo permite.

  Esta implementación limita algunas ventajas de Temporal. En particular, Temporal deja de observar cada paso dinámico como una actividad independiente, por lo que no puede reintentar desde el paso interno que falló. Si una actividad dinámica falla, el reintento de Temporal vuelve a ejecutar la actividad principal completa, es decir, toda la orquestación desde el inicio.

  Este fue un compromiso técnico: se sacrificó granularidad de ejecución en Temporal, pero se mantuvo la ventaja principal requerida por el proyecto, que era coordinar actividades entre microservicios sin depender del motor de procesos propietario y sin desarrollar un workflow específico para cada acción.

  === Workflow principal

  El workflow `DynamicOrchestratorWorkflow` recibe un objeto de entrada y asegura que exista una propiedad `params`. Si la solicitud incluye un identificador de orquestación, el workflow obtiene desde la base de datos la definición correspondiente, carga la lista de actividades y el esquema de parámetros, y valida la entrada antes de iniciar la ejecución. Si no existe una lista válida de actividades, el workflow falla antes de ejecutar operaciones sobre servicios externos.

  Un input simplificado, omitiendo el identificador resuelto por BPM, tiene la siguiente forma:

  ```json
  {
    "params": {
      "patientServiceId": 123,
      "fechaInicioHito": "2026-01-10T10:30:00"
    }
  }
  ```

  En este ejemplo, `params` contiene los datos de negocio que esa orquestación necesita. El identificador de orquestación permite resolver qué definición debe cargarse desde la base de datos. El workflow no contiene la lógica específica de finalizar recuperación, suspender o iniciar traslado; esa lógica se obtiene desde la configuración.

  === Loop principal de actividades

  La actividad principal del orquestador ejecuta el loop de actividades. Primero obtiene la lista configurada en `dorch_activities`, toma los parámetros de entrada y agrega una propiedad reservada `_responses`, inicializada como una lista vacía. Luego recorre las actividades en el orden en que aparecen en la configuración.

  En cada iteración, el orquestador construye una actividad ejecutable a partir de la definición cruda. Para ello resuelve plantillas, evalúa condiciones, ejecuta la operación correspondiente y actualiza el contexto. Como se muestra en la @fig-ejecucion-interna-orquestador, el loop distingue primero si quedan actividades por procesar, luego evalúa la condición `when` y finalmente ejecuta una actividad HTTP o una actividad de asignación según corresponda. El resultado de cada paso se registra antes de volver al inicio del loop, manteniendo actualizado el contexto y la lista `_responses`.

  #figure(
    image("./imagenes/ejecucion_interna_del_orquestador.drawio.png", width: 90%),
    caption: [Ejecución interna del orquestador dinámico durante el procesamiento secuencial de actividades configuradas.],
  ) <fig-ejecucion-interna-orquestador>

  Un fragmento simplificado de una lista de actividades es el siguiente:

  ```json
  [
    {
      "method": "GET",
      "url": "https://api.lahuen.health/hlth/patient-services/{{id}}",
      "url_data": {
        "id": { "path": "$.patientServiceId" }
      }
    },
    {
      "method": "GET",
      "url": "https://api.lahuen.health/hlth/transfers",
      "query_params": {
        "patient-id": { "path": "$._responses[0].patient.id" }
      }
    }
  ]
  ```

  La segunda actividad puede usar el resultado de la primera porque este fue guardado en `_responses[0]`. Esta forma de encadenamiento permitió expresar acciones donde una llamada obtiene contexto y las siguientes usan ese contexto para decidir o ejecutar cambios.

  === Contexto de ejecución y lista de respuestas

  Las respuestas de las actividades se guardan dentro del mismo objeto de contexto que se entrega a los pasos posteriores, bajo la propiedad reservada `_responses`. El nombre usa prefijo `_` para reducir el riesgo de mezclarse con parámetros de negocio enviados por el frontend o por una suscripción BPM.

  `_responses` es una lista ordenada. El índice de cada respuesta coincide con el índice de la actividad en la lista `dorch_activities`. Esto significa que la respuesta de la primera actividad queda en `$._responses[0]`, la segunda en `$._responses[1]`, y así sucesivamente. Incluso cuando una actividad no produce datos útiles, o cuando es omitida por una condición `when`, se agrega una respuesta. Por ello, la posición de una actividad y la posición de su respuesta se mantienen alineadas durante toda la ejecución.

  Esta decisión hace que las referencias por índice sean seguras y predecibles. Una definición puede depender de `$._responses[1].items[0]` sabiendo que esa posición corresponde siempre a la segunda actividad configurada, no a la segunda actividad que efectivamente retornó datos. Esto evita desplazamientos difíciles de depurar cuando una actividad condicional se omite.

  === Construcción recursiva de objetos con plantillas

  Una parte central del orquestador es el mecanismo para construir objetos finales a partir de plantillas. Una plantilla puede mezclar valores estáticos con objetos resolvibles. Un objeto resolvible es un objeto de configuración que incluye la propiedad `path` y que, antes de ejecutar una actividad, debe ser reemplazado por un valor concreto calculado por el orquestador.

  El proceso es recursivo. El orquestador revisa todas las propiedades de un objeto. Si encuentra objetos o listas, los recorre de la misma forma. Si encuentra un objeto resolvible, lo reemplaza por el valor obtenido. Si encuentra un valor no iterable, como un número, string, booleano o `null`, lo deja como caso base. De esta manera, un cuerpo HTTP, los parámetros de una URL o un conjunto de headers pueden describirse como una plantilla JSON que se transforma antes de ejecutar la actividad.

  La resolución no se limita a obtener valores desde el contexto mediante JSONPath. Cuando `path` comienza con `$`, el orquestador usa también la propiedad `source`, cuyo valor por defecto es `data`, para decidir cómo interpretar esa ruta:

  - `data`: interpreta `path` como JSONPath sobre el contexto de ejecución y usa el primer resultado encontrado. Si no hay coincidencias, el valor queda como `null`.
  - `literal`: permite retornar un valor literal cuando `path` usa el prefijo `$:`. Por ejemplo, `$:Hola mundo` se resuelve como `Hola mundo`.
  - `base`: obtiene valores base provistos por el orquestador, como fecha, hora o mes actual, según la clave indicada en `path`.

  Además de `path`, el mecanismo soporta propiedades auxiliares para completar la construcción de plantillas:

  - `default`: define un valor alternativo cuando la ruta no produce resultado.
  - `transform`: convierte el valor obtenido a un tipo esperado, por ejemplo entero, número, string, booleano u objeto.
  - `source`: indica si el valor se obtiene desde el contexto de ejecución, desde valores base del sistema o desde un literal.
  - `interpolation_data`: permite construir strings con placeholders. Por ejemplo, un string con `{{value}}` puede reemplazar esa marca si recibe un objeto como `{ "value": 1 }` en `interpolation_data`.
  - `prefix`: agrega texto antes del valor resuelto.
  - `suffix`: agrega texto después del valor resuelto.

  La @fig-construccion-plantillas muestra un ejemplo de resolución. Si el contexto contiene `patientServiceId` y `fechaInicio`, el resultado conserva la estructura del objeto, pero reemplaza los objetos con `path` por valores concretos. Así, la configuración describe el objeto deseado y el orquestador calcula las partes dinámicas antes de llamar al servicio correspondiente.

  #figure(
    image("./imagenes/diagrama_construcción_recursiva_de_objetos_con_plantillas.png", width: 100%),
    caption: [Ejemplo de construcción de un objeto a partir de una plantilla y un contexto de entrada.],
  ) <fig-construccion-plantillas>

  === Validación de entrada con JSON Schema

  Cada orquestación define un `dorch_param_schema`. Este campo utiliza JSON Schema, estándar usado para describir y validar la estructura de documentos JSON @JSONSchemaDocs. En el orquestador, el esquema permite validar los parámetros recibidos antes de ejecutar cualquier actividad.

  Un esquema simplificado puede tener la siguiente forma:

  ```json
  {
    "type": "object",
    "additionalProperties": false,
    "properties": {
      "patientServiceId": { "type": "integer" },
      "fechaInicio": { "type": "string", "format": "date-time" }
    },
    "required": ["patientServiceId", "fechaInicio"]
  }
  ```

  La validación temprana evita iniciar una secuencia si faltan datos obligatorios o si los tipos no coinciden con lo esperado. Esto es importante porque una orquestación puede ejecutar varios cambios en servicios distintos; detectar un error de entrada antes de comenzar reduce el riesgo de dejar una acción parcialmente ejecutada.

  === Condiciones de ejecución con JsonLogic

  Las actividades pueden incluir condiciones mediante la propiedad `when`. Estas condiciones se expresan con reglas compatibles con JsonLogic, un formato para representar lógica sobre datos mediante objetos JSON @JSONLogicDocs. En el orquestador, `when` permite decidir si una actividad debe ejecutarse o saltarse según el contexto disponible.

  Por ejemplo, una actividad puede ejecutarse solo cuando existe un traslado pendiente:

  ```json
  {
    "when": {
      "!is_null": [
        { "var": "transfer.id" }
      ]
    }
  }
  ```

  También puede usarse para derivar una ejecución según el origen del caso:

  ```json
  {
    "when": {
      "==": [
        { "var": "tabla" },
        "electiva"
      ]
    }
  }
  ```

  La ejecución condicional fue necesaria para que el orquestador fuera útil como DSL y no solo como una lista fija de llamadas. No todas las actividades de una orquestación deben ejecutarse siempre: algunas dependen del estado del paciente, de la existencia de datos previos o del resultado de consultas anteriores. Sin `when`, esas decisiones tendrían que resolverse fuera de la configuración, reduciendo la reutilización del mecanismo y obligando a separar en varias definiciones casos que comparten gran parte de la misma lógica.

  Un ejemplo concreto es la orquestación para finalizar recuperación. Esta definición primero consulta la atención, luego busca traslados pendientes y después guarda variables intermedias como si el paciente corresponde a una modalidad de cirugía mayor ambulatoria y si existen traslados disponibles. A partir de esas variables, la misma configuración cubre distintos escenarios: si el paciente puede quedar esperando alta y no hay traslados, registra el estado de espera de alta; si no corresponde alta directa y tampoco hay traslados, lo deja esperando traslado; y si ya existe un traslado pendiente, registra la información del traslado y deja el caso en el estado correspondiente. La lógica condicional permite que una misma orquestación represente estas variantes sin duplicar toda la secuencia común de consulta y preparación de datos.

  === Operadores agregados a JsonLogic

  Para cubrir condiciones frecuentes del flujo quirúrgico, se agregaron operadores a JsonLogic. Estos operadores permiten evaluar de manera más directa respuestas de APIs, listas vacías, valores nulos y tipos esperados:

  - `empty`: verifica si un valor se considera vacío, como una lista sin elementos o un string sin contenido.
  - `!empty`: verifica que un valor tenga contenido útil para continuar la ejecución.
  - `is_null`: verifica si un valor es nulo.
  - `!is_null`: verifica si existe un valor distinto de nulo.
  - `is_array`: verifica si un valor corresponde a una lista o arreglo.
  - `typeof`: permite comparar el tipo de un valor antes de usarlo en una condición o transformación.

  Un ejemplo de condición que utiliza operadores agregados es el siguiente:

  ```json
  {
    "and": [
      { "is_array": [ { "var": "protocolo" } ] },
      { "!empty": [ { "var": "protocolo" } ] }
    ]
  }
  ```

  Estas extensiones fueron necesarias porque las respuestas de servicios pueden contener objetos heterogéneos, listas, valores nulos o estructuras opcionales. Mantener estas comprobaciones dentro de la configuración permitió reducir lógica imperativa en PHP y hacer que las condiciones fueran visibles junto a la actividad que controlan.

  === Actividad HTTP

  La actividad más común es `http_request`, que también funciona como tipo por defecto cuando la definición no indica otro tipo. Esta actividad permite ejecutar llamadas `GET`, `POST`, `PUT`, `PATCH` y `DELETE` hacia servicios de la plataforma. El objeto de configuración puede incluir las siguientes propiedades:

  - `method`: define el método HTTP que se ejecutará.
  - `url`: define la URL base o plantilla de URL del endpoint.
  - `url_data`: contiene valores usados para reemplazar placeholders de la URL, por ejemplo `{{id}}`.
  - `query_params`: define parámetros que se agregan a la URL como query string.
  - `body`: define el cuerpo enviado en métodos que aceptan payload.
  - `headers`: define encabezados HTTP adicionales para la solicitud.
  - `options`: agrupa opciones adicionales usadas por el cliente HTTP.
  - `encode_query_params`: indica si parámetros complejos deben serializarse antes de agregarse a la URL.
  - `response_wrapper_key`: permite guardar la respuesta bajo una llave estable dentro del contexto.
  - `when`: define una condición que determina si la actividad debe ejecutarse.

  El siguiente ejemplo muestra una actualización de datos extendidos de una atención:

  ```json
  {
    "method": "PATCH",
    "url": "https://api.lahuen.health/hlth/patient-services/{{id}}/ext/pabellon",
    "url_data": {
      "id": { "path": "$.patientServiceId" }
    },
    "body": {
      "stateKey": {
        "id": 61,
        "description": "En tránsito"
      }
    },
    "query_params": {
      "updateDataPathMode": "merge-deep"
    }
  }
  ```

  En este caso, `url_data` reemplaza el placeholder `{{id}}`, `body` define los datos enviados y `query_params` agrega parámetros a la URL. Si un parámetro de query es un objeto complejo, `encode_query_params` permite serializarlo para enviarlo correctamente. `response_wrapper_key` se utiliza cuando conviene guardar la respuesta bajo una llave estable, por ejemplo cuando un endpoint retorna una lista y se desea acceder luego a ella como `items`.

  === Actividad de asignación

  La segunda actividad implementada es `assignment`. Esta actividad no llama a servicios externos, sino que crea variables intermedias dentro del contexto de ejecución. Su utilidad principal es simplificar referencias posteriores y preparar datos que serán usados por condiciones o cuerpos de solicitud.

  Un ejemplo simplificado es el siguiente:

  ```json
  {
    "type": "assignment",
    "assign": {
      "esCma": {
        "path": "$._responses[0].extendedData.esCma",
        "default": false
      },
      "transfer": {
        "path": "$._responses[1].items[0]",
        "default": null
      }
    }
  }
  ```

  Después de esta actividad, otras actividades pueden usar `$.esCma` o `$.transfer` en vez de repetir rutas largas hacia `_responses`. Esto mejora la legibilidad de la configuración y facilita escribir condiciones `when` sobre valores relevantes.

  === Reintentos y seguridad operacional

  La decisión de ejecutar el loop dentro de una sola actividad de Temporal tiene consecuencias sobre los reintentos. Si una actividad dinámica interna falla, Temporal reintenta la actividad principal completa. Esto implica volver a ejecutar la orquestación desde el inicio, no desde el paso que falló. En acciones que crean registros o modifican estado, este comportamiento puede producir duplicados o efectos no deseados si los pasos no son seguros ante reejecución.

  Por ello, se incorporó un límite configurable de reintentos y se dejó configurado con un valor bajo. Además, las orquestaciones fueron definidas buscando reducir riesgos: validando entradas con JSON Schema, consultando estado antes de operar, usando condiciones `when` y evitando reintentos automáticos agresivos sobre operaciones que pudieran no ser idempotentes. Esta solución no elimina por completo el problema, pero fue la alternativa más razonable considerando las restricciones de tiempo y la necesidad de contar con un mecanismo de orquestación que permitiera prescindir del motor de procesos propietario.

  === Resultado del orquestador dinámico

  Con esta implementación, la plataforma incorporó una capacidad reusable para coordinar acciones compuestas entre microservicios. Las reglas específicas de cada transición quedan expresadas como definiciones configurables, mientras que el workflow común entrega el mecanismo de ejecución, validación y secuenciamiento. Esto permite incorporar nuevas acciones del flujo quirúrgico con menos código específico, aprovechar endpoints existentes y mantener la coordinación fuera del frontend, en una capa más adecuada para ejecutar procesos asincrónicos y trazables.

  == Orquestaciones dinámicas del flujo quirúrgico <sec-orquestaciones-dinamicas-flujo-qx>

  Sobre el orquestador dinámico se configuraron acciones concretas del flujo quirúrgico. Estas orquestaciones no forman un único proceso monolítico; cada una resuelve una transición o automatización acotada, reutilizando servicios de Agenda, HLTH, BPM, AUTH y HEGC, junto con formularios clínicos provistos por EHR cuando corresponde. En conjunto permiten que la lista de trabajo ejecute acciones complejas sin concentrar en el frontend la coordinación entre componentes de la plataforma.

  === Aceptar orden de urgencia <sec-orquestacion-aceptar-orden-urgencia>

  La orquestación de aceptación de orden de urgencia recibe la indicación quirúrgica, la fecha programada, el pabellón seleccionado y los datos del usuario ejecutor. Primero consulta la indicación en HLTH con paciente y ubicación, guarda la respuesta como contexto de trabajo y extrae los diagnósticos GES para poblar la orden. Luego crea una cita quirúrgica en Agenda con participantes de tipo pabellón, paciente y profesional solicitante. La cita queda referenciada a la indicación mediante `externalReference` y almacena en `extendedData` los datos que la lista de trabajo necesita para tratarla como caso de urgencia: especialidad, diagnósticos, intervención original, ubicación de origen, orden, tiempo operatorio y referencia a la atención clínica de origen. Al final ejecuta `_start` sobre la indicación para dejar registrado que la orden fue aceptada.

  === Admisionar paciente <sec-orquestacion-admisionar-paciente>

  La admisión del paciente opera sobre una cita existente. La orquestación consulta la cita con sus participantes, obtiene desde HLTH el profesional registrado en Agenda y crea un `care-manager` para el paciente, usando el prestador recibido o el valor por defecto configurado. Luego actualiza la cita para dejarla en estado operacional `En espera`, crea una admisión HLTH de tipo `4` con el formulario de admisión y finalmente llama a HEGC para abrir la cuenta administrativa. El cuerpo enviado a HEGC se construye desde el mismo formulario, incluyendo identificación, datos personales, contacto, previsión y ubicación administrativa usada por la integración.

  === Recepcionar paciente <sec-orquestacion-recepcionar-paciente>

  La recepción se separó en una orquestación de derivación y dos orquestaciones específicas. La derivación recibe `tabla` y ejecuta la variante de urgencia o electiva, conservando una única acción visible en la lista de trabajo. En urgencia, la orquestación consulta la cita, obtiene el profesional responsable, inicia la indicación y la cita, busca una atención abierta previa de hospitalización o urgencia, libera su ubicación si existe y crea una atención HLTH de tipo pabellón en estado `Preoperatorio`. La atención creada conserva la cita, la indicación, la orden, la ubicación de origen, el responsable, intervenciones, diagnósticos y tiempos operatorios.

  En el flujo electivo, la orquestación consulta la cita de Agenda, obtiene el profesional responsable, crea el `care-manager`, revisa si el paciente ya tenía una atención abierta y libera esa ubicación cuando corresponde. Esa revisión también define `esCma`: si existe atención previa, el caso se trata como no CMA; si no existe, se marca como CMA. Luego inicia la cita y crea la atención de pabellón con datos provenientes de Agenda y de Gestión Hospitales: programación, pabellón, especialidad, orden, responsable, intervenciones, diagnósticos, tiempos operatorios, ubicación de origen y referencia a la cita.

  === Suspender cirugía <sec-orquestacion-suspender-cirugia>

  La suspensión coordina el cierre operacional de una cirugía que no continuará en el flujo. La orquestación cancela siempre la cita quirúrgica en Agenda, registrando causa, subcausa, observaciones y responsable en sus datos extendidos. Si el paciente ya fue recepcionado, también registra esos datos en la atención quirúrgica de pabellón y cancela esa atención; si el caso solo estaba programado, no existe atención clínica que cancelar.

  Cuando la suspensión ocurre después de iniciar la atención de pabellón, la orquestación revisa si el paciente tenía una atención previa abierta de hospitalización o urgencia. En ese caso crea un traslado de retorno hacia la ubicación de esa atención, porque la recepción en pabellón deja a la atención previa sin uso de ubicación y la cancelación directa de pabellón dejaría al paciente sin ubicación actual. Luego cancela tareas BPM pendientes de protocolo quirúrgico y propaga la suspensión al origen del caso: para cirugías electivas invoca HEGC para suspender la orden en Gestión Hospitales; para urgencias cancela la indicación quirúrgica en HLTH con un motivo construido desde causa, subcausa y observaciones.

  === Finalizar recuperación <sec-orquestacion-finalizar-recuperacion>

  Finalizar recuperación consulta la atención quirúrgica y luego busca transferencias no finalizadas del paciente. Con esos datos asigna tres variables de trabajo: si el caso es CMA, la lista de traslados abiertos y el primer traslado encontrado. Si el caso es CMA y no hay traslados, actualiza los datos de pabellón con el hito `esperandoAlta` y estado `Esperando Alta`. Si no es CMA y no hay traslados, registra `esperandoTraslado`. Si existe un traslado abierto, conserva su identificador y ubicación en la atención quirúrgica y también deja el estado `Esperando traslado`. Después finaliza la cita de Agenda asociada y, cuando la atención tiene indicación de urgencia, finaliza esa indicación con el motivo `Finalización de la recuperación`.

  === Traslados y retorno a unidad de origen

  La orquestación de iniciar traslado recibe una transferencia, ejecuta `_transit` sobre HLTH y actualiza la atención quirúrgica asociada. En esa actualización registra el hito `enTransito` con la fecha recibida y cambia `stateKey` a `En tránsito`; si no se envía explícitamente la atención, usa la que viene en la respuesta del traslado.

  La orquestación de devolución a unidad de origen parte consultando la atención quirúrgica. Luego crea una transferencia en el `care-manager` de esa atención hacia `extendedData.pabellon.ubicacionDeOrigen`, usando el clínico solicitante recibido. Finalmente actualiza la atención con los hitos `esperandoTraslado` y `enTransito`, deja el estado `En tránsito` y guarda el identificador, ubicación y área del traslado creado.

  === Finalizar atención quirúrgica

  La finalización de atención se implementó con dos variantes. La primera consulta la atención HLTH y solo ejecuta `_finish` si el estado actual es `2`, enviando el clínico responsable en el cuerpo de la solicitud. La segunda variante ejecuta directamente `_finish` sobre el `patientServiceId`; se usa en flujos donde la condición de cierre ya fue resuelta antes de iniciar la orquestación, por ejemplo desde una suscripción o una acción previa.

  === Tareas BPM de protocolo quirúrgico

  La creación de la tarea de protocolo consulta la atención quirúrgica, obtiene desde AUTH el usuario asociado al responsable registrado en `extendedData.pabellon.responsable.id` y crea una tarea BPM de tipo `100`. La tarea queda asignada a ese usuario, usa el identificador de la atención como `reference` y guarda en `extendedData.taskInformation` el nombre `Completar protocolo quirúrgico`, el resumen del paciente, el paciente, el `care-manager` y la atención.

  La finalización de la tarea parte desde el clínico que registró el protocolo. La orquestación consulta AUTH por `entc-id`, busca tareas BPM de tipo `100` asociadas al `patientServiceId` en estados activos `1,2` y ejecuta `_execute` sobre la primera tarea encontrada. La ejecución se condiciona a que exista una tarea pendiente, por lo que no intenta cerrar tareas inexistentes o ya resueltas.

  === Operación de Gestión Hospitales

  La orquestación de operación de Gestión Hospitales consulta la atención quirúrgica con sus evaluaciones embebidas, asigna la atención completa, extrae `extendedData.pabellon.orden.id` y filtra evaluaciones no borrador, no eliminadas y de tipo `14`, correspondiente al protocolo quirúrgico. Si hay protocolo, toma el primero como fuente de fecha. La llamada a HEGC `ordenes-quirurgicas/{ordenGhId}/_operar` se ejecuta solo cuando existe protocolo, el caso pertenece a tabla electiva, la atención está finalizada (`state.id == 3`) y existe identificador de orden de Gestión Hospitales. El cuerpo enviado contiene `fechaProtocolo` tomada desde la evaluación seleccionada.

  == Eventos, suscripciones BPM y SSE

  La implementación utilizó eventos con tres propósitos relacionados. En backend, los eventos permiten ejecutar automatizaciones mediante suscripciones BPM configuradas en base de datos. En el servicio de SSE, se mejoró la forma de filtrar y distribuir eventos hacia clientes conectados. En frontend, la lista de trabajo se suscribe a eventos relevantes para actualizar la grilla cuando cambian las entidades que componen el flujo quirúrgico.

  === Suscripciones BPM en backend

  Los microservicios emiten eventos de dominio cuando cambian entidades relevantes, como atenciones, citas, evaluaciones o traslados. Estos eventos se publican en Kafka y quedan disponibles para consumidores que necesitan reaccionar a esos cambios. En el caso de BPM, la reacción se define mediante suscripciones almacenadas en base de datos. Cada suscripción indica el tópico observado, los filtros que deben cumplirse y la transformación que convierte el evento recibido en parámetros para iniciar una orquestación dinámica.

  En el flujo quirúrgico se configuraron las siguientes suscripciones:

  - *Creación de atención quirúrgica*: observa eventos del tópico `api.hlth.patient-service`. Cuando se crea una atención de tipo quirúrgico, inicia la orquestación que crea la tarea BPM de completar protocolo quirúrgico, usando el identificador de la atención como parámetro.
  - *Guardado de protocolo quirúrgico para completar tarea BPM*: observa eventos del tópico `api.hlth.evaluation`. Cuando se crea una evaluación asociada a una atención quirúrgica y el tipo de evaluación corresponde al protocolo quirúrgico, inicia la orquestación que busca y completa la tarea BPM de completar protocolo quirúrgico, usando la atención y el clínico informados por el evento.
  - *Guardado de protocolo quirúrgico para operar en Gestión Hospitales*: observa el mismo evento de creación de protocolo quirúrgico en `api.hlth.evaluation`. Cuando se cumplen las condiciones de atención quirúrgica y tipo de evaluación, inicia la orquestación que evalúa si corresponde marcar la orden como operada en Gestión Hospitales.
  - *Finalización de traslado*: observa eventos del tópico `api.hlth.transfer`. Cuando se finaliza una transferencia en estado final asociado a una atención quirúrgica, inicia la orquestación que finaliza la atención quirúrgica correspondiente.
  - *Finalización de atención quirúrgica*: observa eventos del tópico `api.hlth.patient-service`. Cuando se finaliza una atención de tipo quirúrgico, inicia la orquestación que evalúa si corresponde operar la orden asociada en Gestión Hospitales.

  La lógica de reacción queda así expresada como configuración de BPM y no como llamadas directas desde la lista de trabajo.

  === Eventos agregados en Agenda

  Para que las programaciones quirúrgicas pudieran actualizarse en la lista de trabajo sin recargas manuales, se agregaron eventos en el servicio de Agenda. Estos eventos se publican cuando una cita cambia por una acción del flujo o por la operación de otro usuario. Además, incluyen el tipo de cita, lo que permite que los consumidores filtren solo las citas quirúrgicas.

  Los eventos desarrollados fueron:

  - *Cita creada*: se emite cuando se crea una nueva cita. Permite incorporar nuevas programaciones quirúrgicas a la lista de trabajo.
  - *Cita iniciada*: se emite cuando una cita pasa a estado iniciado. En el flujo quirúrgico, esto indica que se creó una atención clínica y que la cita ya no debe mostrarse como programación pendiente.
  - *Cita cancelada*: se emite cuando una cita es cancelada. Permite retirar o actualizar citas anuladas en la grilla.
  - *Cita reagendada*: se emite cuando cambia la programación de una cita. Permite visualizar rápidamente reagendamientos realizados por otros usuarios.
  - *Cita actualizada*: se emite cuando se modifican datos relevantes de una cita. Permite reaccionar cuando una acción cambia información almacenada en la cita, como el estado operacional en sus datos extendidos.

  === Mejoras al servicio de SSE

  Para la actualización de interfaces se ajustó el servicio de SSE, que consume eventos desde Kafka y los entrega a clientes frontend conectados. Una mejora relevante fue permitir filtros con más de un valor para un mismo parámetro. Antes, un filtro representaba una coincidencia puntual; con el cambio, el cliente puede enviar una lista y recibir eventos que coincidan con cualquiera de esos valores.

  El comportamiento implementado combina los filtros de esta forma: existe un OR dentro de los valores de un mismo filtro y un AND entre filtros distintos. Por ejemplo, una suscripción al tópico de indicaciones con `typeId=21,22&type=created` recibe eventos cuyo tipo de indicación sea 21 o 22, pero siempre que el evento sea de creación. De forma equivalente, una suscripción a citas con `typeId=3,4&type=updated,created` recibe citas cuyo tipo sea 3 o 4 y cuyo evento sea actualización o creación.

  Internamente, los filtros se transforman en grupos de hashes. Cada grupo representa los valores aceptados para un filtro y se cumple si alguno de sus elementos coincide con los hashes del evento. Luego, todos los grupos deben cumplirse para que el mensaje sea enviado al cliente. Este diseño permite expresar filtros más flexibles sin crear endpoints especiales para cada combinación de valores.

  También se refactorizó la lógica del servicio para separar responsabilidades. Se incorporó un modelo de cliente conectado, con sus filtros, suscripciones y respuesta SSE asociada. Además, se centralizó el registro de clientes en buckets por tópico y por clave de filtro, de modo que al llegar un evento no sea necesario recorrer todos los clientes conectados. La limpieza de suscripciones al cerrar una conexión también quedó centralizada, reduciendo el riesgo de mantener referencias a clientes desconectados.

  === Suscripciones frontend con SSE

  En el frontend, la lista de trabajo quirúrgica se conecta al servicio de SSE mediante `EventSource`. Las suscripciones se registran asociadas a la ruta de atención quirúrgica, por lo que solo están activas cuando la vista correspondiente está en uso. Cada suscripción indica un tópico Kafka y filtros de interés; cuando llega un evento que cumple esos filtros, la lista puede recargar o actualizar la información mostrada.

  Las suscripciones configuradas para la lista de trabajo fueron:

  - *Atenciones quirúrgicas*: escucha el tópico `api.hlth.patient-service` filtrando por tipos de atención quirúrgica y tipos de evento relevantes. Es especialmente importante escuchar actualizaciones, porque gran parte de la información operacional del proceso vive en los datos de la atención quirúrgica. Por ejemplo, avanzar de etapa dentro del quirófano técnicamente corresponde a actualizar la información de esa atención. Esta suscripción permite actualizar la grilla cuando una atención quirúrgica se crea, cambia de estado, actualiza sus hitos o finaliza.
  - *Indicaciones quirúrgicas*: escucha el tópico `api.hlth.indication` filtrando por tipos de indicación quirúrgica y eventos relevantes. Permite reflejar cambios en órdenes de urgencia, por ejemplo cuando una indicación es creada, iniciada, cancelada o finalizada.
  - *Citas de Agenda*: escucha el tópico `api.agenda.appointment` filtrando por tipos de cita quirúrgica y eventos relevantes. Permite actualizar programaciones electivas o de urgencia cuando una cita se crea, inicia, modifica, cancela o reagenda.
  - *Evaluaciones clínicas*: escucha el tópico `api.hlth.evaluation` filtrando por tipo de atención quirúrgica, tipos de evaluación relevantes y tipo de evento. Permite actualizar la lista cuando se registran evaluaciones asociadas al flujo, como el protocolo quirúrgico u otros documentos clínicos.

  Durante la implementación se ajustaron los filtros para permitir listas de valores y reducir eventos irrelevantes. También se incorporó un debounce configurable para evitar que múltiples eventos cercanos generen recargas excesivas de la grilla. Esto fue necesario porque una acción orquestada puede modificar más de una entidad y producir varios eventos en poco tiempo. Además, la lista de trabajo puede ser utilizada por múltiples personas de forma independiente, por lo que en operación normal pueden ocurrir muchos cambios con pocos segundos de diferencia. Por esta razón, se buscó usar los filtros del servicio de SSE de la forma más específica posible, escuchando solo los eventos necesarios para la vista, y agrupar recargas cercanas mediante debounce.

]

#capitulo(title: "Evaluación y validación")[
  La evaluación del trabajo se abordó considerando la naturaleza de la solución desarrollada. La mayor parte del esfuerzo estuvo concentrada en construir una nueva aplicación frontend para operar el proceso quirúrgico y en coordinar acciones que involucran distintos microservicios de la plataforma. Por ello, la validación debía comprobar principalmente dos aspectos: que la información mostrada al usuario fuera correcta y completa, y que las acciones ejecutaran los cambios esperados sobre el flujo quirúrgico.

  Los cambios realizados directamente en servicios backend fueron acotados y precisos. La excepción principal fue el orquestador dinámico, que introduce una forma configurable de coordinar actividades entre servicios. Sin embargo, la plataforma no cuenta con una arquitectura de pruebas automatizadas específica para validar orquestaciones completas de este tipo. Construir un conjunto de pruebas automatizadas para todos los casos habría requerido simular múltiples servicios, eventos, respuestas intermedias y estados del proceso, lo que habría consumido una parte importante del tiempo disponible. Por esta razón, se optó por una validación manual y formativa basada en recorridos cognitivos, inspecciones de usabilidad y pruebas funcionales sobre flujos completos.

  == Estrategia de evaluación

  La guía de evaluación de usabilidad usada como referencia distingue métodos rápidos y rigurosos, y describe técnicas como el recorrido cognitivo y la inspección de usabilidad para evaluar sistemas durante el proceso de desarrollo @BaloianPino2024Usabilidad. En este proyecto, esas técnicas resultaron adecuadas porque la solución se encontraba en construcción, debía reemplazar una versión anterior en un plazo acotado y requería validación constante de flujos operacionales.

  El recorrido cognitivo fue aplicado inicialmente por el memorista sobre las funcionalidades desarrolladas. Para cada flujo se verificó si el usuario podría identificar la acción correcta, comprender su efecto, ejecutarla y observar una retroalimentación coherente con el resultado esperado. Esta revisión se aplicó tanto sobre el frontend como sobre las acciones orquestadas, ya que muchas interacciones de la interfaz terminan ejecutando operaciones distribuidas sobre Agenda, HLTH, BPM o HEGC, o abriendo formularios clínicos provistos por EHR.

  Una vez estabilizada una funcionalidad, el líder del proyecto revisaba la versión implementada y realizaba una inspección de usabilidad. Esta revisión permitía validar si el comportamiento era equivalente al flujo esperado, si la información visible era suficiente y si existían oportunidades de mejora en nombres, orden, disponibilidad de acciones o estructura visual. De esta manera, la evaluación no se realizó como una actividad única al final del desarrollo, sino como un proceso iterativo de mejora continua.

  En la evaluación inicial del frontend también se procuró seguir el design system de Lahuén, es decir, los patrones visuales y pautas de comportamiento ya utilizados en otras aplicaciones de la plataforma. Esto permitió mantener continuidad con interfaces previamente conocidas por los usuarios y reducir el costo de adaptación al nuevo módulo.

  == Validación funcional

  La validación funcional consistió en ejecutar manualmente los flujos principales de la aplicación de proceso quirúrgico y verificar el resultado visible en la lista de trabajo, los cambios de estado, la información registrada en la atención y la reacción de los monitores. Las pruebas se enfocaron en los siguientes elementos:

  - *Información mostrada*: se revisó que la grilla presentara correctamente documento, nombre, edad, especialidad, intervención, programación, ubicación, estado y acciones disponibles para cada caso.
  - *Acciones del flujo*: se probaron acciones como aceptar orden, recepcionar paciente, ingresar a pabellón, avanzar hitos intraoperatorios, iniciar y finalizar recuperación, iniciar traslado, devolver a unidad de origen, egresar paciente, suspender cirugía y cargar documentos clínicos.
  - *Orquestaciones*: se verificó que las acciones implementadas mediante orquestaciones ejecutaran las transiciones esperadas y actualizaran las entidades correspondientes.
  - *Integración con Gestión Hospitales*: se validó que el script de importación transformara las órdenes quirúrgicas electivas para crear citas compatibles con Agenda y con la nueva lista de trabajo.
  - *Monitores*: se revisó que el Monitor de pabellones y el Monitor de pacientes mostraran información coherente con los cambios realizados en el flujo.

  Estas pruebas permitieron detectar diferencias respecto del comportamiento anterior y corregirlas durante el desarrollo. En una primera etapa, el objetivo fue igualar el funcionamiento de la versión previa para evitar que los usuarios percibieran una pérdida de capacidades. Luego se incorporaron mejoras acotadas, como nuevas acciones, ajustes visuales, mayor claridad en estados y mejor presentación de información relevante.

  == Evaluación de usabilidad

  La evaluación de usabilidad combinó inspección experta, recorridos cognitivos y una encuesta SUS. El cuestionario SUS, propuesto por Brooke, es un instrumento breve de diez preguntas en escala Likert que permite obtener una aproximación rápida a la usabilidad percibida de un sistema @Brooke1996SUS. La guía de usabilidad utilizada como referencia recomienda interpretar este instrumento con cautela, especialmente cuando se aplica una traducción ad-hoc y cuando el resultado se encuentra cerca del valor de referencia habitual de 68 puntos @BaloianPino2024Usabilidad.

  La encuesta fue respondida por 10 personas que utilizan el software, incluyendo perfiles de enfermería, técnicos y anestesistas. Las preguntas aplicadas fueron las siguientes:

  - Me gustaría usar esta herramienta frecuentemente.
  - Considero que esta herramienta es innecesariamente compleja.
  - Considero que la herramienta es fácil de usar.
  - Considero necesario el apoyo de personal experto para poder utilizar esta herramienta.
  - Considero que las funciones de la herramienta están bien integradas.
  - Considero que la herramienta presenta muchas contradicciones.
  - Imagino que la mayoría de las personas aprenderían a usar esta herramienta rápidamente.
  - Considero que el uso de esta herramienta es tedioso.
  - Me sentí muy confiado al usar la herramienta.
  - Necesité saber bastantes cosas antes de poder empezar a usar esta herramienta.

  #figure(
    table(
      columns: 2,
      [*Métrica*], [*Resultado*],
      [Participantes], [10],
      [Puntaje mínimo], [12,5],
      [Puntaje máximo], [100],
      [Promedio], [65,5],
      [Mediana], [66,25],
      [Desviación estándar aproximada], [24,4],
    ),
    caption: [Resultados agregados de la encuesta SUS.],
  ) <tab-resultados-sus>

  El sistema alcanzó un puntaje SUS promedio de 65,5 sobre 100. Este valor se encuentra ligeramente por debajo del valor de referencia habitual de 68 puntos, por lo que la usabilidad percibida puede interpretarse como aceptable, aunque con oportunidades de mejora. Dado que el resultado está cercano al umbral, y considerando que en Chile no existe una traducción estándar ampliamente validada del instrumento, este resultado debe entenderse como una evaluación rápida y no como una demostración concluyente de usabilidad.

  Los resultados muestran una percepción mixta. Algunos usuarios evaluaron muy positivamente la herramienta, mientras que otros reportaron una experiencia más negativa. Esta dispersión sugiere que el sistema fue comprensible para una parte de los usuarios, pero que todavía existen aspectos de complejidad, adaptación o claridad que deben mejorarse. En particular, la etapa inicial de salida a producción pudo influir en la percepción, ya que algunos comportamientos no eran idénticos a los de la versión anterior y todavía existían ajustes pendientes propios de una primera versión.

  == Validación en producción y mejora continua

  El producto fue puesto en producción el 8 de abril. Desde ese momento comenzó una nueva etapa de validación con usuarios reales, en la que se identificaron situaciones que no habían aparecido durante el desarrollo. Esto es consistente con el funcionamiento de Lahuén como empresa SaaS: el producto no se considera completamente cerrado al momento de su primera liberación, sino que entra en un ciclo de mejora continua a partir de la retroalimentación de usuarios, incidentes detectados y nuevas necesidades operacionales.

  En este contexto, la primera versión tuvo como objetivo reemplazar la versión anterior de la forma más rápida posible, conservando las funcionalidades necesarias para evitar que los usuarios sintieran una pérdida en su flujo de trabajo. Al mismo tiempo, se incorporaron mejoras puntuales de alto impacto para facilitar la adaptación a la nueva versión. La comunicación posterior con usuarios permitió seguir corrigiendo problemas, ajustar comportamientos y avanzar hacia una versión más madura del módulo.

  == Limitaciones de la evaluación

  La evaluación realizada permitió validar funcionalmente el flujo y obtener una primera aproximación a la usabilidad percibida, pero presenta limitaciones. No se implementó una batería automatizada de pruebas para las orquestaciones dinámicas, por las restricciones técnicas y de tiempo ya señaladas. Además, la encuesta SUS entrega una señal útil, pero su interpretación debe ser cuidadosa por el tamaño de muestra, la dispersión de respuestas y el uso de una traducción no estandarizada.

  Por lo anterior, la validación debe entenderse como evidencia inicial de funcionamiento y aceptabilidad, no como una medición definitiva del impacto clínico u operacional del sistema. La madurez de la solución dependerá de nuevas iteraciones, uso sostenido en producción y futuras evaluaciones con usuarios finales.
]

#capitulo(title: "Resultados")[
]

#capitulo(title: "Conclusiones")[
]

#capitulo(title: "Trabajo futuro")[
]

#show: end-doc

#apendice(title: "PDF generado del protocolo quirúrgico", label: <anexo-pdf-protocolo>)[
  #figure(
    image("./imagenes/cap06-pdf-protocolo.png", width: 60%),
    caption: [PDF generado mediante la acción `Ver PDF protocolo`.],
  ) <fig-anexo-pdf-protocolo>
]
