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

  En el contexto de este trabajo, dicha tensión aparece con claridad en el proceso quirúrgico. Acciones como recepcionar un paciente, cambiar su ubicación, registrar hitos intraoperatorios, crear tareas clínicas o finalizar etapas del flujo no pertenecen necesariamente a un único servicio. Por ello, la modernización requiere una forma de coordinar operaciones distribuidas sin volver a construir un motor propietario acoplado a un módulo específico.

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

  En consecuencia, la arquitectura tecnológica escogida no es un conjunto aislado de herramientas, sino una respuesta a las limitaciones identificadas en la situación inicial. El uso de microservicios permite integrarse con la plataforma existente; Vue 2 y la arquitectura de plugins permiten construir una interfaz modular; Kafka y `sseservice` permiten propagar cambios hacia otros componentes y hacia el frontend; BPM entrega un punto común para instanciar workflows; Temporal permite ejecutar procesos distribuidos de forma durable; el workflow de orquestador dinámico permite expresar las acciones quirúrgicas como configuraciones interpretables; y el servicio `hegc` permite integrar información quirúrgica proveniente de Gestión Hospitales. Estos elementos serán utilizados en los capítulos siguientes para definir los requerimientos, el diseño y la implementación de la nueva solución.
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
