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
  Este capítulo presenta las tecnologías y conceptos arquitectónicos sobre los cuales se construye la modernización del módulo de atención quirúrgica. A diferencia del capítulo anterior, que describe el dominio clínico-operativo y la situación inicial del módulo, aquí se revisan los elementos técnicos que permiten implementar la nueva solución: microservicios, frontend modular, workflows, Temporal y orquestaciones dinámicas.

  El objetivo no es documentar toda la arquitectura interna de la Plataforma Lahuén, sino establecer el marco necesario para comprender las decisiones tomadas durante el desarrollo. En particular, interesa explicar por qué el reemplazo del motor de procesos propietario se apoya en una arquitectura distribuida, en un runtime de workflows durable y en definiciones declarativas que permiten coordinar acciones complejas sin codificar cada flujo de forma rígida.

  == Arquitectura general de Lahuén

  La Plataforma Lahuén se organiza como un conjunto de aplicaciones y servicios que colaboran para implementar procesos asistenciales. En el backend, la plataforma utiliza microservicios construidos principalmente en PHP, lenguaje orientado al desarrollo de aplicaciones web y servicios de servidor @PHPDocs. Estos servicios concentran responsabilidades por dominio funcional, por ejemplo agenda, registro clínico, hospitalización, formularios, procesos y tareas. Esta separación permite que cada servicio exponga operaciones específicas y que los módulos de la plataforma integren capacidades de distintos dominios sin concentrar toda la lógica en una aplicación monolítica.

  En términos generales, la arquitectura de microservicios busca dividir un sistema en servicios pequeños, desplegables y mantenibles de forma independiente. Esta decisión entrega flexibilidad, pero también introduce desafíos de coordinación: una acción de negocio puede requerir llamadas a varios servicios, manejo de estados intermedios, reintentos, trazabilidad y control de errores. La literatura sobre microservicios reconoce esta tensión entre autonomía de servicios y complejidad de interacción, especialmente cuando los flujos de negocio se distribuyen entre múltiples componentes @NadeemM2022.

  En el contexto de este trabajo, dicha tensión aparece con claridad en el proceso quirúrgico. Acciones como recepcionar un paciente, cambiar su ubicación, registrar hitos intraoperatorios, crear tareas clínicas o finalizar etapas del flujo no pertenecen necesariamente a un único servicio. Por ello, la modernización requiere una forma de coordinar operaciones distribuidas sin volver a construir un motor de procesos propietario acoplado a un módulo específico.

  == Backend y microservicios PHP

  Los microservicios backend de Lahuén están implementados principalmente en PHP y se estructuran en torno a APIs, entidades de negocio, servicios, stores y esquemas de validación. Entre los proyectos relevantes para este trabajo aparecen paquetes asociados a dominios como agenda, salud, gestión clínica y procesos. Estos servicios son responsables de consultar y modificar datos de negocio, aplicar reglas propias de cada dominio y emitir eventos cuando ocurren cambios relevantes.

  Para el módulo quirúrgico, los servicios backend más relevantes son aquellos que permiten consultar pacientes y atenciones, crear o actualizar citas, mover pacientes entre ubicaciones, registrar documentos clínicos y coordinar tareas del proceso. Esta distribución permite reutilizar capacidades existentes de la plataforma, pero también obliga a que ciertas acciones del flujo quirúrgico sean implementadas como coordinaciones entre servicios. Por ejemplo, una transición de estado puede requerir actualizar una atención clínica, liberar o utilizar una ubicación, registrar una tarea y dejar trazabilidad del evento.

  La decisión de mantener esta separación es importante para la modernización. En lugar de concentrar toda la lógica quirúrgica en una aplicación aislada, la nueva solución se integra con los servicios existentes y utiliza mecanismos de coordinación para acciones que cruzan límites de dominio. Esto permite conservar la modularidad de la plataforma y, al mismo tiempo, disponer de puntos explícitos para ejecutar flujos de negocio.

  Junto a los microservicios de dominio, la plataforma también cuenta con servicios que cumplen funciones de coordinación más específicas. Un caso relevante para el proceso quirúrgico es el servicio `hegc`, que integra información proveniente de Gestión Hospitales con servicios de Lahuén como salud, personas y agenda. Esta forma de coordinación es más imperativa y acoplada al caso de uso, pero resulta necesaria cuando el origen de datos pertenece a una plataforma separada, con base de datos y lógica propia.

  == Arquitectura frontend: web_app, worklists y plugins

  En el frontend, la plataforma utiliza una arquitectura basada en una estructura común de aplicación web, denominada `web_app`, sobre la cual se construyen aplicaciones especializadas. En el caso del módulo quirúrgico modernizado, la interfaz se organiza como una aplicación de listas de trabajo, o `worklists`, extendida mediante plugins. Esta estructura permite separar el esqueleto común de la aplicación, los componentes reutilizables y la lógica particular de cada módulo.

  La nueva vista de proceso quirúrgico se construye utilizando Vue 2, framework progresivo para construir interfaces de usuario basadas en componentes @Vue2Docs. En la arquitectura revisada, la aplicación de lista de trabajo define elementos comunes como navegación, banner, panel lateral, filtros, grilla, acciones y actualización periódica de datos. Sobre esa base, los plugins incorporan comportamiento específico del dominio quirúrgico, tales como vistas, formularios, acciones disponibles para cada paciente y criterios de actualización.

  #figure(
    image("./imagenes/diagrama-web_app-plugins.png", width: 100%),
    caption: "Estructura simplificada de la arquitectura frontend basada en web_app, worklists y plugins.",
  )

  Esta separación tiene dos ventajas para el trabajo. Primero, permite reutilizar componentes ya existentes de la plataforma, reduciendo duplicación de código y manteniendo una experiencia consistente con otros módulos. Segundo, facilita aislar la lógica particular del proceso quirúrgico en plugins especializados, evitando que el flujo clínico quede mezclado con la infraestructura común de la aplicación. Esta distinción es relevante porque uno de los objetivos de la modernización es mejorar la mantenibilidad del frontend respecto de la versión anterior.

  == Procesos de negocio y workflows

  Un proceso quirúrgico no corresponde a una única operación puntual. Se trata de un flujo de larga duración compuesto por eventos, decisiones, esperas, excepciones y cambios de estado. Además, el proceso tiene hitos clínicos relevantes. La lista de verificación de seguridad quirúrgica de la Organización Mundial de la Salud, por ejemplo, estructura la operación en momentos antes de la inducción anestésica, antes de la incisión y antes de que el paciente salga del quirófano @WHO2009Checklist. Aunque este trabajo no implementa directamente esa lista como protocolo clínico, sí muestra que el dominio quirúrgico se organiza naturalmente alrededor de hitos verificables y secuencias controladas.

  En sistemas de microservicios, existen dos formas comunes de coordinar este tipo de procesos: coreografía y orquestación. En una coreografía, los servicios reaccionan a eventos y cada uno decide localmente qué hacer. En una orquestación, existe un componente que coordina explícitamente la secuencia de actividades. La coreografía reduce dependencias directas, pero puede dificultar la observación global del proceso cuando el flujo queda distribuido entre múltiples servicios. La orquestación, en cambio, permite representar el proceso de forma más explícita y facilita entender qué actividades se ejecutaron, cuáles fallaron y en qué estado se encuentra una instancia @NadeemM2022.

  Para el caso del módulo quirúrgico, la orquestación resulta adecuada porque muchas acciones requieren una secuencia definida y trazable. La recepción de un paciente, el avance de hitos intraoperatorios, la suspensión de una cirugía o la creación de tareas asociadas al protocolo operatorio son ejemplos de acciones donde importa el orden, el resultado de pasos previos y el estado final del proceso. Por ello, la modernización reemplaza el motor de procesos propietario por una solución basada en workflows ejecutados sobre Temporal.

  == Temporal como runtime de workflows

  Temporal es una plataforma para ejecutar workflows durables, diseñada para coordinar procesos de negocio que pueden involucrar llamadas a servicios, reintentos, esperas y fallas parciales @TemporalDocs. En Temporal, un workflow define la lógica de coordinación, mientras que las actividades encapsulan operaciones que pueden interactuar con sistemas externos. Los workers son procesos que registran workflows y actividades, consumen tareas desde una cola de trabajo y ejecutan el código correspondiente. Para PHP, Temporal provee un SDK específico que permite implementar workflows y workers en ese lenguaje @TemporalPHPDocs.

  La principal ventaja de Temporal para este proyecto es que permite separar la lógica de coordinación de las operaciones concretas realizadas por los microservicios. El workflow puede representar la secuencia general y delegar en actividades las llamadas HTTP, transformaciones, validaciones o actualizaciones necesarias. Además, Temporal mantiene historial de ejecución y estado durable, lo que ayuda a observar y depurar procesos distribuidos. Esta característica es relevante en microservicios, donde los errores de interacción entre servicios suelen ser difíciles de diagnosticar cuando el flujo no está representado de manera explícita @NadeemM2022.

  En la arquitectura de Lahuén, los workflows de Temporal se implementan utilizando PHP y el SDK de Temporal para ese lenguaje. Estos workflows y sus actividades son registrados por workers, que consumen tareas desde una cola de trabajo y ejecutan el código correspondiente. De este modo, la ejecución del proceso queda fuera del frontend y de los microservicios de dominio, pero puede invocar a estos servicios cuando una actividad lo requiere.

  La instanciación de workflows se centraliza en el microservicio BPM. Esto puede ocurrir mediante llamadas directas a su API o mediante suscripciones configuradas en la base de datos de BPM, que permiten iniciar workflows a partir de eventos definidos por la plataforma. En el caso específico de las orquestaciones dinámicas, se incorporó un endpoint en el servicio BPM que permite iniciar estas ejecuciones mediante llamadas `POST`. Así, BPM actúa como puerta de entrada para iniciar workflows de Temporal, mientras que los workers se encargan de procesarlos.

  == Coordinación mediante eventos, BPM y SSE

  Dentro de la solución, el microservicio BPM cumple el rol de punto de integración para procesos. Su responsabilidad no es reemplazar a todos los servicios de dominio, sino ofrecer un mecanismo común para iniciar workflows de Temporal. En términos prácticos, el frontend o un servicio de la plataforma puede solicitar la ejecución de una acción de negocio; BPM recibe la solicitud, instancia el workflow correspondiente y deja su ejecución a cargo de Temporal y de los workers registrados.

  La plataforma también utiliza mecanismos de mensajería para comunicar eventos entre componentes. En los proyectos relevantes aparecen eventos de dominio asociados, por ejemplo, a cambios en citas, atenciones, indicaciones o evaluaciones. Estos eventos se publican en tópicos Kafka y contienen información suficiente para que otros componentes reaccionen sin acoplarse directamente al servicio que produjo el cambio. Por ejemplo, cuando una atención cambia de estado, el servicio de salud puede emitir un evento que informa el paciente, la atención, el tipo de atención, el estado y el tipo de operación realizada.

  Estos eventos pueden ser utilizados de dos maneras relevantes para este trabajo. Primero, BPM puede escuchar eventos mediante suscripciones configuradas en base de datos. Cada suscripción define el tópico, filtros y una transformación que permite iniciar un workflow de Temporal o una orquestación dinámica cuando ocurre una condición de negocio. Segundo, el servicio de eventos `sseservice` puede consumir eventos Kafka y entregarlos al frontend mediante Server-Sent Events. En la nueva lista de trabajo quirúrgica, esto permite reaccionar ante cambios en atenciones, citas, indicaciones o evaluaciones, actualizando la vista con menor latencia y mejorando la coordinación operativa.

  Esta combinación permite separar tres tipos de comunicación. Los eventos comunican que algo ocurrió en el sistema y permiten que otros componentes reaccionen. Las suscripciones BPM convierten ciertos eventos en inicios de procesos. Los workflows, en cambio, coordinan acciones que deben ejecutarse como parte de un flujo durable. En el módulo quirúrgico estas ideas conviven: algunos cambios se publican como eventos de negocio, algunos eventos gatillan workflows y ciertas acciones críticas se ejecutan mediante orquestaciones explícitas.

  == Orquestaciones dinámicas y DSL

  Dentro de Temporal, el trabajo incorpora un workflow particular llamado orquestador dinámico. Este workflow está implementado en PHP y su función es interpretar orquestaciones definidas como configuraciones. En vez de crear un workflow distinto para cada acción de negocio, el orquestador dinámico recibe una lista de actividades y un objeto de entrada, o bien un identificador que permite obtener la definición desde la base de datos. Luego ejecuta esa definición como una secuencia de instrucciones simples, tales como llamadas HTTP, asignaciones de valores, condiciones de ejecución y mapeos de datos entre respuestas previas y pasos posteriores.

  Este enfoque se relaciona con el uso de lenguajes específicos de dominio, o DSL, para modelar problemas recurrentes con abstracciones cercanas al dominio. En arquitecturas de microservicios, los DSL pueden ayudar a describir componentes, conexiones y reglas de ejecución de manera más modular y comprensible, reduciendo parte de la complejidad accidental del sistema @SolisCK2025. En este caso, el workflow del orquestador dinámico funciona como un intérprete de un DSL simple: las orquestaciones almacenadas como configuración describen qué instrucciones ejecutar y el workflow de Temporal interpreta esa definición en tiempo de ejecución. De forma similar, los workflows guiados por datos permiten que ciertas decisiones de ejecución dependan de la estructura y contenido de los mensajes o configuraciones, moviendo parte de la lógica desde código rígido hacia definiciones interpretadas en tiempo de ejecución @SafinaMM2015.

  En este proyecto, el DSL de orquestación no reemplaza a Temporal ni existe separado de él como motor independiente. Temporal entrega el runtime durable, el historial de ejecución y el mecanismo de workers; el orquestador dinámico, implementado como workflow de Temporal, interpreta las configuraciones que indican qué actividades se deben ejecutar, con qué datos, en qué orden y bajo qué condiciones. Esta separación permite reutilizar el mismo workflow base para distintas acciones del módulo quirúrgico, cambiando la definición almacenada en base de datos en lugar de crear una implementación específica para cada caso.

  Conceptualmente, el orquestador dinámico actúa como un workflow genérico capaz de interpretar orquestaciones configurables. Recibe un identificador de orquestación y parámetros de entrada, valida esos parámetros contra un esquema, carga la secuencia de actividades y ejecuta cada paso. Las actividades pueden realizar llamadas HTTP a servicios de la plataforma, asignar valores intermedios y utilizar resultados de pasos anteriores. Así, una acción de negocio compleja puede expresarse como una configuración declarativa, pero ejecutarse sobre la infraestructura durable de Temporal.

  La ventaja práctica de este enfoque es que muchas acciones del proceso quirúrgico no requieren implementar nueva lógica de negocio desde cero, sino conectar capacidades ya existentes en distintos servicios. Si una acción consiste en validar una entrada, consultar datos, crear o actualizar registros en microservicios diferentes y encadenar respuestas, una orquestación dinámica puede expresar esa secuencia con menor costo de desarrollo y menor repetición de código que un workflow específico para cada caso.

  == Servicios orquestadores de dominio

  No toda coordinación de la plataforma se resuelve mediante Temporal. En la arquitectura existente también hay servicios de dominio que cumplen un rol orquestador cuando deben integrar sistemas o bases de datos externas. Para el proceso quirúrgico, el caso más importante es el servicio `hegc`, que contiene lógica para relacionar Gestión Hospitales con componentes de Lahuén.

  Gestión Hospitales es una plataforma separada, desarrollada previamente para apoyar la gestión de listas de espera. Tiene su propia base de datos y su propia lógica interna. Como la programación quirúrgica se origina en esa plataforma, iniciar el proceso quirúrgico en Lahuén requiere importar información de los pacientes programados para el día y vincularla con datos clínicos, personas, agenda y recursos. En términos arquitectónicos, esto obliga a coordinar información proveniente de Gestión Hospitales, `hlth`, `xrm` y `agenda`.

  El servicio `hegc` resuelve este tipo de integración mediante clases PHP que llaman a otros servicios y construyen las estructuras necesarias para la plataforma. Este enfoque permite resolver integraciones específicas, como la creación de citas de agenda a partir de órdenes quirúrgicas, la finalización de una cirugía o la suspensión de una orden. Sin embargo, también tiene limitaciones: la lógica queda codificada en una clase concreta, los cambios de datos requieren modificar código y la coordinación queda más acoplada al caso de uso que en una orquestación declarativa. Por esta razón, en el desarrollo fue necesario modificar este servicio cuando cambió la forma de importar los datos quirúrgicos.

  == Relación con la modernización del módulo quirúrgico

  La modernización del módulo quirúrgico se apoya en esta arquitectura para resolver un problema específico: conservar el flujo funcional de la versión anterior, pero implementarlo con una base más mantenible. En el frontend, la vista quirúrgica se construye como una aplicación Vue 2 basada en listas de trabajo y plugins. En el backend, se reutilizan microservicios PHP existentes para consultar y modificar información clínica, de agenda y de proceso. En la capa de procesos, BPM permite instanciar workflows de Temporal, ya sea mediante llamadas a su API o mediante suscripciones configuradas. Para las acciones desarrolladas en la nueva atención quirúrgica, el mecanismo usado corresponde a orquestaciones dinámicas: configuraciones almacenadas que son ejecutadas por el workflow de orquestador dinámico en Temporal.

  Esta organización permite distinguir responsabilidades. La interfaz presenta pacientes, estados y acciones disponibles, y puede recibir eventos mediante `sseservice` para actualizarse oportunamente. Los microservicios de dominio ejecutan operaciones sobre datos clínicos y administrativos. Kafka comunica eventos de negocio. BPM inicia workflows directamente o como reacción a eventos. Temporal asegura la ejecución durable. Los workers procesan workflows y actividades. El workflow de orquestador dinámico interpreta las configuraciones que describen la secuencia concreta de instrucciones para cada acción quirúrgica configurable. Finalmente, el servicio `hegc` cubre integraciones específicas con Gestión Hospitales que requieren coordinar datos externos antes de incorporarlos al flujo quirúrgico.

  En consecuencia, la arquitectura tecnológica escogida no debe entenderse como un catálogo de herramientas, sino como una forma de separar responsabilidades que antes estaban más acopladas. Esta separación permite conservar el flujo quirúrgico existente, integrar sistemas y servicios ya disponibles, y trasladar la coordinación de acciones complejas hacia mecanismos más explícitos y mantenibles. Sobre esta base, los capítulos siguientes traducen el problema en requerimientos, diseño e implementación de la nueva solución.
]

#capitulo(title: "Análisis del problema y requerimientos")[
  Este capítulo traduce la situación descrita en los capítulos anteriores en un conjunto de necesidades concretas para la nueva versión del módulo de atención quirúrgica. El problema abordado no corresponde a la ausencia de un flujo quirúrgico, sino a la necesidad de reconstruir un flujo ya validado sobre una base técnica más mantenible, más integrada con la plataforma actual y capaz de reaccionar oportunamente a los cambios que ocurren durante la operación clínica.

  La definición de requerimientos se realizó durante el desarrollo del proyecto, en reuniones de trabajo con los supervisores. Uno de ellos cumplía un rol principalmente técnico y conocía tanto la plataforma como el flujo quirúrgico anterior; el otro aportaba una visión más cercana al negocio y al funcionamiento operativo del proceso. A partir de reuniones de avance, discusiones técnicas y revisión de cada problema funcional, se fueron definiendo las tareas necesarias para reconstruir partes del flujo anterior con herramientas nuevas. En este sentido, los requerimientos no surgieron como una revisión posterior del código desarrollado, sino como acuerdos progresivos de trabajo que guiaron la implementación diaria.

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

  La cuarta necesidad era mejorar la reactividad operacional. La lista de trabajo quirúrgica debía poder recibir eventos relevantes y actualizarse cuando cambiaran las entidades que componen la atención quirúrgica. Esto implicaba integrar el frontend con un canal persistente de eventos, implementado en la plataforma mediante `sseservice`, y mejorar los filtros para que una suscripción pudiera recibir eventos asociados a listas de valores, no solo a valores únicos.

  La quinta necesidad era mejorar la experiencia de uso sin alterar de manera innecesaria el flujo conocido. Además de reconstruir las acciones existentes, la nueva lista de trabajo debía incorporar mejoras acotadas que ayudaran a los usuarios en situaciones operacionales concretas. Entre ellas se consideraron la posibilidad de revertir un ingreso accidental a pabellón y el registro digital de cuidados intraoperatorios desde el mismo flujo de trabajo. Esta última necesidad fue definida por el hospital, que requería completar esa información durante la atención y evitar depender de formularios en papel para registrarla. Estas capacidades no correspondían al núcleo histórico del proceso, pero sí permitían hacer más útil la nueva versión para el trabajo diario de los equipos clínicos.

  == Requerimientos funcionales del flujo quirúrgico

  El requerimiento funcional principal fue reconstruir el flujo de atención quirúrgica sobre la nueva lista de trabajo. Esto implicaba soportar los dos orígenes principales del proceso: solicitudes de urgencia y atenciones electivas programadas. En el primer caso, el flujo comienza con una indicación quirúrgica originada desde urgencia. En el segundo, el flujo comienza con una programación proveniente de la lista de espera y de Gestión Hospitales, que debe ser importada a la Plataforma Lahuén como una cita de Agenda.

  Para las atenciones electivas, se requirió importar datos desde Gestión Hospitales hacia la nueva versión. Esta importación debía transformar órdenes quirúrgicas externas en información usable por la plataforma: pacientes, profesionales, diagnósticos, intervenciones, pabellón, modalidad de atención, servicio de origen, ubicación de origen y datos administrativos de la orden. Para ello fue necesario modificar el servicio `hegc`, agregando una acción capaz de crear citas de Agenda a partir de información de Gestión Hospitales y vincular esas citas con los datos necesarios para el proceso quirúrgico.

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

  Por esta razón, se definió como requerimiento contar con orquestaciones dinámicas ejecutadas desde BPM y Temporal. Cada orquestación debía recibir parámetros, validarlos contra un esquema, cargar una definición de actividades, resolver datos mediante rutas, ejecutar condiciones y llamar a servicios de la plataforma. Este mecanismo debía permitir acciones como aceptar una orden de urgencia, recepcionar pacientes, finalizar recuperación, iniciar traslado, devolver a unidad de origen, suspender, finalizar una atención, crear tareas BPM para completar protocolo quirúrgico y operar una orden en Gestión Hospitales cuando corresponde.

  El orquestador dinámico debía soportar encadenamiento de respuestas. Muchas acciones requieren que el resultado de una llamada sea usado por la siguiente: por ejemplo, consultar una cita para obtener participantes, buscar un clínico, crear o iniciar una atención y luego actualizar datos extendidos. Por lo tanto, la definición de orquestaciones debía permitir referencias a respuestas previas, asignaciones intermedias, valores por defecto, transformaciones de tipos, condiciones de ejecución y construcción de cuerpos de solicitud.

  También se requirió que el mecanismo fuera reutilizable. El objetivo no era construir un nuevo motor de procesos propietario, sino un workflow genérico de Temporal capaz de interpretar definiciones configurables para acciones acotadas. Esta decisión permite que nuevas acciones simples o medianamente complejas puedan agregarse cambiando configuraciones y no necesariamente escribiendo un workflow nuevo para cada caso.

  == Requerimientos de eventos y actualización de la interfaz

  La lista de trabajo quirúrgica debía reaccionar ante cambios realizados por otros componentes de la plataforma. Para ello, se requirió escuchar eventos de negocio relacionados con atenciones, indicaciones, citas y evaluaciones. Estos eventos son necesarios porque el proceso quirúrgico no ocurre solo dentro de una pantalla: un cambio puede originarse desde Agenda, EHR, HLTH, BPM, una acción de otro usuario o una integración externa.

  En la práctica, la interfaz debía conectarse a un canal persistente de eventos hacia frontend. Aunque conceptualmente este requerimiento corresponde a una comunicación tipo WebSocket o tiempo real, la implementación de la plataforma se apoya en `sseservice`, que entrega eventos mediante Server-Sent Events. Lo importante desde el punto de vista del requerimiento es que la lista pueda suscribirse a eventos relevantes y actualizar la grilla cuando cambie una entidad asociada al flujo quirúrgico.

  Los filtros de eventos debían ser suficientemente expresivos para evitar recargas innecesarias. Durante el desarrollo se identificó que los filtros existentes eran limitados, porque permitían comparar contra valores únicos, pero no contra listas de valores. Para el flujo quirúrgico esto era insuficiente: una lista de trabajo puede necesitar escuchar varios pacientes, varias citas, varias atenciones o varios tipos de eventos. Por ello se incorporó como requerimiento que el servicio de eventos permitiera filtros con listas, de modo que un cliente pudiera recibir eventos que coincidieran con cualquiera de los valores relevantes.

  Además, el frontend debía evitar recargas excesivas. En un sistema basado en eventos, una misma acción puede generar varios eventos consecutivos. Por lo tanto, la lista de trabajo debía aplicar mecanismos como debounce para agrupar actualizaciones y evitar que la interfaz se recargara múltiples veces de forma innecesaria. Este requerimiento se relaciona tanto con rendimiento como con experiencia de usuario.

  Los eventos también debían habilitar acciones automáticas en BPM. Algunas suscripciones configuradas en `event_subscription` permiten iniciar orquestaciones dinámicas al ocurrir eventos relevantes. Por ejemplo, al crearse una atención quirúrgica puede generarse una tarea para completar el protocolo; al guardarse el protocolo puede completarse una tarea BPM y operar la orden en Gestión Hospitales; al finalizar un traslado puede finalizarse la atención quirúrgica; y al finalizar una atención quirúrgica puede notificarse o actualizarse Gestión Hospitales. Estos requerimientos muestran que los eventos no solo actualizan la interfaz, sino que también coordinan efectos posteriores del proceso.

  == Requerimientos de documentos y formularios clínicos

  El proceso quirúrgico incluye documentos y evaluaciones clínicas que pertenecen a la ficha del paciente. Entre ellos se encuentran evaluación preanestésica, protocolo quirúrgico, pausas quirúrgicas y cuidados intraoperatorios. Por ello, la nueva lista de trabajo no podía implementar formularios aislados sin integración con EHR. Debía existir una forma de abrir formularios de la ficha desde el módulo quirúrgico, manteniendo la relación con la atención del paciente y con los tipos de evaluación correspondientes.

  Para resolver esto, se requirió cargar formularios de la aplicación EHR desde la lista quirúrgica, utilizando una integración embebida mediante `iframe`. Este enfoque permite reutilizar capacidades de la ficha clínica y mantener los documentos dentro del sistema donde pertenecen. Al mismo tiempo, exigió crear o mejorar formularios, estilos, datos precargados y lógica específica para el flujo quirúrgico.

  Los formularios debían corresponder a nuevas versiones de documentos previos, conservando su objetivo clínico pero adaptándolos a la nueva arquitectura. La evaluación preanestésica debía cargar datos del paciente y de la cirugía; el protocolo quirúrgico debía precargar información del proceso y permitir generar documento; las pausas quirúrgicas debían representarse como secciones de checklist de seguridad; y los cuidados intraoperatorios debían registrarse como evaluación asociada al caso cuando correspondiera.

  También se requirió controlar la disponibilidad de cada evaluación por estado. No todos los documentos tienen sentido en cualquier momento del proceso. Por ejemplo, la evaluación preanestésica debe estar disponible antes del ingreso a pabellón, las pausas quirúrgicas durante el avance intraoperatorio y el protocolo quirúrgico durante o después de la intervención. Esta regla evita que los usuarios ejecuten acciones fuera de contexto y ayuda a mantener consistencia clínica.

  == Requerimientos de experiencia de usuario

  La nueva aplicación debía integrarse a la experiencia visual y operacional del hospital donde se implementa. Esto incluye utilizar el estilo característico del establecimiento, colores, banner, iconografía, distribución de columnas y mensajes coherentes con el resto de la plataforma. La modernización no debía percibirse como una herramienta aislada, sino como una evolución natural del sistema usado por los equipos clínicos.

  La grilla principal debía presentar información suficiente sin sobrecargar al usuario. Para ello se requirió ordenar acciones, limitar la cantidad de acciones expuestas directamente y mover acciones secundarias a menús adicionales. También se requirió mejorar columnas como programación, ubicación, estado e intervenciones, de modo que el usuario pudiera comprender rápidamente qué ocurre con cada paciente.

  Los mensajes de confirmación y error debían ser operacionales. En una interfaz clínica, mostrar respuestas técnicas de API puede confundir al usuario y dificultar la resolución de problemas. Por ello se requirió entregar mensajes orientados a la acción, indicando qué ocurrió, qué no se pudo realizar y, cuando corresponde, qué paciente, ubicación o etapa está involucrada.

  Algunas capacidades nuevas responden directamente a requerimientos de experiencia de usuario y apoyo operacional. La acción de revertir ingreso a pabellón permite corregir un ingreso accidental sin tratarlo como suspensión ni requerir soporte técnico o manipulación manual de datos. El formulario de cuidados intraoperatorios, por su parte, responde a una necesidad definida por el hospital: completar y registrar digitalmente esa información durante la intervención, reduciendo la dependencia de registros en papel. Ambas mejoras son acotadas, pero contribuyen a que la nueva lista sea más práctica para los equipos que operan el proceso.

  == Requerimientos no funcionales

  La mantenibilidad fue uno de los requerimientos no funcionales principales. La solución debía reducir el acoplamiento entre frontend, motor de procesos y reglas de negocio. Para ello, se requería un modelo explícito de estados y acciones, adaptadores de datos por fuente, servicios de dominio reutilizables y orquestaciones configurables para acciones complejas. Esta separación permite modificar una parte del sistema sin afectar innecesariamente las demás.

  La extensibilidad también era esencial. El módulo quirúrgico debía quedar preparado para incorporar nuevos estados, acciones, formularios, eventos o integraciones. Esto se relaciona con el uso de registros de estados y acciones en frontend, con la capacidad del orquestador dinámico para ejecutar nuevas definiciones y con la reutilización de componentes compartidos de la plataforma.

  La interoperabilidad fue otro requisito clave. La solución debía integrarse con Gestión Hospitales, Agenda, HLTH, EHR, BPM, Temporal, `sseservice` y los mecanismos de eventos de la plataforma. Esta integración debía hacerse sin concentrar toda la lógica en un único componente, respetando las responsabilidades de cada servicio.

  La trazabilidad debía mejorar respecto de la versión anterior, especialmente en el registro de fechas y horas de hitos relevantes del proceso. El sistema debía conservar información sobre recepción, ingreso a pabellón, hitos de anestesia y cirugía, recuperación, traslado, egreso y otros momentos clínico-operativos. Esta trazabilidad permite reconstruir el recorrido del paciente y apoyar análisis posteriores. Sin embargo, el alcance del trabajo no resuelve completamente toda la auditoría posible del proceso. Aún existen mejoras futuras, como registrar de manera más sistemática quién ejecuta cada acción y cubrir hitos que se producen como reacción a eventos y no siempre quedan guardados con el mismo nivel de detalle.

  La continuidad operacional fue una restricción transversal. El módulo debía integrarse con una plataforma existente y con procesos reales del hospital. Por ello, la modernización debía preservar el comportamiento esperado por los usuarios, evitar rupturas innecesarias con el flujo anterior y permitir ajustes progresivos durante la puesta en marcha.

  Finalmente, la confidencialidad y el resguardo de información interna condicionan la forma de documentar e implementar la solución. El informe describe la arquitectura, los requerimientos y las decisiones principales sin exponer detalles sensibles que no son necesarios para comprender el aporte técnico del trabajo.

  == Síntesis de requerimientos

  En síntesis, la nueva versión del módulo de atención quirúrgica debía cumplir con los siguientes requerimientos principales:

  - Conservar el flujo quirúrgico funcional de la versión previa, incluyendo estados, acciones, hitos y documentos relevantes.
  - Soportar atenciones originadas tanto en solicitudes de urgencia como en programaciones electivas.
  - Importar datos desde Gestión Hospitales mediante el servicio `hegc` y representarlos como citas quirúrgicas de Agenda.
  - Normalizar información proveniente de indicaciones, citas y atenciones de pacientes en una única representación de atención quirúrgica.
  - Ejecutar acciones del proceso quirúrgico desde la lista de trabajo, manteniendo comportamiento equivalente para los usuarios.
  - Incorporar la acción de revertir ingreso a pabellón como mejora operacional para corregir errores frecuentes.
  - Reemplazar la dependencia del motor de procesos propietario por orquestaciones dinámicas ejecutadas mediante BPM y Temporal.
  - Permitir que las orquestaciones validen entradas, llamen a múltiples servicios, usen respuestas previas y ejecuten condiciones.
  - Escuchar eventos relevantes en el frontend mediante un canal persistente de eventos y actualizar la grilla con menor latencia.
  - Mejorar los filtros de eventos para aceptar listas de valores y reducir eventos irrelevantes.
  - Reaccionar a eventos desde BPM para ejecutar orquestaciones dinámicas asociadas a tareas, protocolo, traslados y cierre de atenciones.
  - Integrar formularios clínicos de EHR mediante una carga embebida y adaptar evaluación preanestésica, pausas quirúrgicas, protocolo y cuidados intraoperatorios.
  - Aplicar el estilo visual del hospital y mejorar la experiencia de uso de la grilla, acciones, mensajes y filtros.
  - Registrar fechas de hitos relevantes del flujo quirúrgico, dejando la auditoría completa de responsables y algunos hitos automáticos como trabajo futuro.
  - Mantener una arquitectura extensible, interoperable y compatible con la continuidad operacional de la plataforma.

  Estos requerimientos establecen el puente entre el diagnóstico del problema y el diseño de la solución. La siguiente etapa consiste en explicar cómo se organizaron los componentes de frontend, backend, eventos y orquestación para satisfacer estas necesidades sin reconstruir un motor de procesos propietario, pero conservando el flujo quirúrgico que la plataforma ya había validado en su operación.
]

#capitulo(title: "Diseño de la solución")[
  Este capítulo presenta el diseño de la solución propuesta para modernizar el módulo de atención quirúrgica. A diferencia del capítulo anterior, que identifica los problemas y requerimientos, aquí se describe cómo se organiza el nuevo flujo desde una perspectiva funcional y arquitectónica: cómo ingresan los casos quirúrgicos, cómo se muestran en la lista de trabajo, cómo se ejecutan las acciones principales y qué resultados produce cada etapa.

  La idea central del diseño es separar el flujo quirúrgico de los detalles de ejecución técnica. La solución no busca que el frontend conozca todos los pasos internos de cada acción, ni que un motor de procesos propietario mantenga todo el estado del caso. En cambio, la atención quirúrgica se representa a partir de entidades de dominio, se muestra en una lista de trabajo especializada y utiliza servicios de la plataforma para ejecutar acciones, registrar hitos, recibir eventos y coordinar operaciones complejas cuando es necesario.

  == Visión general de la solución

  La solución se diseñó como una reconstrucción del flujo quirúrgico existente sobre la arquitectura actual de la Plataforma Lahuén. El flujo completo comienza con una entrada quirúrgica, continúa con la representación del caso en una lista de trabajo, permite ejecutar acciones clínicas y operacionales, actualiza entidades de dominio y termina con el cierre, traslado, egreso o suspensión del proceso. En todo momento, la lista de trabajo debe presentar una visión unificada del paciente quirúrgico, independiente de si su origen fue una solicitud de urgencia, una programación electiva o una atención ya iniciada.

  El diseño considera dos vías principales de entrada. La primera corresponde a solicitudes quirúrgicas de urgencia, originadas como indicaciones clínicas. Estas solicitudes se muestran inicialmente como casos solicitados y pueden ser aceptadas para crear una cita quirúrgica y avanzar hacia la atención. La segunda corresponde a cirugías electivas programadas, cuyo origen se encuentra en Gestión Hospitales y que deben importarse a Lahuén como citas de Agenda. En ambos casos, el objetivo es transformar datos de origen distintos en una representación común de atención quirúrgica.

  Una vez que el caso aparece en la lista de trabajo, el usuario interactúa con acciones disponibles según el estado del paciente. Algunas acciones son simples y pueden resolverse mediante una llamada directa a un servicio. Otras requieren coordinar varias operaciones, como consultar datos, crear o actualizar una cita, iniciar una atención, cambiar ubicación, registrar hitos o crear tareas. Para estas acciones, el diseño utiliza orquestaciones dinámicas ejecutadas a través de BPM y Temporal. De este modo, la interfaz inicia la acción, pero no queda acoplada a la secuencia exacta de pasos técnicos.

  La solución también incorpora eventos como mecanismo de actualización. Cuando cambian citas, indicaciones, atenciones o evaluaciones, los servicios de la plataforma pueden emitir eventos de negocio. Estos eventos son consumidos por el servicio `sseservice`, que los entrega al frontend para actualizar la lista de trabajo, y por BPM, que puede iniciar orquestaciones cuando se cumple una condición. Así, el flujo no depende exclusivamente de acciones manuales realizadas en una pantalla, sino que puede reaccionar ante cambios producidos en otros componentes de la plataforma.

  == Entradas del flujo quirúrgico

  El primer elemento de diseño fue definir cómo ingresa un caso a la nueva lista de trabajo quirúrgica. La versión anterior obtenía parte de esta información desde instancias del motor de procesos propietario. En la nueva solución, la información se obtiene desde entidades explícitas y servicios existentes.

  Para solicitudes de urgencia, la entrada principal es una indicación quirúrgica. La lista de trabajo consulta indicaciones relevantes, obtiene datos del paciente, ubicación, intervenciones y diagnósticos, y construye una atención quirúrgica en estado solicitado. Desde ese estado, el usuario puede aceptar la orden. La aceptación transforma la solicitud en una cita quirúrgica de urgencia y deja al caso preparado para continuar el flujo operativo. Este diseño evita importar la solicitud a una instancia opaca de proceso y permite que la información clínica provenga directamente de la entidad que la origina.

  Para cirugías electivas, la entrada principal es una orden proveniente de Gestión Hospitales. Como ese sistema no pertenece directamente a la Plataforma Lahuén, se diseñó una acción en el servicio `hegc` capaz de importar la información necesaria y crear una cita de Agenda. Esta cita representa la cirugía programada dentro de Lahuén. La importación considera datos del paciente, profesional responsable, pabellón, intervención, diagnóstico, modalidad de atención, servicio de origen, ubicación de origen y datos administrativos de la orden. De esta manera, la programación electiva queda disponible para el flujo quirúrgico sin depender de una instancia del motor de procesos propietario.

  La tercera fuente son las atenciones de pacientes ya iniciadas. Una vez que un paciente es recepcionado o su atención quirúrgica está en curso, la información principal deja de ser solo una indicación o una cita y pasa a estar representada en una atención clínica del dominio HLTH. Esta atención almacena estado, ubicación, hitos, evaluaciones asociadas y datos extendidos del proceso quirúrgico. Por ello, la lista de trabajo debe combinar las tres fuentes: indicaciones, citas y atenciones.

  == Modelo unificado de atención quirúrgica

  Para ocultar la complejidad de las fuentes de datos, el diseño introduce un modelo unificado de atención quirúrgica en el frontend. Este modelo no reemplaza a las entidades backend; funciona como una representación de lectura y operación para la lista de trabajo. Su responsabilidad es adaptar información heterogénea y exponerla como una fila coherente para el usuario.

  La atención quirúrgica unificada contiene datos administrativos, clínicos y operacionales. Entre ellos se incluyen paciente, documento, nombre social, programación, ubicación actual, ubicación de origen, responsable, intervenciones, diagnósticos, evaluaciones, tipo de origen, estado, acciones disponibles e identificadores necesarios para operar sobre la entidad real. La misma estructura puede representar una indicación solicitada, una cita programada o una atención ya iniciada.

  Este diseño permite que la grilla principal se mantenga simple desde el punto de vista de interacción. El usuario ve una lista de pacientes quirúrgicos, no tres listas separadas por fuente de datos. Internamente, cada fila conserva su origen para que las acciones sepan si deben operar sobre Agenda, HLTH, indicaciones u otro servicio. Esta separación reduce el acoplamiento entre la interfaz y los servicios de dominio.

  El modelo también permite aplicar reglas comunes de visualización. Por ejemplo, la columna de programación puede mostrar fecha, hora, responsable y pabellón; la columna de ubicación puede mostrar domicilio, sala de espera, cupo, área u otra unidad; y la columna de intervenciones puede priorizar procedimientos quirúrgicos por sobre diagnósticos secundarios. Esto era necesario porque la información proveniente de Gestión Hospitales, Agenda, indicaciones y atenciones no siempre posee la misma estructura.

  == Flujo funcional de la atención quirúrgica

  El flujo funcional se diseñó como una secuencia de estados con acciones habilitadas según el momento clínico-operativo del paciente. La solución no define un flujo estrictamente lineal, porque el proceso quirúrgico admite reprogramaciones, suspensiones, traslados, egresos, retornos a unidad de origen y acciones documentales. Sin embargo, sí existe una progresión general que permite ordenar la operación.

  En el caso de urgencia, el flujo comienza con una atención solicitada. El usuario acepta la orden y programa los datos necesarios para crear una cita quirúrgica. Luego el paciente puede ser recepcionado, ingresado a pabellón, avanzar por hitos intraoperatorios, iniciar recuperación y finalizar recuperación. Después de la recuperación, el paciente puede quedar esperando alta, esperando traslado o esperando egreso, dependiendo de su modalidad y destino. Finalmente, el caso termina cuando se finaliza la atención, se traslada al paciente a la unidad correspondiente o se registra el egreso.

  En el caso electivo, el flujo comienza con una cita programada importada desde Gestión Hospitales. Antes de la admisión, el caso se muestra como programado y permite acciones como reagendar, suspender o completar evaluación preanestésica. Una vez admisionado, el paciente queda en espera y puede continuar con recepción, ingreso a pabellón, hitos intraoperatorios, recuperación y cierre. El diseño separa el origen electivo de la modalidad del paciente: una cirugía electiva puede ser ambulatoria o requerir hospitalización, por lo que el cierre debe considerar egreso, traslado o continuidad asistencial según corresponda.

  Para ambos flujos, la lista de trabajo debe reflejar estados comprensibles para los usuarios. Entre los estados principales se consideran solicitada, programada, en espera, preoperatorio, en pabellón, en recuperación, esperando alta, esperando traslado, esperando egreso, en tránsito, finalizada y suspendida. Estos estados no solo sirven para mostrar una etiqueta; también determinan qué acciones se pueden ejecutar, qué documentos están disponibles y qué mensajes deben aparecer en la grilla.

  El diseño también contempla acciones de corrección y excepción. La suspensión permite detener una cirugía registrando causa, subcausa y observación. El reagendamiento permite modificar una programación sin perder participantes relevantes de la cita. El cambio de ubicación permite actualizar el cupo o área del paciente. La reversa de ingreso a pabellón permite corregir una acción ejecutada por error, devolviendo al paciente a preoperatorio y restaurando una ubicación válida. Estas acciones son importantes porque el flujo real no siempre avanza de forma ideal.

  == Diseño de acciones y resultados

  Cada acción de la lista de trabajo se diseñó como una operación con tres partes: condición de disponibilidad, interacción con el usuario y efecto sobre el sistema. La condición de disponibilidad define si la acción puede mostrarse o ejecutarse en el estado actual. La interacción puede ser un botón directo, un panel lateral, un modal, un formulario o la apertura de una vista externa. El efecto corresponde a los cambios producidos en servicios de dominio, hitos, eventos o documentos.

  Las acciones principales del flujo producen resultados concretos. Aceptar una orden de urgencia crea o prepara una cita quirúrgica. Recepcionar un paciente inicia el flujo operativo y puede crear una atención clínica. Ingresar a pabellón cambia la ubicación del paciente y registra el comienzo de la etapa intraoperatoria. Continuar cirugía registra hitos como inicio de anestesia, inicio de cirugía, fin de cirugía y fin de anestesia. Iniciar recuperación mueve al paciente a una ubicación de recuperación y registra el hito correspondiente. Finalizar recuperación decide si el paciente queda esperando alta, traslado o egreso. Iniciar traslado marca el movimiento hacia otra unidad. Egresar finaliza el caso ambulatorio. Suspender cancela o marca la suspensión del caso según corresponda.

  Otras acciones complementan la operación. Abrir la ficha clínica del paciente en la Plataforma Lahuén permite acceder al contexto clínico asociado a la atención. Cargar evaluación permite abrir formularios para registrar o actualizar evaluación preanestésica, protocolo quirúrgico, pausas quirúrgicas o cuidados intraoperatorios. Ver PDF de protocolo permite revisar el documento generado cuando el protocolo quirúrgico ya existe. Imprimir brazalete apoya la operación de admisión y recepción. Cambiar ubicación permite corregir o actualizar el cupo del paciente. Revertir ingreso a pabellón permite corregir una entrada errónea al quirófano sin tratarla como suspensión.

  El diseño de acciones busca que el usuario interactúe con conceptos del flujo clínico, no con detalles técnicos. Por ejemplo, el usuario ejecuta "Finalizar recuperación" o "Devolver a unidad de origen"; internamente, esas acciones pueden requerir consultar una atención, crear o aceptar un traslado, actualizar datos extendidos y registrar hitos. Esta separación hace que la experiencia sea estable aunque cambie la forma técnica de ejecutar cada paso.

  == Registro de hitos y trazabilidad

  La solución debía conservar trazabilidad sobre los momentos relevantes del proceso. Para ello, el diseño considera el registro de fechas asociadas a hitos clínico-operativos: recepción, ingreso a pabellón, inicio de anestesia, inicio de cirugía, fin de cirugía, fin de anestesia, inicio de recuperación, fin de recuperación, espera de alta, traslado, egreso y cierre. Estos hitos permiten reconstruir el recorrido del paciente y observar cuánto tiempo transcurre entre etapas.

  La trazabilidad se diseñó principalmente alrededor de la atención clínica y sus datos extendidos. Esto permite que el estado del proceso no dependa solo de la memoria de una ejecución, sino de información persistida en entidades consultables. La lista de trabajo puede reconstruir el estado de una atención leyendo esos datos y adaptándolos al modelo unificado.

  No obstante, la trazabilidad completa de responsables se deja como una línea de mejora futura. Durante el trabajo se incorporaron fechas y, en algunos casos, información de usuario para cambios de ubicación o acciones específicas. Sin embargo, no todos los hitos registran todavía de forma homogénea quién ejecutó la acción, y algunos cambios ocurren como reacción a eventos. Por ello, el diseño actual mejora la trazabilidad temporal del flujo, pero no pretende cerrar por completo la auditoría del proceso.

  == Formularios y documentos clínicos

  El diseño del módulo quirúrgico debía integrar documentos clínicos que pertenecen a la ficha del paciente. En lugar de duplicar formularios dentro de la lista quirúrgica, se definió una integración con EHR para cargar evaluaciones mediante una vista embebida. Esto permite abrir formularios de evaluación desde la lista de trabajo manteniendo su almacenamiento y comportamiento dentro de la ficha clínica.

  Las evaluaciones principales consideradas son evaluación preanestésica, pausas quirúrgicas, protocolo quirúrgico y cuidados intraoperatorios. Cada una tiene reglas de disponibilidad según el estado del paciente. La evaluación preanestésica pertenece a etapas previas al ingreso a pabellón. Las pausas quirúrgicas se relacionan con momentos intraoperatorios y se presentan como secciones de checklist. El protocolo quirúrgico se asocia al cierre documental de la intervención y puede quedar disponible incluso cuando el caso ya finalizó, si aún está pendiente. Los cuidados intraoperatorios se registran como una evaluación adicional del proceso, incorporada para digitalizar un registro requerido por el hospital y disminuir el uso de soporte en papel.

  Esta decisión permite conservar la ficha clínica como repositorio de documentos, mientras la lista quirúrgica actúa como punto de acceso operacional. El usuario no necesita navegar manualmente por distintas aplicaciones para completar documentos relevantes; la acción aparece en el estado correspondiente y abre el formulario adecuado.

  == Coordinación técnica de las acciones complejas

  Aunque el capítulo se centra en el flujo, el diseño necesita un mecanismo para ejecutar acciones que cruzan varios servicios. Para ello se usa el microservicio BPM como punto de entrada y Temporal como runtime de ejecución durable. Sobre esa base, el orquestador dinámico interpreta definiciones de acciones configuradas como una secuencia de actividades.

  El orquestador dinámico se diseñó como una herramienta de soporte para el flujo, no como el flujo en sí mismo. Su responsabilidad es ejecutar instrucciones como llamadas HTTP, asignaciones, condiciones y transformaciones de datos. Cada definición recibe parámetros de entrada, valida esos parámetros, ejecuta actividades en orden y puede usar respuestas anteriores para construir pasos posteriores. Esto permite expresar acciones del módulo quirúrgico sin escribir un workflow específico para cada caso.

  Este mecanismo se aplica a acciones donde existe una secuencia clara de operaciones. Por ejemplo, recepcionar un paciente puede requerir consultar una cita, obtener participantes, iniciar una indicación, iniciar una cita, crear o actualizar una atención y registrar datos de ubicación. Finalizar recuperación puede requerir revisar si existe traslado, determinar si el paciente es CMA, actualizar hitos y dejar el caso en espera de alta, traslado o egreso. Suspender puede requerir cancelar una cita, actualizar datos de suspensión, cancelar una atención y cerrar tareas asociadas. En todos estos casos, la orquestación permite mantener la coordinación fuera del frontend.

  La decisión de usar orquestaciones dinámicas también reduce repetición. Muchas acciones siguen un patrón similar: recibir datos desde la interfaz, consultar contexto, ejecutar una actualización y registrar resultado. Al definir este patrón como configuración, el sistema puede extenderse con nuevas acciones sin duplicar excesivamente código de coordinación.

  == Eventos y actualización de la lista de trabajo

  El diseño considera que la lista de trabajo debe mantenerse sincronizada con cambios que no siempre ocurren desde la propia pantalla. Para ello se integran eventos de dominio emitidos por servicios de la plataforma. Estos eventos pueden provenir de cambios en indicaciones, citas, atenciones, traslados o evaluaciones.

  En el frontend, `sseservice` actúa como puente entre eventos de Kafka y la lista de trabajo. La aplicación se suscribe a eventos relevantes y, cuando recibe un evento que coincide con sus filtros, actualiza la información de la grilla. Para evitar recargas innecesarias, el diseño incorpora filtros por entidad y la posibilidad de usar listas de valores. También se considera un debounce de actualización, de modo que múltiples eventos cercanos no provoquen una recarga por cada mensaje recibido.

  En backend, los eventos también pueden activar suscripciones BPM. Este mecanismo permite que ciertos cambios disparen orquestaciones automáticas. Por ejemplo, la creación de una atención quirúrgica puede generar una tarea BPM para completar el protocolo; la creación del protocolo puede completar esa tarea y operar una orden en Gestión Hospitales; la finalización de un traslado puede finalizar la atención quirúrgica; y la finalización de una atención puede actualizar sistemas externos. Estos comportamientos permiten que parte del flujo avance como reacción a eventos, no solo por acciones directas de usuario.

  == Integración con Gestión Hospitales y Agenda

  La integración con Gestión Hospitales se diseñó como una pieza específica del flujo electivo. Dado que la programación quirúrgica electiva se origina fuera de Lahuén, el sistema necesita importar esa información antes de que pueda operar en la nueva lista quirúrgica. El servicio `hegc` cumple este rol, coordinando la lectura de datos externos y la creación de citas en Agenda.

  Agenda se convierte en la entidad que representa la programación quirúrgica dentro de la plataforma. Para ello, el diseño considera tipos de cita para intervención quirúrgica de urgencia y electiva, participantes asociados a paciente, clínico y pabellón, referencias externas hacia el origen de los datos y datos extendidos para información propia del proceso quirúrgico. Esto permite que una cirugía programada pueda verse, reagendarse, suspenderse, iniciarse o relacionarse con una atención clínica.

  El uso de Agenda también permite separar programación de atención. Antes de que el paciente sea recepcionado, el caso puede existir como cita. Una vez que se inicia la atención, la entidad clínica principal pasa a ser la atención del paciente. Esta separación refleja mejor el dominio: no toda programación es todavía una atención en curso, y no toda atención quirúrgica proviene de la misma fuente.

  == Diseño de la aplicación frontend

  La nueva aplicación se diseñó como una lista de trabajo dentro de la arquitectura frontend de la plataforma. Su responsabilidad es mostrar pacientes quirúrgicos, filtros, estados, ubicación, programación, intervenciones, documentos y acciones. El usuario debe poder operar desde una sola vista el flujo principal de pabellón.

  El diseño separa la grilla, los filtros, el modelo de atención, los adaptadores, los estados y las acciones. Los adaptadores convierten fuentes externas en atenciones quirúrgicas. Los estados definen etiquetas, orden y acciones disponibles. Las acciones encapsulan la interacción y el efecto esperado. Los filtros permiten acotar la lista por fecha, ubicación u otros criterios operacionales. Esta organización busca que el módulo sea más fácil de extender que la versión anterior.

  La experiencia visual se adapta al hospital donde se implementa. Se consideran colores, banner, logo, iconografía y estilos propios del entorno. Además, la grilla prioriza información operacional: programación, ubicación, estado e intervenciones. Las acciones más importantes se muestran directamente, mientras que acciones secundarias se agrupan para evitar saturar la interfaz.

  == Resultado esperado del diseño

  El resultado esperado es un módulo quirúrgico que conserva el flujo funcional existente, pero lo implementa sobre componentes más mantenibles. Las solicitudes de urgencia y las programaciones electivas ingresan mediante entidades explícitas. La lista de trabajo normaliza esas fuentes y muestra una única vista operacional. Las acciones actualizan servicios de dominio y registran hitos. Las orquestaciones dinámicas coordinan secuencias complejas. Los eventos actualizan la interfaz y gatillan procesos automáticos cuando corresponde. Los formularios clínicos se integran con EHR y los datos de programación se representan mediante Agenda.

  Con este diseño, el proceso quirúrgico deja de depender de una instancia del motor de procesos propietario como fuente principal de estado. En su lugar, el flujo se reconstruye desde datos persistidos, acciones explícitas, eventos y orquestaciones acotadas. Esto permite preservar la lógica clínico-operativa de la versión anterior y, al mismo tiempo, entregar una base más clara para implementación, validación y evolución futura.
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
