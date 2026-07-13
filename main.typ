#import "final.typ": (
  agradecimientos, apendice, capitulo, conf, dedicatoria, end-doc, frontmatter-section, resumen, start-doc,
)
#import "metadata.typ": metadata

#show: conf.with(metadata: metadata)

#resumen(metadata: metadata)[
  La gestión del proceso quirúrgico en un hospital pediátrico de alta complejidad requiere coordinar pacientes, equipos clínicos, pabellones, camas y tiempos de atención, en un contexto donde conviven actividades programadas y situaciones de urgencia.   Dentro de la Plataforma Lahuén, el módulo de atención quirúrgica ya contaba con una versión funcional implementada en el Hospital Exequiel González Cortés, pero su implementación dependía de un motor de procesos deprecado, de un frontend antiguo y de una lógica de flujo fuertemente acoplada a componentes específicos. Esta base tecnológica dificultaba el mantenimiento, la corrección de errores y la incorporación de nuevas funcionalidades, generando deuda técnica que comprometía la evolución futura del módulo.

  El objetivo de este trabajo fue modernizar el módulo de atención quirúrgica de la Plataforma Lahuén, reconstruyendo su flujo operativo sobre la arquitectura actual de la empresa para mejorar su mantenibilidad, trazabilidad y capacidad de evolución. Para ello se modeló el proceso como una secuencia explícita de estados y acciones, se implementó una nueva aplicación frontend como lista de trabajo, se sustituyó el motor de procesos deprecado por orquestaciones dinámicas que funcionan con Temporal, se mejoró la reactividad de la interfaz mediante eventos en tiempo real con SSE, y se implementó un mecanismo para trasladar cirugías programadas desde una lista de espera hacia citas en un sistema de agendas médicas.

  La metodología combinó desarrollo incremental, revisiones periódicas con supervisores técnicos y de negocio, recorridos cognitivos, inspecciones de usabilidad y pruebas funcionales manuales sobre flujos completos. La validación incluyó una encuesta SUS aplicada a 10 usuarios del sistema y un despliegue controlado en el ambiente de producción del hospital.

  Los principales resultados fueron la puesta en producción de la nueva versión del módulo el 8 de abril, el reemplazo completo de la versión anterior y la eliminación de la dependencia operacional del motor de procesos deprecado. El sistema permite operar cirugías de urgencia y electivas, ejecutar acciones clínicas y administrativas del flujo, mantener documentos quirúrgicos, actualizar monitores en tiempo real y registrar hitos relevantes para la trazabilidad. La encuesta SUS arrojó un puntaje promedio de 65,5 sobre 100, interpretable como usabilidad aceptable con oportunidades de mejora. En conjunto, el trabajo dejó una base técnica más mantenible y extensible para el módulo de pabellón de la Plataforma Lahuén.
]

#dedicatoria[]

#agradecimientos[]

#frontmatter-section(title: "Declaración de uso de inteligencia artificial")[
  En la elaboración de esta memoria se utilizaron herramientas de inteligencia artificial generativa, principalmente modelos de OpenAI a través de chats de IA como ChatGPT y herramientas de asistencia con chats y agentes, incluyendo Codex. Estas herramientas fueron empleadas en etapas de desarrollo de software, documentación y redacción del informe. Todo el contenido incorporado fue revisado y validado críticamente por el autor, quien asume plena responsabilidad por las decisiones, el código, los argumentos y las conclusiones presentadas.

  En el diseño de la solución, el uso de IA fue acotado y se concentró en consultas técnicas específicas o en la exploración de posibles formas de modelar algunos problemas. La mayor parte de las decisiones de diseño surgió de conversaciones de trabajo con los supervisores, quienes conocían en profundidad el sistema, sus capacidades y sus limitaciones. Durante el desarrollo del software, primero se construyó una base de código suficientemente sólida de manera directa; luego, en etapas posteriores, se incorporó el uso de herramientas como Codex para agilizar implementaciones sobre una estructura ya definida. Esto permitió delegar tareas de apoyo con instrucciones precisas, manteniendo siempre el control del desarrollo en el memorista y revisando minuciosamente cada resultado generado con IA antes de integrarlo.

  En la elaboración del informe, la IA se utilizó como apoyo para redactar, reorganizar y condensar información, siempre a partir de decisiones, antecedentes y criterios entregados por el memorista. También se utilizó para explorar el código y la documentación generada durante el proyecto con el fin de resumir cambios, recuperar contexto y ayudar a estructurar contenidos de un trabajo de gran tamaño y complejidad. La metodología de uso y un prompt representativo se describen en el @anexo-uso-ia.
]

#show: start-doc


#capitulo(title: "Introducción")[
  == Contexto general

  La digitalización de procesos clínicos y hospitalarios se ha transformado en una necesidad prioritaria para los sistemas de salud. La creciente demanda asistencial, la presión por optimizar recursos escasos y la necesidad de contar con información oportuna para la toma de decisiones han impulsado el desarrollo de plataformas digitales capaces de integrar distintos ámbitos de la operación hospitalaria. En este escenario, los sistemas de información en salud han dejado de ser simples repositorios de datos para convertirse en herramientas activas de gestión clínica, coordinación operativa y trazabilidad de procesos.

  Dentro de los distintos ámbitos hospitalarios, la gestión quirúrgica representa uno de los procesos más complejos. Su ejecución requiere coordinar pacientes, equipos clínicos, pabellones, equipamiento, camas y tiempos de atención, todo ello en un contexto donde conviven actividades programadas y situaciones de urgencia. El proceso quirúrgico no se limita al acto operatorio, sino que comprende un flujo más amplio cuyos principales hitos son la indicación o programación de la cirugía, la atención en pabellón y el cierre postoperatorio del episodio asistencial.

  La correcta gestión de este flujo tiene consecuencias directas sobre la eficiencia hospitalaria, la calidad de la atención y la seguridad del paciente. Un sistema capaz de representar adecuadamente el proceso quirúrgico, registrar sus hitos y apoyar la coordinación entre sus distintos participantes puede transformarse en un componente clave para mejorar tanto la operación diaria como la capacidad de análisis y mejora continua de una institución de salud.

  == Organización

  El presente trabajo se desarrolla en el contexto de Lahuén Health SpA, una empresa chilena de tecnologías de información en salud con experiencia en la digitalización de procesos hospitalarios. Su enfoque se resume en la idea de desarrollar "Tecnología que se adapta a tu modelo de atención y a tus procesos asistenciales", mediante un HIS (Hospital Information System, o sistema de información hospitalario) disponible en la Plataforma Lahuén @LahuenHealthAbout. La organización opera bajo un modelo de software como servicio, en el que entrega sus soluciones a instituciones de salud mediante suscripción, soporte continuo, comunicación directa con los clientes y mejoras permanentes del software.

  La Plataforma Lahuén se compone de distintos módulos orientados a procesos asistenciales y operacionales. Entre ellos se encuentran urgencia, hospitalización, atención ambulatoria, cirugía, farmacia, apoyo clínico y monitoreo del cuidado. En conjunto, estos componentes permiten registrar atenciones, coordinar unidades, monitorear procesos en tiempo real, integrar solicitudes clínicas, gestionar recursos y mantener una mirada transversal del paciente dentro del establecimiento. Esta orientación modular permite que la plataforma se adapte a distintos modelos de atención y se integre con otros sistemas del ecosistema hospitalario.

  Uno de los principales clientes de Lahuén es el Hospital de Niños Exequiel González Cortés. Este establecimiento es un hospital pediátrico asistencial docente de alta complejidad, dependiente del Servicio de Salud Metropolitano Sur, orientado a la promoción, prevención, recuperación y rehabilitación de la salud de niños, niñas y adolescentes de la zona sur de la Región Metropolitana @HEGCQuienesSomos. Su infraestructura contempla 168 camas, de las cuales 24 corresponden a cuidados críticos, además de seis pabellones quirúrgicos, por lo que puede considerarse un establecimiento pediátrico de tamaño medio y alta complejidad @CChC_HEGCInfraestructura.

  == Problema

  Dentro de la Plataforma Lahuén, el módulo de pabellón ocupa un lugar estratégico, ya que articula el trabajo quirúrgico con otros componentes clínicos y administrativos del sistema. La versión previa de este módulo fue implementada en el Hospital Exequiel González Cortés, lo que permitió resolver necesidades reales de un entorno quirúrgico complejo. Sin embargo, esta implementación quedó fuertemente asociada a tecnologías y patrones anteriores de la plataforma.

  A pesar de contar con una implementación funcional del proceso quirúrgico, el módulo existente presenta limitaciones importantes desde el punto de vista tecnológico y de mantenibilidad. La solución actual se apoya en un motor de procesos propietario de Lahuén Health que permite ejecutar actividades asincrónicas, permanecer a la espera de eventos y mantener el estado de cada instancia de proceso. Si bien este enfoque resolvió necesidades operativas en su momento, hoy se encuentra deprecado: sus limitaciones técnicas lo hacen difícil de mantener y la empresa lo está reemplazando progresivamente por Temporal. Esto dificulta la evolución del sistema y encarece su mantención.

  Esta situación genera varios problemas. En primer lugar, la lógica del proceso quirúrgico se encuentra fuertemente acoplada a componentes específicos, lo que hace más costoso modificar el flujo, incorporar nuevas acciones o adaptar el módulo a otros contextos hospitalarios. En segundo lugar, la base tecnológica previa limita la integración con la arquitectura moderna del resto de la plataforma, dificultando la reutilización de componentes y la incorporación de capacidades transversales como mejor observabilidad, manejo robusto de errores y sincronización eficiente con otras partes del sistema. En tercer lugar, la existencia de una solución especializada y dependiente de tecnologías antiguas introduce deuda técnica, afectando la estabilidad, la escalabilidad y la velocidad con que pueden implementarse mejoras.

  Desde una perspectiva funcional, esto se traduce en una brecha entre lo que el sistema ya logra hacer y lo que necesita ofrecer en el futuro. Aunque el módulo permite representar y operar el flujo quirúrgico, no cuenta todavía con una base suficientemente moderna, flexible y reusable como para sostener su evolución de manera segura y sostenible. Esto no solo dificulta reutilizar o adaptar el módulo en otros establecimientos, sino también mantenerlo, corregir problemas existentes y agregar nuevas funcionalidades. En la práctica, varios problemas requieren soporte constante por parte de la empresa y resolverlos sobre la base técnica anterior puede demandar un esfuerzo alto en relación con el valor de la mejora.

  Por ello, la modernización busca reconstruir esta capacidad con tecnologías actuales de la plataforma, implementarla primero en el Hospital Exequiel González Cortés, validarla en un entorno quirúrgico real y dejar el módulo mejor preparado para ser utilizado posteriormente en otros hospitales.

  == Motivación y relevancia

  La modernización del proceso quirúrgico resulta relevante por razones tanto operativas como tecnológicas. Desde el punto de vista del dominio clínico, la gestión de pabellones y del flujo intraoperatorio requiere una coordinación precisa y una trazabilidad clara de cada etapa del proceso. Disponer de una herramienta que refleje adecuadamente el estado de cada paciente, las transiciones relevantes y las acciones posibles en cada momento puede contribuir a mejorar la visibilidad del proceso y apoyar la toma de decisiones por parte de los equipos clínicos.

  Desde el punto de vista tecnológico, este proyecto responde a la necesidad de alinear el módulo quirúrgico con la arquitectura actual de la plataforma, reduciendo deuda técnica y sentando bases más sólidas para futuras extensiones. Modernizar este componente no solo mejora su mantenibilidad y confiabilidad, sino que también permite que el sistema evolucione hacia una solución más reusable y adaptable a distintos establecimientos de salud.

  La relevancia del trabajo también radica en que aborda un problema real dentro de un entorno de producción, donde las decisiones de diseño e implementación deben responder tanto a requerimientos técnicos como a necesidades operativas concretas. En ese sentido, el proyecto no se limita a proponer una solución teórica, sino que busca construir una mejora efectiva sobre un sistema que ya forma parte del trabajo cotidiano de una organización del sector salud.

  == Objetivos

  El objetivo general de este trabajo es modernizar el módulo de atención quirúrgica de la Plataforma Lahuén, reconstruyendo su flujo operativo sobre la arquitectura actual de la empresa para mejorar su mantenibilidad, trazabilidad y capacidad de evolución, y dejando una nueva versión desplegada y operativa en el Hospital Exequiel González Cortés.

  Para alcanzar este objetivo general, se plantean los siguientes objetivos específicos:

  - Modelar de forma explícita el flujo de atención quirúrgica mediante un conjunto coherente de estados y acciones.
  - Modernizar la vista de atención quirúrgica para integrarla adecuadamente a la plataforma, representar la información relevante de cada paciente y utilizar el `design system` actual de Lahuén, con el estilo característico de las nuevas aplicaciones de la empresa.
  - Sustituir el motor de procesos deprecado por una solución más sencilla de mantener y más adecuada para coordinar acciones complejas del flujo, reduciendo la dependencia de tecnología difícil de evolucionar.
  - Mejorar la trazabilidad de los hitos del proceso quirúrgico, de modo que sea posible reconstruir el recorrido de un caso y disponer de información útil para análisis posteriores.
  - Validar la solución mediante pruebas funcionales, recorridos cognitivos, inspecciones de usabilidad y despliegues controlados en ambientes de prueba lo más similares posible a producción, simulando escenarios reales del flujo quirúrgico.
  - Reemplazar la versión anterior del módulo al finalizar el trabajo, dejando la nueva versión desarrollada desplegada en producción.
  - Dejar una base técnica y documental que facilite la evolución futura del módulo de pabellón.

  == Resumen de la solución

  La solución propuesta consiste en modernizar el núcleo del proceso de atención quirúrgica sobre la arquitectura actual de la plataforma, manteniendo su valor clínico y operativo, pero reemplazando los componentes propietarios que dificultan su evolución. Para ello, se plantea modelar el flujo de atención quirúrgica como una secuencia explícita de estados y transiciones, donde cada acción relevante del usuario tenga un comportamiento claramente definido y trazable.

  En el backend, la modernización considera reemplazar el motor de procesos deprecado por una solución más simple de operar y mantener para aquellas operaciones que requieren coordinar múltiples pasos o servicios. A diferencia del esquema anterior, donde cada proceso quirúrgico se instanciaba como una ejecución persistente que mantenía su propio estado y se controlaba mediante llamadas directas al motor, la nueva aproximación busca separar mejor la lógica del proceso, reducir la complejidad de corrección y disminuir el costo asociado a su soporte. En paralelo, se busca consolidar un modelo de dominio unificado para representar cada atención quirúrgica, integrando datos clínicos, de programación y de ubicación del paciente.

  En el frontend, la solución se materializa en una vista de atención quirúrgica integrada a la plataforma, concebida como una lista de trabajo que muestra el estado de los pacientes y permite ejecutar las acciones correspondientes a cada etapa. De esta manera, la solución busca combinar claridad operativa para los usuarios con una arquitectura más mantenible y extensible desde el punto de vista del desarrollo de software.

  == Alcance

  El alcance del trabajo se concentra en la modernización del proceso de atención quirúrgica, especialmente en el flujo operativo de pabellón y en las etapas cercanas a este. Esto incluye representar el recorrido de los pacientes quirúrgicos, ejecutar acciones asociadas a cambios de estado, integrar información clínica y de programación, y registrar hitos relevantes para la trazabilidad del proceso.

  No forma parte del alcance una reconstrucción completa de todo el módulo de pabellón ni un rediseño integral del sistema de listas de espera quirúrgicas. Tampoco se pretende resolver en esta etapa todos los escenarios excepcionales del proceso quirúrgico. En cambio, el trabajo prioriza los casos necesarios para operar el flujo principal, asegurar continuidad de uso y dejar una base técnica más mantenible sobre la cual puedan apoyarse futuras mejoras y extensiones.

  Esta delimitación también responde a una restricción temporal del proyecto: la nueva versión debía desarrollarse en un periodo cercano a seis meses y quedar desplegada en producción al cierre de ese ciclo. Por ello, la prioridad fue construir una solución funcional, estable y usable en un entorno real, antes que abordar de inmediato todos los casos posibles del dominio quirúrgico.

  == Estructura del documento

  El presente informe se organiza de la siguiente manera. En primer lugar, se presenta el contexto técnico y operativo del problema abordado, incluyendo la situación previa del módulo y la arquitectura de la plataforma. Luego, se describe el diseño de la solución y la forma en que organiza el flujo quirúrgico sobre la arquitectura actual. A continuación, se expone la implementación realizada y su validación. Finalmente, se presentan los resultados obtenidos, las conclusiones y las posibles líneas de trabajo futuro.
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

  La principal limitación de la versión anterior no era la ausencia de un flujo quirúrgico, sino la forma en que este flujo estaba implementado. El módulo había sido construido originalmente alrededor de 2012, utilizando herramientas y patrones que, más de una década después, resultaban difíciles de mantener y extender. En particular, la aplicación frontend de atención quirúrgica estaba construida en JavaScript con una arquitectura menos definida que la utilizada actualmente por la plataforma, lo que dificultaba separar responsabilidades entre vista, acciones, modelo y lógica de integración. Esto no solo afectaba la evolución visual de la interfaz, sino también la incorporación controlada de nuevas funcionalidades, la reutilización de componentes comunes y el ajuste de acciones según el estado clínico-operativo del caso.

  En el backend, la coordinación del proceso dependía del motor de procesos deprecado. Este motor permitía instanciar flujos quirúrgicos, mantener el contexto de cada caso, ejecutar actividades asincrónicas y avanzar en función de señales o llamadas realizadas desde el sistema. Esta capacidad fue útil para representar un proceso de larga duración con múltiples estados, pero generaba una dependencia técnica importante: comprender, mantener o modificar el comportamiento del flujo requería conocimiento especializado sobre el motor y sobre la forma en que cada instancia de proceso era consultada o actualizada. Además, parte del estado operativo quedaba asociado al contexto de ejecución del proceso y no a entidades de dominio consultables mediante servicios estándar. Por ello, una corrección aparentemente simple podía requerir entender la estructura interna de una instancia, el punto exacto del flujo en que se encontraba y la forma en que había llegado hasta ese estado.

  La existencia del motor de procesos deprecado también generaba una asimetría respecto del resto de la plataforma moderna, orientada a microservicios y componentes reutilizables. Mientras otros módulos podían evolucionar mediante APIs, componentes frontend y servicios con responsabilidades más claras, el proceso quirúrgico mantenía parte de su lógica crítica vinculada a un mecanismo especializado. Esto aumentaba el costo de corrección, dificultaba incorporar nuevas acciones y reducía la flexibilidad para adaptar el flujo a nuevos requerimientos. En la arquitectura actual, en cambio, resultaba más natural reconstruir la atención quirúrgica a partir de entidades explícitas del dominio, como indicaciones quirúrgicas, citas de Agenda y atenciones de pacientes.

  Otra limitación era la actualización de la información visible para los usuarios. En un proceso quirúrgico, una acción realizada por otro usuario, un cambio de ubicación, la creación o modificación de una cita, el avance de una atención o el registro de una evaluación clínica pueden alterar lo que debe mostrarse en la lista de trabajo. Cuando la interfaz no cuenta con un mecanismo suficientemente reactivo para escuchar esos cambios, depende de recargas manuales o consultas periódicas, lo que puede mantener información desactualizada en un contexto donde la coordinación operacional es relevante.

  Desde el punto de vista de producto, esta situación generaba una tensión importante: el flujo funcional era valioso y debía conservarse, pero su implementación limitaba la evolución del módulo. Por ello, el trabajo de modernización no buscó aprender y replicar cada detalle interno del software anterior, sino rescatar el flujo de atención quirúrgica validado por la experiencia y reconstruirlo con herramientas actuales de la plataforma, sin cambiar innecesariamente la experiencia esperada por los usuarios.

  == Síntesis de la situación actual

  La situación actual puede resumirse en tres ideas. Primero, el proceso quirúrgico es un flujo complejo, longitudinal y crítico para la gestión hospitalaria, cuya operación requiere priorización, programación, coordinación de recursos, registro de hitos y trazabilidad. Segundo, la Plataforma Lahuén ya contaba con una versión funcional del módulo quirúrgico, capaz de representar lista de espera, programación, atención en pabellón, documentos clínicos y monitor de estado.   Tercero, la implementación técnica de esa versión presentaba limitaciones relevantes de mantenibilidad, principalmente por el uso de un frontend antiguo, el motor de procesos deprecado, un estado operativo poco separado de la instancia de proceso y mecanismos de actualización menos reactivos que los requeridos por la operación actual.

  En consecuencia, la modernización debe entenderse como una reconstrucción tecnológica de un flujo funcional existente. El objetivo no es descartar la experiencia acumulada en la versión anterior, sino implementarla sobre una base más mantenible, integrada y extensible, que permita sostener futuras mejoras del módulo de pabellón dentro de la Plataforma Lahuén.
]

#capitulo(title: "Marco tecnológico y arquitectura de la plataforma")[
  Este capítulo presenta las tecnologías y conceptos arquitectónicos que sustentan la modernización del módulo de atención quirúrgica: microservicios, frontend modular, workflows, Temporal, eventos y coordinación configurable de procesos.   Su propósito es establecer el marco técnico necesario para comprender cómo el reemplazo del motor de procesos deprecado se resuelve mediante una arquitectura distribuida, un runtime de workflows durable y definiciones declarativas que coordinan acciones complejas. El capítulo siguiente utiliza esta base para explicar cómo se organizan estados, entidades, acciones, formularios, eventos y coordinación del nuevo módulo.

  == Arquitectura general de Lahuén

  La Plataforma Lahuén se organiza como un conjunto de aplicaciones frontend y servicios backend que colaboran para implementar procesos asistenciales. Los servicios backend concentran responsabilidades por dominio funcional, como agenda, registro clínico, hospitalización, formularios, procesos y tareas, mientras que las aplicaciones frontend ofrecen interfaces especializadas para distintos roles y tareas. Esta separación permite evolucionar cada parte de manera relativamente independiente, pero también introduce desafíos de coordinación cuando una acción de negocio cruza varios dominios.

  == Backend y microservicios PHP <sec-backend-microservicios>

  Los microservicios backend de Lahuén están implementados principalmente en PHP, lenguaje orientado al desarrollo de aplicaciones web y servicios de servidor @PHPDocs, y se estructuran en torno a APIs, entidades de negocio, servicios, stores y esquemas de validación. Como framework base se utiliza Slim, un microframework de PHP orientado a construir APIs y servicios RESTful de forma ligera y modular. Estos servicios son responsables de consultar y modificar datos de negocio, aplicar reglas propias de cada dominio y emitir eventos cuando ocurren cambios relevantes.

  Los principales microservicios relevantes para este trabajo son los siguientes:
  - `HLTH`: gestiona atenciones clínicas, ubicaciones de pacientes y datos de salud.
  - `XRM`: gestiona el modelo de personas de la plataforma, que incluye pacientes, clínicos y terceros.
  - `Agenda`: gestiona citas, programación y participantes.
  - `BPM`: centraliza la instanciación de workflows y tareas de procesos.
  - `AUTH`: gestiona usuarios, autenticación y permisos.
  - `FORMS`: genera documentos a partir de plantillas.
  - `DMS`: permite obtener documentos generados por `FORMS` desde el frontend.
  - `HEGC`: servicio integrador y orquestador entre microservicios, incluyendo la adaptación de datos de sistemas previos como Gestión Hospitales.

  Los microservicios persisten sus datos principalmente en MariaDB, un sistema de gestión de bases de datos relacionales de código abierto y gratuito, compatible con MySQL. Además, la plataforma utiliza MongoDB para datos semi-estructurados como terminologías y configuraciones de aplicaciones.

  Varias entidades de la plataforma incluyen un campo de datos extendidos, o `extendedData`, almacenado como JSON. Este campo permite guardar información contextual de un módulo sin mezclarla con los atributos comunes del modelo, lo que resulta útil para conservar datos relevantes de un flujo en entidades reutilizadas por distintos contextos clínicos.

  == Arquitectura frontend: aplicaciones, listas de trabajo y plugins <sec-arquitectura-frontend>

  El frontend moderno de Lahuén se construye sobre una arquitectura modular basada en componentes Vue 2 @Vue2Docs. La base compartida `shared` concentra componentes genéricos, utilidades, estilos y recursos visuales reutilizables. Sobre ella, la clase `WebApp` permite construir aplicaciones con un ciclo de vida, configuración, APIs, store, rutas y eventos comunes. Las aplicaciones se extienden mediante plugins, que registran módulos, componentes, formularios y reglas de dominio sin alterar la base compartida.

  Un patrón frecuente en la plataforma son las listas de trabajo, o worklists, que organizan la operación diaria en torno a una grilla de casos, filtros y acciones. La aplicación de proceso quirúrgico sigue este patrón. El detalle de la arquitectura frontend, incluyendo la relación entre `WebApp`, plugins y recursos compartidos, se describe en el @anexo-arquitectura-plataforma.

  Además de las listas de trabajo, existen aplicaciones frontend especializadas en otros flujos clínicos. Una de ellas es EHR, la aplicación de ficha clínica del paciente, que agrupa formularios clínicos como el protocolo quirúrgico, la evaluación preanestésica y otras evaluaciones relevantes del paciente. Como estos formularios se originan en EHR, otras aplicaciones los reutilizan dentro de un contenedor —por ejemplo, un `iframe`— en lugar de replicarlos.

  == Orquestación y coreografía de procesos

  En sistemas de microservicios, existen dos formas comunes de coordinar procesos de negocio: coreografía y orquestación. En una coreografía, los servicios reaccionan a eventos y cada uno decide localmente qué hacer. En una orquestación, existe un componente que coordina explícitamente la secuencia de actividades. La coreografía reduce dependencias directas, pero puede dificultar la observación global del proceso cuando el flujo queda distribuido entre múltiples servicios. La orquestación, en cambio, permite representar el proceso de forma más explícita y facilita entender qué actividades se ejecutaron, cuáles fallaron y en qué estado se encuentra una instancia @NadeemM2022.

  Para el caso del módulo quirúrgico, la orquestación resulta adecuada porque muchas acciones requieren una secuencia definida y trazable. La recepción de un paciente, el avance de hitos intraoperatorios, la suspensión de una cirugía o la creación de tareas asociadas al protocolo operatorio son ejemplos de acciones donde importa el orden, el resultado de pasos previos y el estado final del proceso. Por ello, los workflows durables son una alternativa técnica pertinente para coordinar operaciones distribuidas sin concentrar toda la lógica en la interfaz de usuario ni repartirla de forma implícita entre servicios.

  == Temporal como runtime de workflows

  Temporal es una plataforma para ejecutar workflows durables, diseñada para coordinar procesos de negocio que pueden involucrar llamadas a servicios, reintentos, esperas y fallas parciales @TemporalDocs. En Temporal, un workflow define la lógica de coordinación, mientras que las actividades encapsulan operaciones que pueden interactuar con sistemas externos. Los workers son procesos que registran workflows y actividades, consumen tareas desde una cola de trabajo y ejecutan el código correspondiente. Para PHP, Temporal provee un SDK específico que permite implementar workflows y workers en ese lenguaje @TemporalPHPDocs.

  La principal ventaja de Temporal para este proyecto es que permite separar la lógica de coordinación de las operaciones concretas realizadas por los microservicios. El workflow puede representar la secuencia general y delegar en actividades las llamadas HTTP, transformaciones, validaciones o actualizaciones necesarias. Además, Temporal mantiene historial de ejecución y estado durable, lo que ayuda a observar y depurar procesos distribuidos. Esta característica es relevante en microservicios, donde los errores de interacción entre servicios suelen ser difíciles de diagnosticar cuando el flujo no está representado de manera explícita @NadeemM2022.

  En la arquitectura de Lahuén, los workflows de Temporal se implementan utilizando PHP y el SDK de Temporal para ese lenguaje. Estos workflows y sus actividades son registrados por workers, que consumen tareas desde una cola de trabajo y ejecutan el código correspondiente. De este modo, la ejecución del proceso queda fuera del frontend y de los microservicios de dominio, pero puede invocar a estos servicios cuando una actividad lo requiere.

  La instanciación de workflows se centraliza en el microservicio BPM. Esto puede ocurrir mediante llamadas directas a su API o mediante suscripciones configuradas en la base de datos de BPM, que permiten iniciar workflows a partir de eventos definidos por la plataforma. Así, BPM actúa como puerta de entrada para iniciar workflows de Temporal, mientras que los workers se encargan de procesarlos.

  == Coordinación mediante eventos, BPM y SSE

  La plataforma combina tres mecanismos para coordinar procesos y mantener actualizada la interfaz. Los eventos comunican que algo ocurrió en el sistema y permiten que otros componentes reaccionen sin acoplarse al emisor. Las suscripciones BPM convierten ciertos eventos en inicios de workflows de Temporal. Los workflows, por su parte, coordinan acciones que deben ejecutarse como parte de un flujo durable. Finalmente, el servicio de SSE entrega los eventos al frontend mediante una conexión persistente, para que una lista de trabajo se actualice cuando cambian las entidades relevantes.

  El microservicio BPM cumple el rol de punto de integración para procesos. Su responsabilidad no es reemplazar a los servicios de dominio, sino ofrecer un mecanismo común para iniciar workflows de Temporal. El frontend o un servicio puede solicitar la ejecución de una acción de negocio; BPM recibe la solicitud, instancia el workflow correspondiente y deja su ejecución a cargo de Temporal y de los workers registrados.

  Los microservicios actuales emiten eventos relevantes cuando ejecutan acciones sobre entidades de negocio, como cambios en citas, atenciones, indicaciones o evaluaciones. Estos eventos se publican en tópicos Kafka y pueden consumirse de dos formas. Por un lado, BPM escucha eventos mediante suscripciones configuradas en base de datos; cada suscripción define el tópico, filtros y una transformación que permite iniciar un workflow cuando ocurre una condición de negocio. Por otro lado, el servicio de SSE consume eventos de Kafka y los reenvía al frontend mediante un canal persistente, al que el navegador se conecta mediante una solicitud `GET`.

  En la @fig-diseno-eventos-lista-trabajo se observa este enfoque general. El servicio de SSE consume eventos desde Kafka, mantiene conexiones persistentes con las listas de trabajo mediante `EventSource` y reenvía cada evento solo a los canales cuyos filtros se cumplen. En paralelo, BPM Event Starter consume eventos desde Kafka, revisa sus suscripciones configuradas y decide si corresponde instanciar el workflow asociado.

  #figure(
    image("./imagenes/diagrama_diseno_eventos_1.png", width: 100%),
    caption: [Modelo conceptual de eventos para actualizar la lista de trabajo y activar coordinaciones de proceso.],
  ) <fig-diseno-eventos-lista-trabajo>

  == Workflows configurables

  Una forma de reducir el acoplamiento en procesos repetitivos es describir parte de la coordinación mediante configuraciones interpretadas por un workflow. En vez de codificar cada secuencia como una implementación distinta, una definición puede indicar qué actividades ejecutar, con qué datos, en qué orden y bajo qué condiciones. En una arquitectura con Temporal, el runtime entrega ejecución durable, historial, workers y reintentos, mientras que la configuración describe la secuencia específica que debe interpretarse. Esto permite separar la infraestructura durable de la descripción concreta de cada acción de negocio.

  En este contexto, una configuración declarativa puede expresar secuencias de actividades, decisiones condicionales, transformaciones de datos y referencias a resultados previos, sin que cada flujo deba implementarse como código independiente. El workflow interpreta esa definición en tiempo de ejecución, moviendo parte de la lógica desde código rígido hacia una especificación que puede revisarse y ajustarse de forma más directa. Este enfoque resulta especialmente útil cuando distintas acciones comparten un patrón similar —recibir parámetros, validar entrada, consultar datos, llamar servicios, usar respuestas previas y decidir si ciertos pasos deben ejecutarse—, porque reduce la repetición de código y hace más explícita la relación entre pasos.

  == Servicios orquestadores de dominio

  La plataforma ya cuenta con experiencia previa en la coordinación de servicios. Además de Temporal, existen servicios de dominio que cumplen un rol orquestador cuando deben integrar aplicaciones o bases de datos con estructuras distintas. Para el proceso quirúrgico, el caso más importante es el servicio HEGC, que contiene lógica para relacionar Gestión Hospitales con componentes actuales de Lahuén.

  HEGC resuelve integraciones específicas mediante clases PHP que llaman a otros servicios, como la creación de citas de Agenda a partir de órdenes quirúrgicas, la finalización de una cirugía o la suspensión de una orden. Sin embargo, este enfoque también tiene limitaciones: la lógica queda codificada en clases concretas, los cambios en datos requieren modificar código y la coordinación queda más acoplada al caso de uso que en una orquestación declarativa.

]

#capitulo(title: "Diseño de la solución")[
  Este capítulo presenta el diseño conceptual de la solución, enfocado en cómo se organiza el flujo quirúrgico, qué componentes participan y cómo se conectan para sostener la operación clínica. Aquí se describen las decisiones de diseño antes de entrar en los detalles de implementación del capítulo siguiente.

  Las funcionalidades se diseñaron durante el desarrollo mediante reuniones de trabajo con tres supervisores que aportaron perspectivas complementarias. El supervisor con rol de Arquitectura de Software apoyó las decisiones técnicas, el entendimiento de la plataforma y la comprensión del flujo anterior para poder replicarlo sobre la arquitectura actual. El líder del proyecto y CEO de la empresa aportó una visión de negocio y de uso operacional, además de participar en revisiones y pruebas de las funcionalidades implementadas.   El CTO de la empresa aportó una visión técnica, especialmente al proponer la idea del orquestador dinámico como mecanismo para reemplazar la dependencia del motor de procesos deprecado en las acciones complejas del flujo.

  A partir del diagnóstico de la versión anterior, el diseño se orientó por cinco criterios principales:

  + Conservar el comportamiento funcional del proceso quirúrgico, de modo que los usuarios pudieran operar programación, recepción, avance intraoperatorio, recuperación, salida, suspensión, documentación clínica y consulta de ficha sin perder la lógica de trabajo conocida.
  + Representar el estado del flujo mediante entidades explícitas del dominio, como indicaciones quirúrgicas, citas de Agenda y atenciones de pacientes, en lugar de depender de una instancia del motor de procesos deprecado como fuente principal de información.
  + Coordinar acciones que involucran múltiples servicios sin concentrar esa lógica en el frontend. En el flujo quirúrgico, una acción visible para el usuario puede requerir consultar datos, actualizar una cita, crear una atención, modificar una ubicación, registrar hitos, crear tareas BPM o completar información en Gestión Hospitales.
  + Mejorar la reactividad operacional mediante eventos, para que la lista de trabajo y los monitores puedan actualizarse cuando cambian las entidades asociadas al caso.
  + Mejorar la experiencia de uso sin alterar de manera innecesaria el flujo conocido, incorporando ajustes visuales y acciones acotadas que apoyen situaciones operacionales concretas.

  En conjunto, estos criterios apuntan a reducir el acoplamiento entre interfaz, coordinación de procesos y servicios de dominio, dejando una base más mantenible y extensible para incorporar nuevos estados, acciones, formularios o integraciones. Además, como el módulo debía reemplazar una herramienta usada en operación real, el diseño debía integrarse con servicios existentes de la plataforma, preservar continuidad operacional y permitir ajustes progresivos.

  == Estados del flujo quirúrgico

  El proceso quirúrgico se representó como una secuencia de estados. Estos estados ya existían en la versión anterior del módulo y fueron diseñados por la empresa a lo largo de años de trabajo con el flujo de pabellón. La modernización los mantuvo porque entregan una forma validada de modelar un proceso complejo. Cada estado indica la etapa del paciente, los datos relevantes para la grilla y las acciones disponibles para el usuario.

  Esta decisión también permite conservar las transiciones principales de la versión previa sin trasladar su implementación técnica. El diseño mantiene la lógica de avance por etapas, pero hace explícito que cada estado debe habilitar solo las acciones coherentes con el momento clínico-operativo del caso.

  La @fig-estados-proceso-quirurgico muestra una versión simplificada del flujo, centrada en la acción principal de cada estado cuando el caso avanza sin excepciones. El flujo real incluye acciones adicionales, como completar formularios o suspender la atención, y también puede verse afectado por eventos externos. En el diseño, el origen del caso, las acciones disponibles y las condiciones de salida determinan cómo avanza cada paciente.

  #figure(
    image("./imagenes/diagrama-simplificado-estados-proceso-quirurgico.png", width: 100%),
    caption: [Flujo simplificado de estados principales del proceso quirúrgico y transiciones esperadas.],
  ) <fig-estados-proceso-quirurgico>

  Los estados se organizaron en grupos funcionales:

  - Estados de ingreso: 'Solicitada' representa una orden quirúrgica de urgencia pendiente de aceptación. 'Programada' representa una cirugía electiva ya agendada.
  - Estados de preparación: 'En espera' representa un paciente incorporado al circuito quirúrgico, pero aún no recepcionado en pabellón. 'Preoperatorio' indica que el paciente ya fue recepcionado y puede ingresar a quirófano.
  - Estados intraoperatorios: 'En pabellón' marca la entrada al quirófano. Luego el caso avanza por 'Anestesia iniciada', 'Cirugía iniciada', 'Cirugía finalizada' y 'Anestesia finalizada'. Estos estados registran los hitos temporales del acto quirúrgico.
  - Estado de recuperación: 'En recuperación' indica que terminó la etapa intraoperatoria. La acción principal es finalizar recuperación, lo que determina el camino posterior del paciente.
  - Estados de salida: 'Esperando alta' corresponde a pacientes ambulatorios a los que no se les indica hospitalización y aún no se les registra el alta quirúrgica. Una vez registrada esa evaluación, el caso avanza a 'Esperando egreso', que indica que el paciente está listo para egresar. Ambos son estados distintos en el modelo: 'Esperando egreso' agrega, por ejemplo, la acción de egresar al paciente. 'Esperando traslado' representa la espera de movimiento hacia otra unidad. 'En tránsito' indica que el paciente ya inició el traslado. 'Finalizada' marca el cierre del caso.
  - Estado de excepción: 'Suspendida' representa una atención quirúrgica que fue suspendida. En la aplicación se utiliza en el módulo de atenciones anteriores para identificar esos casos y consultar su información, pero no tiene acciones relevantes dentro del flujo.

  == Entradas del flujo quirúrgico

  La nueva lista de trabajo quirúrgica obtiene los casos desde entidades explícitas y servicios existentes. Con esto se reemplaza la dependencia de instancias del motor de procesos deprecado como fuente principal para representar el caso en la grilla.

  El diseño debía soportar los dos orígenes principales del proceso quirúrgico: solicitudes de urgencia y atenciones electivas programadas. En el primer caso, el flujo comienza con una indicación quirúrgica originada desde urgencia. En el segundo, comienza con una orden quirúrgica programada en Gestión Hospitales, que debe transformarse para operar dentro de los servicios actuales de la plataforma.

  === Flujo de urgencia <sec-flujo-urgencia>

  En urgencia, las atenciones solicitadas se construyen desde Indicaciones, una entidad del microservicio HLTH. Cuando un clínico indica una intervención quirúrgica para un paciente, la aplicación de proceso quirúrgico lee esas indicaciones y las adapta al modelo de atención quirúrgica, sin crear una entidad adicional para representar la solicitud.

  === Flujo electivo

  En el flujo electivo, la entrada principal es una orden proveniente de Gestión Hospitales. Esta aplicación registra la programación quirúrgica electiva en una base de datos anterior, con estructuras distintas a las de los microservicios actuales. Para incorporarla al nuevo flujo se diseñó un endpoint de importación que transforma órdenes de procedimientos en citas del microservicio Agenda.

  La importación lee las órdenes que deben operarse durante el día y que aún no han sido importadas. Luego adapta datos como paciente, cirujano, programación, pabellón, intervención, diagnóstico y modalidad de atención, y crea citas de Agenda con esa información.

  Como la importación se ejecuta por día, se mantuvo el mecanismo operacional usado previamente: un script programado se ejecuta cada mañana y llama al endpoint con la información de los pacientes a importar. Es una solución simple y adecuada para el flujo electivo, porque deja disponibles las cirugías programadas antes del inicio de la operación diaria.

  == Modelo unificado de atención quirúrgica

  La lista de trabajo construye una atención quirúrgica de frontend a partir de tres entidades: `Indication`, `Appointment` y `PatientService`. Cada una pertenece a un servicio distinto y representa una parte diferente del flujo.

  Esta unificación evita que el usuario deba distinguir internamente si una fila proviene de una indicación, una cita o una atención ya iniciada. Desde la interfaz, cada caso se presenta como una atención quirúrgica con estado, datos operacionales y acciones disponibles, aunque su origen técnico sea distinto.

  La atención quirúrgica visible en la grilla no corresponde a una única entidad persistida. Es una representación de frontend construida desde fuentes de dominio distintas. Por ello, el diseño debía conservar tanto una estructura común para mostrar y operar el caso como referencias a la entidad de origen, de modo que cada acción pudiera ejecutarse sobre la indicación, cita o atención correspondiente.

  La normalización también era necesaria para intervenciones, diagnósticos y programación, porque esos datos podían provenir de indicaciones, órdenes de Gestión Hospitales o atenciones ya iniciadas. El modelo unificado prioriza la información útil para la operación diaria y oculta diferencias internas que no aportan al usuario.

  Como se explicó en @sec-backend-microservicios, estas entidades pueden incorporar información contextual mediante `extendedData`. El diseño aprovecha esa capacidad para guardar variables propias del flujo quirúrgico sin alterar los atributos generales de cada entidad. Entre esas variables están los datos de programación, intervenciones, diagnósticos, responsable, origen del caso, estado operacional e hitos de pabellón.

  === Indication: solicitudes de urgencia

  Como se explicó en la @sec-flujo-urgencia, el flujo de urgencia se construye a partir de la entidad `Indication` de HLTH. Esta entidad representa una solicitud de intervención clínica, lo que la hace adecuada para modelar el inicio del proceso quirúrgico sin necesidad de crear otra entidad adicional. En la lista de trabajo, `Indication` se utiliza en el estado 'Solicitada'.

  === Appointment: programaciones quirúrgicas

  `Appointment` pertenece a Agenda y representa cirugías programadas, tanto electivas como de urgencia. En la lista de trabajo se utiliza en los estados 'Programada' y 'En espera'.

  Entre las entidades disponibles en la plataforma, la cita es la que mejor encaja con estos estados, porque representa una atención futura con una fecha definida, participantes asignados y recursos programados. Otras entidades no se adaptan tan bien a este contexto: una indicación es solo una solicitud clínica y un `PatientService` ya representa una atención en curso. Por eso, durante el diseño se decidió utilizar citas para gestionar las intervenciones en etapa de programación o espera de ingreso.

  === PatientService: atención quirúrgica iniciada

  `PatientService` pertenece a HLTH y representa una atención abierta del paciente dentro del hospital. En la lista de trabajo se utiliza desde el estado 'Preoperatorio' en adelante. Esta entidad es la adecuada para estas etapas porque refleja que el paciente está efectivamente en atención y concentra información relevante del caso: ubicación, programación, responsable, intervenciones, diagnósticos, ubicación de origen y estado operacional.

  La versión anterior también utilizaba `PatientService` en el backend, pero el frontend dependía de las instancias del motor de procesos deprecado para representar el caso. Como el flujo hospitalario exige que exista un `PatientService` abierto mientras el paciente está en atención, el diseño actual lo utiliza directamente como entidad principal del flujo, eliminando la dependencia del motor de procesos.

  Para obtener estas entidades se utilizan APIs y filtros disponibles en los microservicios, de modo que cada fuente entregue casos en los estados relevantes para la lista de trabajo. El capítulo de implementación detalla cómo se obtienen esos datos y cómo se unifican en una sola atención quirúrgica para la grilla.

  == Diseño frontend, estados y acciones

  El frontend mantiene tres aplicaciones complementarias que cumplen roles distintos dentro del proceso quirúrgico. La aplicación de proceso quirúrgico permite revisar y modificar los casos de pabellón; el Monitor de pabellones permite identificar rápidamente qué ocurre con cada quirófano; y el Monitor de pacientes entrega a familiares y acompañantes una vista acotada del estado del paciente.

  La primera aplicación es la vista operativa de pabellón. Esta se diseñó como una especialización de la aplicación base de listas de trabajo descrita en la @sec-arquitectura-frontend. La estructura común aporta navegación, filtros, grilla y paneles; la lógica quirúrgica queda concentrada en el plugin `surgical_process`.

  El diseño de esta aplicación usa dos plugins. `standard` aporta modelos y componentes comunes para listas de trabajo, como paciente, clínicos, ubicaciones, admisión y secciones reutilizables de formularios. `surgical_process` define los módulos del flujo quirúrgico, la carga de datos, la adaptación de casos, los componentes de lista, los estados, las acciones, los formularios propios y las suscripciones a eventos.

  En la aplicación de pabellón se definen dos módulos. _Atención quirúrgica_ muestra los casos activos del flujo diario de pabellón y permite ejecutar acciones. _Atenciones anteriores_ permite consultar casos finalizados o suspendidos y revisar documentos clínicos registrados. Cada módulo monta componentes sobre los espacios provistos por la worklist: banner, barra de filtros y grilla. La grilla prioriza información operacional suficiente para actuar sobre el caso sin sobrecargar la pantalla: paciente, documento, ubicación, especialidad, intervenciones, programación, estado y acciones disponibles. Los estilos, íconos y recursos visuales se ubican en la skin de la aplicación dentro de `shared`, lo que permite mantener continuidad con la experiencia visual del hospital y adaptar la interfaz sin mezclar presentación con lógica de flujo.

  La atención quirúrgica adaptada por el frontend contiene un estado, representado por una clase de estado. Como se mostró en la @fig-estados-proceso-quirurgico, cada estado corresponde a una etapa del proceso. Cada clase de estado declara las acciones disponibles para esa etapa, por lo que la lista de trabajo solo muestra acciones válidas para el caso seleccionado.

  Cada acción se modela como una clase independiente con nombre, etiqueta, visibilidad, condición de ejecución e interacción esperada. Las acciones simples se resuelven con una operación directa o la apertura de una vista existente. Las acciones complejas se delegan a orquestaciones. Un registro común ordena las acciones para priorizar las principales y agrupar las secundarias.

  Esta división en clases responde a la cantidad de estados y a la complejidad de cada uno. En la versión anterior, los estados y las acciones se manejaban mediante condicionales y un diccionario compartido, lo que acoplaba la lógica de visualización, validación y ejecución en un mismo lugar. Esa estructura dificultaba entender qué acciones correspondían a cada etapa y agregar nuevas transiciones sin afectar código ajeno. En el diseño actual se optó por separar la lógica de cada estado y acción en clases propias, aprovechando que el flujo quirúrgico ya define etapas, acciones y condiciones de forma conceptual. Traducir esa estructura a un modelo de clases hace que el código sea más mantenible y extensible a medida que el flujo evoluciona.

  La segunda aplicación es el Monitor de pabellones, orientado a entregar visibilidad agregada sobre el uso de quirófanos. Esta aplicación se construye sobre `WebApp`, carga pabellones desde ubicaciones del área de pabellón y obtiene atenciones quirúrgicas desde atenciones clínicas y citas de Agenda. Luego agrupa la información por pabellón, separando la cirugía en curso de las cirugías programadas o próximas. En este monitor, los estados no habilitan acciones sino que clasifican la información mostrada: los estados intraoperatorios identifican la cirugía en curso, mientras que los estados de preparación y programación permiten listar próximas cirugías. Por esto, el monitor funciona como una herramienta de coordinación interna y no como una interfaz de edición del caso.

  La tercera aplicación es el Monitor de pacientes, orientado a familiares o acompañantes en sala de espera. Esta aplicación también se construye sobre `WebApp`, consulta atenciones quirúrgicas y citas, y adapta los datos a un modelo reducido. A diferencia de la vista operativa, elimina acciones clínicas y restringe la información visible a datos necesarios para orientación general: nombre abreviado del paciente, estado del proceso y ubicación o etapa actual. Además, reutiliza los estados del flujo pero los simplifica para un público no clínico; por ejemplo, los estados intraoperatorios se presentan como una etapa general de pabellón, evitando exponer detalles clínicos innecesarios.

  Las tres aplicaciones comparten un principio de diseño: todas dependen del mismo estado operacional del proceso quirúrgico, pero cada una lo traduce a una experiencia distinta. La aplicación de pabellón permite operar; el Monitor de pabellones permite coordinar; y el Monitor de pacientes permite informar. Esta separación mantiene la coherencia del flujo y evita duplicar reglas clínicas, pero permite ajustar componentes, columnas, filtros y nivel de detalle según el usuario al que se dirige cada pantalla.

  == Diseño del orquestador dinámico

  Las acciones complejas del flujo se diseñaron como orquestaciones dinámicas. En este contexto, una orquestación ejecuta una lista de actividades en orden, usando parámetros de entrada, respuestas previas y condiciones de ejecución. Ejemplos de este tipo son aceptar una orden, recepcionar un paciente, finalizar recuperación o suspender una cirugía.

  Esta decisión responde a que varias acciones del flujo quirúrgico no corresponden a una única operación de backend. Una acción visible para el usuario puede requerir consultar contexto, actualizar citas, crear o modificar atenciones, registrar hitos, generar tareas o sincronizar información con Gestión Hospitales. Codificar esas secuencias directamente en el frontend habría acoplado la interfaz a detalles de servicios y habría dificultado cambios posteriores.

  Además, muchas de estas acciones comparten una estructura similar: reciben parámetros, validan entrada, consultan datos, ejecutan llamadas HTTP, usan respuestas previas y deciden si ciertos pasos deben omitirse según el estado del caso. Por ello, el diseño del orquestador dinámico buscó entregar un mecanismo común para coordinar acciones acotadas y reutilizables, sin reconstruir un nuevo motor de procesos.

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

  El diseño considera que la lista de trabajo quirúrgica debe actualizarse ante cambios en las entidades que componen el flujo: atenciones de HLTH, citas de Agenda, indicaciones quirúrgicas, evaluaciones y traslados. Las orquestaciones dinámicas del flujo son asíncronas: cuando el frontend solicita iniciar una orquestación, la respuesta solo confirma que el workflow fue instanciado, no que todas sus actividades terminaron. Por eso, para mostrar el resultado real de una acción es necesario escuchar los eventos que emiten los servicios al actualizar las entidades relevantes. Además, tener eventos permite que la aplicación funcione en tiempo real, de modo que los usuarios puedan reaccionar rápidamente ante cambios originados desde otra persona usuaria, otra vista de Lahuén o una integración externa.

  El servicio de SSE debe extenderse para que acepte filtros con listas de valores. Sin esta capacidad, la lista quirúrgica necesitaría abrir varias conexiones SSE para escuchar todos los eventos relevantes, porque un filtro solo permitía una coincidencia puntual. Permitir listas de valores hace posible usar un mismo filtro para escuchar más de un tipo de evento o más de un identificador, reduciendo la cantidad de conexiones necesarias. Esto resulta especialmente útil para la lista de trabajo quirúrgica, que debe escuchar cambios de múltiples entidades.

  También se debe considerar un mecanismo de agrupación de actualizaciones cercanas en el tiempo, de modo que una acción orquestada que modifique varias entidades no genere múltiples recargas seguidas de la grilla.

  En el backend, las suscripciones BPM ya permiten instanciar workflows de Temporal a partir de eventos, pero requieren que el workflow exista como implementación específica. En el flujo quirúrgico se prevé que muchas acciones se gatillen a partir de eventos; por eso, para no tener que crear un workflow nuevo por cada automatización, se debe implementar un mecanismo que permita instanciar una orquestación dinámica indicando el identificador de la orquestación y sus parámetros de entrada. El workflow correspondiente debe leer la configuración asociada a ese identificador y ejecutar la secuencia de actividades configurada. Así, las automatizaciones del flujo quirúrgico reutilizan el mismo motor de orquestaciones dinámicas usado por las acciones de usuario.

]

#capitulo(title: "Implementación")[
  Este capítulo describe cómo se materializó el diseño presentado anteriormente. La implementación combinó cambios en la aplicación frontend, ajustes en microservicios existentes, configuraciones de datos, integración con Gestión Hospitales, uso de BPM y Temporal, definición de orquestaciones dinámicas y suscripciones a eventos, incorporando el nuevo flujo quirúrgico dentro de la arquitectura vigente de la Plataforma Lahuén.

  La implementación se realizó de manera incremental. Primero se construyó una lista de trabajo capaz de mostrar casos quirúrgicos desde fuentes distintas. Luego se agregaron acciones clínicas y operacionales, se integraron formularios, se incorporaron eventos para actualización de la grilla y se definieron orquestaciones para las acciones que requerían coordinar varios servicios. Finalmente, se conectó Gestión Hospitales con la nueva versión del módulo, permitiendo que las programaciones quirúrgicas electivas ingresaran al flujo a través de citas de Agenda.

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

  El estado persistido en las entidades no se guarda como instancia de clase, sino como `stateKey` dentro de `extendedData`. Ese valor conserva la información mínima del estado, principalmente `id` y `description`, porque originalmente los estados se representaban mediante un identificador y una descripción. Para mantener esa forma de persistencia y diferenciar cada estado de manera única, cada clase de estado conserva ambos valores y `toJSON` entrega la estructura que necesita el formateador de estado para mostrarlo con diseño en la tabla de trabajo.

  A partir de esa persistencia fue necesario implementar un mecanismo que tradujera el `stateKey` guardado en la entidad a una clase de estado de la aplicación. Para esto se implementó `RegistroEstados`, una clase que mantiene de forma global el conjunto de estados disponibles y su orden operacional. Con ese registro, la lista de trabajo puede obtener el orden de un estado para ordenar filas según la secuencia del flujo quirúrgico, y también puede instanciar el estado específico de una fila usando el `stateKey` recibido desde `extendedData`.

  `EstadoBase` concentra el contrato común de los estados. La clase expone `id`, `description`, `text` y `textClass`, y mantiene una referencia a la atención quirúrgica asociada. `text` y `textClass` se agregaron para que algunos estados puedan mostrar un mensaje adicional en la tabla de trabajo. Con esto se implementó, por ejemplo, la visualización de un aviso cuando el protocolo quirúrgico sigue pendiente y la atención ya se encuentra en etapas finales.

  Los estados que representan hitos relevantes del flujo también exponen `nombreHito`. Esta propiedad permite registrar el momento en que comienza un hito de pabellón: cuando una atención avanza de estado, la acción que realiza el cambio puede usar `nombreHito` junto con la fecha actual para guardar el inicio de ese hito en los datos de la atención.

  El estado también centraliza el manejo de acciones mediante `setActions`. Cada estado declara las acciones que pueden aplicar a esa etapa del flujo; luego inyecta la instancia del plugin, ordena las acciones con `RegistroAcciones`, descarta las que no cumplen `canExecute` y construye el mapa que recibe la fila. Esta centralización es relevante porque la lista de trabajo tiene muchas acciones posibles, pero solo tres espacios visuales para acciones con ícono. El estado que contiene las acciones muestra las tres primeras acciones más relevantes y mantiene colapsadas las restantes como acciones secundarias.

  === Modelo base de acciones de atención quirúrgica <sec-modelo-base-acciones-atencion-quirurgica>

  Las acciones se implementaron como clases derivadas de `AccionBase`, según la estructura mostrada en la @fig-modelo-estados-acciones. Cada instancia mantiene una referencia al estado que la creó y, por medio de ese estado, accede a la `AtencionQuirurgica` sobre la cual opera. La clase base define el contrato común de una acción: nombre interno, etiqueta visible, tooltip, visibilidad, condición de ejecución, inicio de ejecución, confirmación y despacho de eventos hacia el plugin.

  La disponibilidad de una acción se determina en dos niveles. El primero es el estado operacional: una acción solo puede aparecer si el estado actual la declaró dentro de sus acciones posibles mediante `setActions`, como se describió en la sección anterior. Esto representa las operaciones que tienen sentido para una etapa del flujo quirúrgico.

  El segundo nivel corresponde a las condiciones propias de la acción. Para esto se implementó `canExecute`, que permite decidir si una acción declarada por el estado debe mostrarse efectivamente para una atención específica. Esta comprobación usa los datos de la `AtencionQuirurgica` y permite ocultar acciones cuando faltan condiciones necesarias, como información de traslado, evaluaciones requeridas o datos específicos en `extendedData`. De esta forma, los estados definen el conjunto posible de acciones y cada acción decide si cumple las condiciones para quedar disponible en la fila.

  El flujo de ejecución se implementó en dos fases. `trigger` inicia la acción y controla la interacción inicial con la interfaz. Su responsabilidad es preparar la operación, solicitar datos cuando corresponde y delegar al plugin la apertura del componente necesario. `commit` ejecuta la operación confirmada con los datos ya capturados y con el usuario de sesión agregado por el plugin. Para coordinar ambas fases, la acción solicita al plugin ejecutar el `commit` correspondiente. Así, la acción conserva la lógica de negocio de la operación, mientras el plugin actúa como intermediario para ejecutar efectos sobre la aplicación, servicios y formularios.

  `dispatchEvent` recibe el nombre del evento y su carga útil, y delega la llamada en la instancia del plugin asociada a la acción. Se usa para enviar al `WorklistSurgicalProcessPlugin` la instrucción que debe ejecutarse y los datos necesarios para resolverla. El plugin atiende esos eventos con las funciones registradas en `worklistInit` para manejarlos.

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

  - Documento: muestra el documento de identificación del paciente.
  - Nombre: muestra el nombre completo del paciente y el nombre social si existe.
  - Edad: calcula la edad a partir de la fecha de nacimiento del paciente.
  - Especialidad: muestra la especialidad de la intervención que se realizará.
  - Intervención(es): muestra primero las intervenciones asociadas al caso, que corresponden a la información quirúrgica principal, y luego los diagnósticos principales del paciente como información secundaria en gris.
  - Programación: agrupa en una misma celda el nombre abreviado del clínico responsable, la fecha programada y el pabellón donde se programó la intervención. Si la intervención corresponde al día actual, la fecha se muestra como hora; si corresponde a otro día, se muestra también el día de la intervención.
  - Ubicación: muestra el área y cupo actual del paciente. Esta columna permite identificar rápidamente la ubicación del paciente dentro del flujo clínico-operacional.
  - Estado: muestra la descripción del estado actual con el estilo estándar de estados y el color definido por la empresa para cada estado.
  - Acciones: muestra las acciones disponibles para la fila. Las acciones expuestas se presentan como íconos visibles; las acciones no expuestas se muestran al presionar los tres puntos del final como un listado con la descripción de cada acción.

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

  El módulo de atenciones anteriores monta el mismo banner y la misma grilla base, pero usa la barra de filtros `CPatientsPreviousFilterbar`. A diferencia del módulo de atención quirúrgica, que está orientado a operar sobre los casos activos del día, este módulo funciona como una búsqueda histórica de atenciones cerradas.

  La tabla reutiliza el mismo componente `CPatientsGrid`, pero oculta la columna `Ubicación`. Como las atenciones mostradas ya están finalizadas o canceladas, no corresponde mostrar una ubicación actual para atenciones que no están activas. La vista muestra solo datos históricos conservados de la atención. Por la misma razón, el módulo elimina los filtros asociados a sector o ubicación y mantiene solo el filtro por fecha de programación.

  === Obtención de datos de atenciones anteriores

  La carga de atenciones anteriores se implementó en `fetchAtencionesAnteriores`. A diferencia del módulo operativo, este método exige una fecha válida antes de consultar datos; si no existe fecha, retorna una lista vacía. Con esto la búsqueda histórica queda acotada a una ventana explícita y no carga atenciones cerradas sin criterio temporal.

  El método construye un filtro histórico para `PatientService` usando el tipo de atención quirúrgica, los estados finalizada y cancelada, y la fecha seleccionada. Luego consulta HLTH y adapta los registros de la misma forma que el resto de atenciones que provienen de un `PatientService`. El método de adaptación identifica si la atención está finalizada o cancelada y devuelve la instancia de `AtencionQuirurgica` con el estado correspondiente. El resultado es la misma estructura de fila usada por el módulo principal, pero construida solo desde atenciones clínicas ya cerradas.

  == Aplicaciones de monitoreo

  Además de la lista de trabajo operativa, se implementaron dos aplicaciones de monitoreo sobre el mismo flujo quirúrgico: el Monitor de pabellones y el Monitor de pacientes. Como la versión actual dejó de utilizar instancias de workflows del motor de procesos deprecado, las aplicaciones anteriores de monitoreo ya no eran compatibles con la nueva representación del proceso. Por ello, se reconstruyeron sobre la arquitectura frontend actual de Lahuén, leyendo atenciones clínicas y citas quirúrgicas desde los servicios de la plataforma.

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

  Cuando una acción requiere guardar un cambio o ejecutar una operación, emite un evento que el plugin `WorklistSurgicalProcessPlugin` escucha. Las acciones se encargan de construir el cuerpo a enviar, o de decidir qué operación ejecutar y con qué datos; el plugin, por su parte, tiene acceso a las APIs de la plataforma y realiza las llamadas correspondientes para completar la acción. De este modo, la lógica de presentación de la lista de trabajo se separa de la forma en que se ejecutan los cambios.

  Para las acciones que modifican el estado de una atención, la interfaz solicita confirmación antes de ejecutar la operación. Esta decisión se alinea con la heurística de prevención de errores, que recomienda pedir confirmación antes de acciones potencialmente propensas a error @BaloianPino2024Usabilidad. Además, una vez ejecutada la acción, la aplicación muestra retroalimentación explícita de éxito o fracaso, siguiendo el principio de visibilidad del estado del sistema y las recomendaciones sobre mensajes de error comprensibles @BaloianPino2024Usabilidad. La @fig-ejemplo-mensaje-exito muestra un ejemplo de confirmación visual después de egresar correctamente a un paciente.

  #figure(
    image("./imagenes/cap06-ejemplo-de-mensaje-exito.png", width: 50%),
    caption: [Mensaje de éxito mostrado después de egresar a un paciente.],
  ) <fig-ejemplo-mensaje-exito>

  === Ver ficha

  La acción `Ver ficha` permite abrir la ficha clínica del paciente en una nueva pestaña. La @fig-accion-ver-ficha-icon muestra la acción disponible en la lista de trabajo. Al seleccionarla, el plugin resuelve la atención clínica asociada y abre la ficha del paciente (aplicación EHR) en una nueva pestaña del navegador.

  #figure(
    image("./imagenes/cap06-ver-ficha-icon.png", width: 30%),
    caption: [Acción para abrir la ficha clínica desde la lista de trabajo quirúrgica.],
  ) <fig-accion-ver-ficha-icon>

  La acción se muestra siempre que exista una atención desde la cual abrir la ficha. Esa atención puede ser la atención de pabellón, que se genera al recepcionar al paciente, o una atención de urgencia u hospitalización que permanezca abierta mientras el paciente espera ser recepcionado en pabellón. En los casos donde no hay una ficha abierta para mostrar, la acción no aparece.

  === Aceptar orden

  La acción `Aceptar orden` permite aceptar la solicitud e iniciar el proceso quirúrgico. La @fig-accion-aceptar-orden-icon muestra la acción disponible en la lista de trabajo. Su objetivo es programar la intervención y convertir la indicación en una cita quirúrgica operable por el resto del flujo.

  #figure(
    image("./imagenes/cap06-aceptar-orden-icon.png", width: 30%),
    caption: [Acción para aceptar una orden quirúrgica solicitada desde la lista de trabajo.],
  ) <fig-accion-aceptar-orden-icon>

  Al seleccionarla, la acción utiliza el plugin para abrir un panel lateral con el formulario de programación de la intervención, siguiendo el mecanismo de side panels descrito en el @anexo-arquitectura-plataforma, como se observa en la @fig-accion-aceptar-orden. La sección de información del paciente se reutiliza desde el plugin `standard`; el resto del formulario recibe desde la `AtencionQuirurgica` las intervenciones y el tiempo operatorio estimado. Con esos datos permite seleccionar el pabellón y la fecha de inicio de la intervención.

  #figure(
    image("./imagenes/cap06-aceptar-orden.png", width: 100%),
    caption: [Panel para programar la intervención al aceptar una orden quirúrgica de urgencia.],
  ) <fig-accion-aceptar-orden>

  Al confirmar, se genera el cuerpo para la creación de la cita programada, incluyendo el usuario ejecutor, la fecha de inicio, el pabellón seleccionado, el identificador de la indicación y los diagnósticos. Luego, el plugin utiliza la API de BPM para iniciar la orquestación dinámica que crea la cita y marca la indicación como iniciada. El comportamiento de esa orquestación se describe en la @sec-orquestacion-aceptar-orden-urgencia.

  === Recepcionar paciente

  La acción `Recepcionar paciente` permite recepcionar un paciente en pabellón, iniciando la atención de pabellón. La @fig-accion-recepcionar-paciente-icon muestra la acción disponible en la lista de trabajo.

  #figure(
    image("./imagenes/cap06-recepcion-paciente-icon.png", width: 30%),
    caption: [Acción para recepcionar al paciente desde la lista de trabajo quirúrgica.],
  ) <fig-accion-recepcionar-paciente-icon>

  Al seleccionarla, la acción utiliza el plugin para abrir un panel lateral con el formulario para recepcionar al paciente, como se observa en la @fig-accion-recepcionar-paciente. La sección de información del paciente se reutiliza desde el plugin `standard`; el resto del formulario recibe la `AtencionQuirurgica` y permite seleccionar la ubicación de destino. Para esta acción solo se muestran como sectores posibles CMA y Recuperación, que son las áreas habilitadas para recepcionar un paciente.

  #figure(
    image("./imagenes/cap06-recepcion-paciente.png", width: 100%),
    caption: [Panel de recepción de paciente, con selección de sector y ubicación de destino.],
  ) <fig-accion-recepcionar-paciente>

  Al confirmar, se construye el cuerpo de la orquestación con el identificador de la cita, la información de la ubicación seleccionada, el usuario ejecutor, el origen de la atención (electiva o urgencia) y el identificador del paciente. Luego, el plugin utiliza la API de BPM para iniciar la orquestación dinámica de recepción. El comportamiento de esa orquestación, que deriva entre flujo electivo y de urgencia, se describe en la @sec-orquestacion-recepcionar-paciente.

  === Ingresar a Pabellón

  La acción `Ingresar a Pabellón` permite pasar al paciente desde la ubicación preparatoria al quirófano donde se realizará la intervención. La @fig-accion-ingresar-a-pabellon-icon muestra el ícono de la acción.

  #figure(
    image("./imagenes/cap06-accion-ingresar-a-pabellon-icon.png", width: 30%),
    caption: [Acción para ingresar al paciente a pabellón desde la lista de trabajo quirúrgica.],
  ) <fig-accion-ingresar-a-pabellon-icon>

  Al seleccionarla, el plugin abre un panel lateral con el formulario de cambio de ubicación, reutilizando la información del paciente desde `standard` y mostrando el sector `Pabellón` con su ubicación correspondiente, como se observa en la @fig-accion-ingresar-a-pabellon. El pabellón se precarga con el programado, pero el usuario puede seleccionar otro cuando la operación finalmente se realice en un quirófano distinto.

  #figure(
    image("./imagenes/cap06-accion-ingresar-a-pabellon.png", width: 100%),
    caption: [Panel para ingresar al paciente a pabellón.],
  ) <fig-accion-ingresar-a-pabellon>

  Al confirmar, el plugin utiliza la API de HLTH para cambiar la ubicación del paciente al pabellón seleccionado. Esta operación aprovecha el mecanismo que actualiza los datos extendidos de la atención al mismo tiempo que se produce el cambio de ubicación, descrito en la @sec-hlth-atencion-quirurgica-ubicacion-datos-extendidos. Gracias a esto, además del movimiento del paciente, la acción registra el hito de ingreso a pabellón con la fecha y hora actuales; guarda la ubicación efectivamente utilizada, que puede diferir de la programada y se requiere para reportes; conserva la ubicación anterior para poder revertir un ingreso accidental; y actualiza el estado interno de la atención de pabellón, de modo que el caso queda listo para continuar con los hitos intraoperatorios.

  === Continuar cirugía

  La acción `Continuar cirugía` agrupa el avance de los hitos intraoperatorios del proceso quirúrgico. Se trata de una misma clase de acción parametrizada que se instancia de forma distinta en cada estado intraoperatorio, adaptando su etiqueta visible y el hito que registra según la etapa actual. La @fig-accion-continuar-cirugia-icon muestra el ícono de la acción en estado `Anestesia iniciada`, donde la etiqueta corresponde a `Iniciar cirugía`.

  #figure(
    image("./imagenes/cap06-accion-continuar-cirugia-icon.png", width: 30%),
    caption: [Acción `Continuar cirugía` mostrada como `Iniciar cirugía` en estado `Anestesia iniciada`.],
  ) <fig-accion-continuar-cirugia-icon>

  Al seleccionarla, el plugin abre un panel lateral con el formulario de continuación del proceso. El formulario muestra la información del paciente, los datos de programación de la intervención y una sección con la línea de tiempo de las etapas intraoperatorias: recepción en pabellón, anestesia iniciada, cirugía iniciada, cirugía finalizada y anestesia finalizada. El hito que corresponde al estado actual se resalta y muestra su hora de inicio; los hitos ya completados se muestran sin resaltar, con su hora de inicio registrada; los hitos posteriores aparecen menos resaltados, casi ocultos, de modo que no destaquen, y solo muestran su nombre. Esta visualización permite al equipo confirmar en qué momento del proceso se encuentra el paciente antes de avanzar.   Además, el panel muestra el tiempo transcurrido de la intervención y el tiempo total en pabellón, como se observa en la @fig-accion-continuar-cirugia. El tiempo transcurrido de la intervención se mide desde el inicio de la cirugía hasta el final de la cirugía. El tiempo total en pabellón se mide desde que el paciente entra al pabellón hasta que sale del pabellón.

  #figure(
    table(
      columns: (1fr, 1fr, 1fr),
      inset: 8pt,
      align: horizon,
      table.header([*Estado actual*], [*Etiqueta mostrada*], [*Hito registrado*]),
      [En pabellón], [Iniciar anestesia], [Anestesia iniciada],
      [Anestesia iniciada], [Iniciar cirugía], [Cirugía iniciada],
      [Cirugía iniciada], [Finalizar cirugía], [Cirugía finalizada],
      [Cirugía finalizada], [Finalizar anestesia], [Anestesia finalizada],
    ),
    caption: [Instancias de la acción `Continuar cirugía` según el estado intraoperatorio.],
  ) <tbl-continuar-cirugia>

  #figure(
    image("./imagenes/cap06-accion-continuar-cirugia.png", width: 100%),
    caption: [Panel de `Continuar cirugía` con los hitos del proceso y la etapa actual resaltada.],
  ) <fig-accion-continuar-cirugia>

  Al confirmar, el plugin utiliza la API de HLTH para actualizar los datos extendidos de la atención, registrando la fecha y hora del hito que corresponde al siguiente estado y actualizando el estado interno de la atención. Después de cada avance, excepto tras finalizar la anestesia, la acción vuelve a abrir automáticamente el formulario para permitir que el equipo registre los hitos de forma continua sin tener que volver a seleccionar la acción en la grilla. Así, una sola clase de acción coordina todo el avance intraoperatorio, adaptando su etiqueta y su hito objetivo al estado en que se encuentre la atención.

  === Iniciar recuperación

  La acción `Iniciar recuperación` se muestra cuando el paciente ha finalizado la etapa intraoperatoria y debe trasladarse desde el pabellón a una ubicación de recuperación. La @fig-accion-iniciar-recu-icon muestra el ícono de la acción disponible en la lista de trabajo.

  #figure(
    image("./imagenes/cap06-accion-iniciar-recu-icon.png", width: 30%),
    caption: [Acción para iniciar la recuperación del paciente desde la lista de trabajo quirúrgica.],
  ) <fig-accion-iniciar-recu-icon>

  Al seleccionarla, el plugin abre un panel lateral con el formulario de cambio de ubicación, reutilizando la información del paciente desde `standard` y mostrando el sector `Recuperación` con su ubicación correspondiente, como se observa en la @fig-accion-iniciar-recu.

  #figure(
    image("./imagenes/cap06-accion-iniciar-recu.png", width: 100%),
    caption: [Panel para iniciar la recuperación del paciente.],
  ) <fig-accion-iniciar-recu>

  Al confirmar, el plugin utiliza la API de HLTH para cambiar la ubicación del paciente a la ubicación de recuperación seleccionada. Al igual que en el ingreso a pabellón, esta operación aprovecha el mecanismo que actualiza los datos extendidos de la atención en el mismo momento del cambio de ubicación, descrito en la @sec-hlth-atencion-quirurgica-ubicacion-datos-extendidos. Con esto, además del movimiento del paciente, la acción registra el hito de inicio de recuperación y actualiza el estado interno de la atención, de modo que el caso queda listo para finalizar la recuperación una vez que el paciente esté en condiciones de continuar su egreso o traslado.

  === Finalizar recuperación

  La acción `Finalizar recuperación` permite cerrar la etapa de recuperación del paciente una vez que ya no requiere permanecer en esa unidad. Al seleccionarla, se despliega un diálogo de confirmación con el nombre del paciente.

  #figure(
    image("./imagenes/cap06-accion-finalizar-recuperacion-icon.png", width: 30%),
    caption: [Acción para finalizar la recuperación desde la lista de trabajo quirúrgica.],
  ) <fig-accion-finalizar-recuperacion-icon>

  El diálogo no pide datos adicionales: solo confirma la acción antes de ejecutarla, como muestra la @fig-accion-finalizar-recuperacion. Al aceptar, el plugin utiliza la API de BPM para iniciar la orquestación de finalizar recuperación descrita en la @sec-orquestacion-finalizar-recuperacion. Esa orquestación decide en qué estado dejar la atención, ya sea `Esperando Alta` o `Esperando traslado`, según la situación del paciente. Cuando el resultado es `Esperando traslado`, además conserva la referencia al traslado activo para que esa información pueda reutilizarse en el frontend.

  #figure(
    image("./imagenes/cap06-accion-finalizar-recuperacion.png", width: 50%),
    caption: [Confirmación para finalizar la recuperación del paciente.],
  ) <fig-accion-finalizar-recuperacion>

  === Iniciar traslado

  La acción `Iniciar traslado` permite dar comienzo al traslado del paciente cuando ya no debe permanecer en pabellón o en recuperación. Se muestra solo si la atención tiene un traslado asociado pendiente, como muestra la @fig-accion-iniciar-traslado-icon.

  #figure(
    image("./imagenes/cap06-accion-iniciar-traslado-icon.png", width: 30%),
    caption: [Acción para iniciar el traslado del paciente desde la lista de trabajo quirúrgica.],
  ) <fig-accion-iniciar-traslado-icon>

  Al seleccionarla, el plugin abre un diálogo de confirmación con el destino del traslado, como se observa en la @fig-accion-iniciar-traslado. El mensaje solo pide validar la operación antes de ejecutarla y no solicita información adicional.

  #figure(
    image("./imagenes/cap06-accion-iniciar-traslado.png", width: 55%),
    caption: [Confirmación para iniciar el traslado del paciente.],
  ) <fig-accion-iniciar-traslado>

  Al confirmar, el plugin utiliza la API de BPM para iniciar la orquestación de iniciar traslado descrita en la @sec-orquestacion-traslados. Esa orquestación ejecuta el movimiento del paciente, registra el hito de tránsito y actualiza la atención al estado `En tránsito`. De esta forma, el frontend solo dispara el inicio del traslado y la lógica de transición queda concentrada en la orquestación.

  === Devolver a unidad de origen

  La acción `Devolver a unidad de origen` permite retornar al paciente a la unidad desde la que se originó la atención. Se muestra cuando la cirugía no corresponde a cirugía mayor ambulatoria, es decir, cuando el paciente proviene de urgencia o fue hospitalizado antes del ingreso a pabellón. En esos casos se guarda la ubicación de origen durante la recepción; si posteriormente el paciente no tiene un traslado solicitado pero sí tiene un origen registrado, se muestra esta opción para devolverlo a esa unidad. Antes de ejecutarla, muestra una confirmación con la ubicación de destino.

  #figure(
    image("./imagenes/cap06-accion-devolver-a-unidad-de-origen-icon.png", width: 30%),
    caption: [Acción para devolver al paciente a su unidad de origen.],
  ) <fig-accion-devolver-unidad-origen-icon>

  #figure(
    image("./imagenes/cap06-accion-devolver-a-unidad-de-origen.png", width: 60%),
    caption: [Confirmación para devolver al paciente a la unidad de origen.],
  ) <fig-accion-devolver-unidad-origen>

  Al aceptar, el plugin utiliza la API de BPM para iniciar la orquestación de devolución a unidad de origen descrita en la @sec-orquestacion-traslados. Esa orquestación registra el traslado correspondiente y actualiza la atención para reflejar que el paciente queda en tránsito hacia su unidad de origen.

  === Egresar paciente

  La acción `Egresar paciente` ejecuta el egreso del paciente. Antes de ejecutarse, solicita confirmación al usuario mediante el patrón de modales del @anexo-arquitectura-plataforma.

  #figure(
    image("./imagenes/cap06-accion-egresar-pacinte-icon.png", width: 30%),
    caption: [Acción para egresar al paciente desde la lista de trabajo.],
  ) <fig-accion-egresar-paciente-icon>

  #figure(
    image("./imagenes/cap06-accion-egresar-paciente.png", width: 60%),
    caption: [Confirmación para egresar al paciente.],
  ) <fig-accion-egresar-paciente>

  Al aceptar, se utiliza la API de HLTH para ejecutar la acción de cierre de la atención, y se muestra el mensaje de éxito correspondiente.

  === Cargar evaluación

  La acción `Cargar evaluación` no representa un único formulario fijo. Es una clase parametrizada por tipo de evaluación, de modo que el mismo modelo de acción puede mostrarse con etiquetas, títulos y condiciones distintas. En la implementación actual se usa para la evaluación preanestésica y el protocolo quirúrgico. Ambas comparten el mismo mecanismo de carga y se diferencian principalmente por el tipo de evaluación, el momento del flujo en que se muestran y la información clínica que registran.

  El comportamiento común de la acción es el siguiente. Para mostrar la acción se verifica que la atención aún no tenga registrada una evaluación completa del tipo correspondiente; de este modo, la acción aparece solo si todavía no existe una evaluación de ese tipo. Al seleccionarla, se busca el último borrador existente para ese tipo de evaluación y se solicita al plugin cargar el formulario correspondiente, junto con los datos del paciente, la atención y el borrador cuando existe. El plugin carga el formulario mediante el mecanismo de carga de formularios clínicos embebidos descrito en el @anexo-arquitectura-plataforma. El formulario se muestra dentro de un modal de paciente: a la izquierda se presenta la cápsula con datos básicos del paciente y al centro se carga el formulario clínico de la aplicación EHR mediante `iframe`.

  Para la evaluación preanestésica, la acción se muestra bajo la etiqueta `Evaluación preanestésica`, como se observa en la @fig-accion-eval-pre-icon. El formulario permite registrar la evaluación preanestésica completa del paciente, incluyendo antecedentes, revisión por sistemas, información de la intervención y otros datos clínicos relevantes previos a la cirugía, como muestra la @fig-accion-eval-pre.

  #figure(
    image("./imagenes/cap06-accion-eval-pre-icon.png", width: 35%),
    caption: [Acción para cargar la evaluación preanestésica en estado preoperatorio.],
  ) <fig-accion-eval-pre-icon>

  #figure(
    image("./imagenes/cap06-accion-eval-pre.png", width: 100%),
    caption: [Formulario embebido para registrar la evaluación preanestésica desde la lista de trabajo quirúrgica.],
  ) <fig-accion-eval-pre>

  Para el protocolo quirúrgico, la acción se muestra durante y después de la etapa intraoperatoria, bajo la etiqueta `Protocolo quirúrgico`, como se observa en la @fig-accion-protocolo-qx-icon. El formulario carga el documento operatorio asociado a la intervención, precargando algunos datos de la sección 'Detalle de la intervención', como muestra la @fig-accion-protocolo-qx.

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

  La acción `Pausa quirúrgica` permite registrar las tres pausas de seguridad del acto quirúrgico durante la etapa intraoperatoria. Es una acción parametrizada: al instanciarse, detecta cuál es la siguiente pausa pendiente y ajusta su etiqueta y su comportamiento para registrar la pausa correspondiente. Se muestra como una acción visible en estados intraoperatorios; cuando hay muchas acciones disponibles, la interfaz puede agruparlas en el menú de tres puntos, como se observa en la @fig-accion-pausa-qx-icon.

  #figure(
    image("./imagenes/cap06-accion-pausa-qx-icon.png", width: 30%),
    caption: [Acción para registrar una pausa quirúrgica desde la lista de trabajo.],
  ) <fig-accion-pausa-qx-icon>

  Para soportar cada pausa se configuraron tres tipos de signo vital: `Primera Pausa Quirúrgica`, `Segunda Pausa Quirúrgica` y `Tercera Pausa Quirúrgica`. Cada uno define, dentro de la escala `pausaQuirurgica`, una checklist con las verificaciones propias de su momento: antes de la inducción anestésica, antes de la incisión de la piel y antes de que el paciente abandone el pabellón. Las preguntas cubren identidad del paciente, sitio quirúrgico, consentimiento, funcionamiento de equipos, conteo de elementos, muestras biológicas y destino posterior, entre otros aspectos de seguridad.

  Al seleccionarla, la acción solicita al plugin mostrar el formulario de checklist correspondiente a la pausa actual, indicando el tipo de signo vital y la atención asociada. El formulario se presenta como un modal con la información del paciente a la izquierda y las secciones de la checklist a la derecha, siguiendo el mecanismo de formularios tipo checklist descrito en el @anexo-arquitectura-plataforma, como muestra la @fig-accion-pausa-qx.

  #figure(
    image("./imagenes/cap06-accion-pausa-qx.png", width: 100%),
    caption: [Formulario de registro de la primera pausa quirúrgica.],
  ) <fig-accion-pausa-qx>

  La acción solo está disponible mientras exista una pausa pendiente por registrar; una vez completadas las tres, deja de mostrarse. Al guardarse, cada pausa queda asociada a la atención clínica del paciente y la lista de trabajo se actualiza para reflejar el avance del checklist de seguridad quirúrgica.

  === Cuidados intraoperatorios

  La acción `Cuidados intraoperatorios` permite registrar, durante la etapa intraoperatoria, una serie de cuidados de enfermería asociados al paciente en quirófano. Se presenta dentro del menú de tres puntos durante la etapa intraoperatoria, como se observa en la @fig-accion-cuidados-intraoperatorios-icon.

  #figure(
    image("./imagenes/cap06-accion-cuidados-intraoperatorios-icon.png", width: 30%),
    caption: [Acción para registrar cuidados intraoperatorios disponible en el menú de tres puntos.],
  ) <fig-accion-cuidados-intraoperatorios-icon>

  La acción reutiliza el mecanismo de formularios de escala o checklist de la plataforma. Para este caso se configuró una checklist con preguntas operacionales relevantes, como la posición quirúrgica, la protección de puntos de apoyo y la limpieza de piel preoperatoria. Cada pregunta incluye sus opciones y, en algunos casos, un campo de observaciones. El registro se guarda como una evaluación asociada a la atención del paciente.

  Al ejecutarla, la acción solicita al plugin mostrar el formulario de checklist correspondiente, indicando el tipo de signo vital y la atención asociada. El formulario se muestra como un modal con la información del paciente a la izquierda y las preguntas de la checklist a la derecha, usando el mecanismo de formularios tipo checklist descrito en el @anexo-arquitectura-plataforma, como se observa en la @fig-accion-cuidados-intraoperatorios.

  #figure(
    image("./imagenes/cap06-accion-cuidados-intraoperatorios.png", width: 100%),
    caption: [Formulario de registro de cuidados de enfermería intraoperatorios.],
  ) <fig-accion-cuidados-intraoperatorios>

  La acción se muestra mientras no se hayan registrado los cuidados intraoperatorios; una vez guardados, deja de mostrarse. Este comportamiento es consistente con el resto de las evaluaciones del proceso quirúrgico, que se ocultan después de ser completadas para evitar duplicidades.

  === Cambiar ubicación

  La acción `Cambiar ubicación` permite mover al paciente dentro de las ubicaciones operacionales disponibles para su etapa actual. Se muestra desde que el paciente tiene una atención de pabellón —es decir, desde que es recepcionado— hasta que la atención finaliza. La acción se presenta en el menú de tres puntos, como muestra la @fig-accion-cambiar-ubicacion-icon.

  #figure(
    image("./imagenes/cap06-cambiar-ubicacion-icon.png", width: 35%),
    caption: [Acción dentro del menú de tres puntos para cambiar la ubicación del paciente.],
  ) <fig-accion-cambiar-ubicacion-icon>

  Al seleccionarla, la acción utiliza el plugin para abrir un panel lateral con el formulario de cambio de ubicación, como se observa en la @fig-accion-cambiar-ubicacion. La sección de información del paciente proviene del plugin `standard`; el resto del formulario usa la `AtencionQuirurgica` para restringir las áreas disponibles. Si el paciente está en pabellón, solo permite ubicaciones de pabellón; en otros casos permite CMA y Recuperación.

  #figure(
    image("./imagenes/cap06-cambiar-ubicacion.png", width: 100%),
    caption: [Panel para seleccionar una nueva ubicación del paciente.],
  ) <fig-accion-cambiar-ubicacion>

  Al confirmar, el plugin utiliza la API de HLTH para ejecutar el cambio de ubicación del `PatientService`, enviando la nueva ubicación y el usuario ejecutor. Si la operación finaliza correctamente, la grilla se actualiza para reflejar la nueva ubicación.

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

  Al seleccionar la acción, el plugin abre un panel lateral con el formulario de programación de intervención. La sección de información del paciente proviene del plugin `standard`, mientras que los datos quirúrgicos —intervenciones, tiempo operatorio, pabellón programado y fecha de inicio programada— se obtienen desde la `AtencionQuirurgica`, de modo que el usuario conserva el contexto de la cirugía y solo modifica la nueva programación. Cuando se guarda, se envía el cuerpo de actualización de la cita con el usuario ejecutor, la nueva fecha de inicio de la programación, la nueva ubicación y otros datos relevantes para ser agregados a los datos extendidos de la entidad.

  Al confirmar, el plugin utiliza la API de Agenda para actualizar la cita de origen con la nueva fecha y pabellón. Si la operación finaliza correctamente, el panel informa la nueva programación y la grilla se actualiza.

  === Revertir ingreso a Pabellón

  La acción `Revertir Ingreso a Pabellón` permite corregir un ingreso accidental al quirófano devolviendo al paciente a la etapa preoperatoria. Se presenta dentro del menú de tres puntos durante el estado `En pabellón`, como se observa en la @fig-accion-revertir-ingreso-pabellon-icon.

  #figure(
    image("./imagenes/cap06-revertir-ingreso-pabellon-icon.png", width: 30%),
    caption: [Acción para revertir el ingreso a pabellón.],
  ) <fig-accion-revertir-ingreso-pabellon-icon>

  Al seleccionarla, el plugin abre un panel lateral con el formulario de cambio de ubicación, como muestra la @fig-accion-revertir-ingreso-pabellon. El formulario precarga como ubicación de destino la ubicación preoperatoria guardada previamente al momento del ingreso, de modo que el usuario pueda devolver al paciente exactamente a donde estaba. También permite seleccionar otra ubicación de CMA o Recuperación si la situación operativa lo requiere.

  #figure(
    image("./imagenes/cap06-revertir-ingreso-pabellon.png", width: 100%),
    caption: [Panel para revertir el ingreso de un paciente a pabellón.],
  ) <fig-accion-revertir-ingreso-pabellon>

  Al guardar, el plugin utiliza la API de HLTH para ejecutar el cambio de ubicación indicando que se trata de una reversión. Aprovechando el mecanismo descrito en la @sec-hlth-atencion-quirurgica-ubicacion-datos-extendidos, la misma operación actualiza los datos extendidos de la atención, estableciendo el estado interno de vuelta a la etapa preoperatoria. De este modo, el paciente regresa tanto físicamente como operativamente a la etapa previa al ingreso a pabellón.

  === Ver PDF protocolo

  La acción `Ver PDF protocolo` permite abrir el documento generado a partir del protocolo quirúrgico ya registrado. Se presenta dentro del menú de tres puntos, como muestra la @fig-accion-ver-pdf-icon.

  #figure(
    image("./imagenes/cap06-accion-ver-pdf-icon.png", width: 30%),
    caption: [Acción para ver el PDF del protocolo quirúrgico.],
  ) <fig-accion-ver-pdf-icon>

  La acción solo aparece cuando la atención ya tiene registrado el protocolo con datos completos, es decir, cuando el documento puede generarse. Al seleccionarla, el plugin abre un modal de espera indicando que el PDF se está generando, como se observa en la @fig-accion-ver-pdf.

  #figure(
    image("./imagenes/cap06-accion-ver-pdf.png", width: 40%),
    caption: [Modal mostrado mientras se genera el PDF del protocolo quirúrgico.],
  ) <fig-accion-ver-pdf>

  Por detrás, la acción utiliza una funcionalidad de `shared` que toma los datos guardados en la evaluación del protocolo, los transforma y los envía a `FORMS` junto con el nombre del template a utilizar. `FORMS` genera el PDF a partir del template y los datos; luego la misma funcionalidad de `shared` consulta `DMS` para obtener el documento generado. El plugin recibe la respuesta y abre el PDF en una nueva pestaña del navegador. El documento reúne la información clínica y operacional registrada durante la intervención, incluyendo los datos principales de la atención, el equipo clínico y el detalle del acto quirúrgico. Un ejemplo del documento generado se incluye en el @anexo-documentos-generados.

  === Imprimir brazalete

  La acción `Imprimir brazalete` se incorporó para reutilizar el mecanismo de impresión ya existente en la plataforma. La @fig-accion-imprimir-brazalete-icon muestra la acción disponible en la lista de trabajo.

  #figure(
    image("./imagenes/cap06-imprimir-brazalete-icon.png", width: 30%),
    caption: [Confirmación para imprimir el brazalete del paciente desde la lista de trabajo quirúrgica.],
  ) <fig-accion-imprimir-brazalete-icon>

  Al seleccionarla, el plugin abre un diálogo de confirmación, como se observa en la @fig-accion-imprimir-brazalete. Si el usuario confirma, la acción utiliza una funcionalidad compartida de `shared` que, de forma similar a la generación del PDF del protocolo, prepara los datos necesarios y los envía a imprimir el brazalete del paciente.

  #figure(
    image("./imagenes/cap06-imprimir-brazalete.png", width: 50%),
    caption: [Diálogo de confirmación antes de enviar a imprimir el brazalete.],
  ) <fig-accion-imprimir-brazalete>

  === Suspender cirugía

  La acción `Suspender cirugía` permite cancelar operacionalmente una intervención desde la lista de trabajo. Esta acción se presenta dentro del menú de tres puntos, como muestra la @fig-accion-suspender-icon.

  #figure(
    image("./imagenes/cap06-accion-suspender-icon.png", width: 30%),
    caption: [Acción de suspensión disponible en el menú de tres puntos de la tabla de atención quirúrgica.],
  ) <fig-accion-suspender-icon>

  Al seleccionar la acción, el plugin abre un modal de confirmación que muestra el paciente asociado e incluye un selector de motivo, un selector de motivo específico y un campo para observaciones, como se observa en la @fig-accion-suspender. Los motivos de suspensión se obtienen desde una terminología almacenada en MongoDB que contiene la lista de motivos y submotivos por los cuales se puede suspender una cirugía.

  #figure(
    image("./imagenes/cap06-accion-suspender.png", width: 90%),
    caption: [Diálogo de confirmación y formulario de motivos para suspender una intervención quirúrgica.],
  ) <fig-accion-suspender>

  Al confirmar, se construye el cuerpo para la suspensión con el paciente, el clínico ejecutor, la cita asociada, la atención clínica asociada (cuando existe), la causa, la subcausa y las observaciones.

  Finalmente, el plugin utiliza la API de BPM para iniciar la orquestación dinámica de suspensión con el cuerpo normalizado por la acción. El comportamiento de esa orquestación se describe en la @sec-orquestacion-suspender-cirugia.

  == Estados implementados <sec-estados-implementados>

  La aplicación define un estado por cada etapa operativa del flujo quirúrgico. Cada estado declara sus acciones disponibles mediante `setActions`. Además, `EstadoBase` agrega automáticamente la acción `Ver ficha` a todos los estados, de modo que esta acción siempre está disponible mientras exista un `PatientService` asociado.

  Los estados implementados y las acciones que declaran son los siguientes:

  + Solicitada: Aceptar orden.
  + Programada: Reagendar cirugía, Suspender cirugía.
  + En espera: Recepcionar paciente, Imprimir brazalete, Suspender cirugía.
  + Preoperatorio: Ingresar a Pabellón, Evaluación preanestésica, Cambiar ubicación, Imprimir brazalete, Suspender cirugía.
  + En pabellón: Continuar cirugía (Iniciar anestesia), Protocolo quirúrgico, Pausa quirúrgica, Cuidados intraoperatorios, Cambiar ubicación, Revertir ingreso a Pabellón, Ver PDF protocolo, Imprimir brazalete, Suspender cirugía.
  + Anestesia iniciada: Continuar cirugía (Iniciar cirugía), Protocolo quirúrgico, Pausa quirúrgica, Cuidados intraoperatorios, Cambiar ubicación, Ver PDF protocolo, Imprimir brazalete, Suspender cirugía.
  + Cirugía iniciada: Continuar cirugía (Finalizar cirugía), Protocolo quirúrgico, Pausa quirúrgica, Cuidados intraoperatorios, Cambiar ubicación, Ver PDF protocolo, Imprimir brazalete.
  + Cirugía finalizada: Continuar cirugía (Finalizar anestesia), Protocolo quirúrgico, Pausa quirúrgica, Cuidados intraoperatorios, Cambiar ubicación, Ver PDF protocolo, Imprimir brazalete.
  + Anestesia finalizada: Iniciar recuperación, Protocolo quirúrgico, Pausa quirúrgica, Cuidados intraoperatorios, Cambiar ubicación, Ver PDF protocolo, Imprimir brazalete.
  + En recuperación: Finalizar recuperación, Protocolo quirúrgico, Pausa quirúrgica, Cambiar ubicación, Ver PDF protocolo, Imprimir brazalete.
  + Esperando traslado: Iniciar traslado, Devolver a unidad de origen, Protocolo quirúrgico, Pausa quirúrgica, Cambiar ubicación, Ver PDF protocolo, Imprimir brazalete.
  + Esperando alta: Protocolo quirúrgico, Pausa quirúrgica, Cambiar ubicación, Ver PDF protocolo, Imprimir brazalete.
  + Esperando egreso: Protocolo quirúrgico, Pausa quirúrgica, Cambiar ubicación, Ver PDF protocolo, Imprimir brazalete, Egresar paciente.
  + En tránsito: Protocolo quirúrgico, Ver PDF protocolo, Pausa quirúrgica.
  + Finalizada: Protocolo quirúrgico, Ver PDF protocolo.
  + Suspendida: sin acciones declaradas.

  Los estados _En recuperación_, _Esperando traslado_ y _Esperando egreso_ muestran un mensaje de alerta justo debajo del estado cuando la atención aún no tiene registrado el protocolo quirúrgico, como se observa en la @fig-estado-alerta-protocolo-pendiente. Esto permite alertar al equipo de pabellón que falta un documento clínico relevante, incluso cuando el caso ya avanzó a etapas finales del flujo.

  #figure(
    image("./imagenes/ejemplo-estado-con-alerta-de-protocolo-pendiente.png", width: 18%),
    caption: [Estado En recuperación mostrando la alerta de protocolo quirúrgico pendiente.],
  ) <fig-estado-alerta-protocolo-pendiente>

  La mayoría de los estados se instancian a partir del `stateKey` almacenado en los datos extendidos de la atención, usando `RegistroEstados`. Sin embargo, algunos estados se resuelven por condiciones externas:

  - Las indicaciones quirúrgicas siempre se muestran como Solicitada, porque aún no existe una programación ni una atención clínica asociada.
  - Las citas de urgencia se cargan como En espera, ya que representan una solicitud que debe ser recepcionada.
  - Las citas electivas sin `stateKey` se cargan como Programada; si tienen `stateKey`, se usa ese valor.
  - Para las atenciones `PatientService`, el estado se decide en primer lugar por la condición clínica: si la atención está finalizada o cancelada en HLTH, se resuelve como Finalizada o Suspendida, respectivamente. Si la atención tiene una evaluación de alta quirúrgica y su `stateKey` indica Esperando alta, el estado se resuelve como Esperando egreso. Esto refleja que, una vez registrado el alta, la etapa operativa pasa de 'esperando alta' a 'esperando egreso', aunque el `stateKey` persistido aún no haya sido actualizado. En los demás casos se usa el `stateKey` guardado.

  == Acciones implementadas fuera de la lista de trabajo

  La admisión de pacientes es parte del proceso quirúrgico, pero la realiza el personal de admisión y no el equipo que opera la aplicación de atención quirúrgica. Ese proceso conserva su aplicación legacy de admisión de pacientes, que no comparte el modelo de `Accion` ni de `Estado` de la nueva lista de trabajo. Como la programación de pabellón ahora se representa como citas de Agenda, fue necesario adaptar esa aplicación para que el flujo completo —admisión, recepción e intervención— pudiera seguir funcionando de forma coordinada.

  La adaptación se limitó a extender la lista legacy para mostrar citas quirúrgicas electivas junto con las admisiones, instancias y traslados que ya manejaba. La @fig-admision-paciente-lista muestra una cita de Agenda que representa una atención quirúrgica programada y que puede recepcionarse desde esa aplicación. Al seleccionarla, se abre el formulario de admisión con los datos de la cita y del paciente; al confirmar, se ejecuta la admisión y la cita queda lista para continuar con la recepción en pabellón dentro del flujo quirúrgico.

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

  Este fue un compromiso técnico: se sacrificó granularidad de ejecución en Temporal, pero se mantuvo la ventaja principal requerida por el proyecto, que era coordinar actividades entre microservicios sin depender del motor de procesos deprecado y sin desarrollar un workflow específico para cada acción.

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

  Por ello, se incorporó un límite configurable de reintentos y se dejó configurado con un valor bajo. Además, las orquestaciones fueron definidas buscando reducir riesgos: validando entradas con JSON Schema, consultando estado antes de operar, usando condiciones `when` y evitando reintentos automáticos agresivos sobre operaciones que pudieran no ser idempotentes.   Esta solución no elimina por completo el problema, pero fue la alternativa más razonable considerando las restricciones de tiempo y la necesidad de contar con un mecanismo de orquestación que permitiera prescindir del motor de procesos deprecado.

  === Resultado del orquestador dinámico

  Con esta implementación, la plataforma incorporó una capacidad reusable para coordinar acciones compuestas entre microservicios. Las reglas específicas de cada transición quedan expresadas como definiciones configurables, mientras que el workflow común entrega el mecanismo de ejecución, validación y secuenciamiento. Esto permite incorporar nuevas acciones del flujo quirúrgico con menos código específico, aprovechar endpoints existentes y mantener la coordinación fuera del frontend, en una capa más adecuada para ejecutar procesos asincrónicos y trazables.

  == Orquestaciones dinámicas del flujo quirúrgico <sec-orquestaciones-dinamicas-flujo-qx>

  Sobre el orquestador dinámico se configuraron acciones concretas del flujo quirúrgico. Estas orquestaciones no forman un único proceso monolítico; cada una resuelve una transición o automatización acotada, reutilizando servicios de Agenda, HLTH, BPM, AUTH y HEGC, junto con formularios clínicos provistos por la aplicación EHR cuando corresponde. En conjunto permiten que la lista de trabajo ejecute acciones complejas sin concentrar en el frontend la coordinación entre componentes de la plataforma.

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

  === Traslados y retorno a unidad de origen <sec-orquestacion-traslados>

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

  - Creación de atención quirúrgica: observa eventos del tópico `api.hlth.patient-service`. Cuando se crea una atención de tipo quirúrgico, inicia la orquestación que crea la tarea BPM de completar protocolo quirúrgico, usando el identificador de la atención como parámetro.
  - Guardado de protocolo quirúrgico para completar tarea BPM: observa eventos del tópico `api.hlth.evaluation`. Cuando se crea una evaluación asociada a una atención quirúrgica y el tipo de evaluación corresponde al protocolo quirúrgico, inicia la orquestación que busca y completa la tarea BPM de completar protocolo quirúrgico, usando la atención y el clínico informados por el evento.
  - Guardado de protocolo quirúrgico para operar en Gestión Hospitales: observa el mismo evento de creación de protocolo quirúrgico en `api.hlth.evaluation`. Cuando se cumplen las condiciones de atención quirúrgica y tipo de evaluación, inicia la orquestación que evalúa si corresponde marcar la orden como operada en Gestión Hospitales.
  - Finalización de traslado: observa eventos del tópico `api.hlth.transfer`. Cuando se finaliza una transferencia en estado final asociado a una atención quirúrgica, inicia la orquestación que finaliza la atención quirúrgica correspondiente.
  - Finalización de atención quirúrgica: observa eventos del tópico `api.hlth.patient-service`. Cuando se finaliza una atención de tipo quirúrgico, inicia la orquestación que evalúa si corresponde operar la orden asociada en Gestión Hospitales.

  La lógica de reacción queda así expresada como configuración de BPM y no como llamadas directas desde la lista de trabajo.

  === Mejoras al servicio de SSE

  Para la actualización de interfaces se ajustó el servicio de SSE, que consume eventos desde Kafka y los entrega a clientes frontend conectados. Una mejora relevante fue permitir filtros con más de un valor para un mismo parámetro. Antes, un filtro representaba una coincidencia puntual; con el cambio, el cliente puede enviar una lista y recibir eventos que coincidan con cualquiera de esos valores.

  El comportamiento implementado combina los filtros de esta forma: existe un OR dentro de los valores de un mismo filtro y un AND entre filtros distintos. Por ejemplo, una suscripción al tópico de indicaciones con `typeId=21,22&type=created` recibe eventos cuyo tipo de indicación sea 21 o 22, pero siempre que el evento sea de creación. De forma equivalente, una suscripción a citas con `typeId=3,4&type=updated,created` recibe citas cuyo tipo sea 3 o 4 y cuyo evento sea actualización o creación.

  Internamente, los filtros se transforman en grupos de hashes. Cada grupo representa los valores aceptados para un filtro y se cumple si alguno de sus elementos coincide con los hashes del evento. Luego, todos los grupos deben cumplirse para que el mensaje sea enviado al cliente. Este diseño permite expresar filtros más flexibles sin crear endpoints especiales para cada combinación de valores.

  También se refactorizó la lógica del servicio para separar responsabilidades. Se incorporó un modelo de cliente conectado, con sus filtros, suscripciones y respuesta SSE asociada. Además, se centralizó el registro de clientes en buckets por tópico y por clave de filtro, de modo que al llegar un evento no sea necesario recorrer todos los clientes conectados. La limpieza de suscripciones al cerrar una conexión también quedó centralizada, reduciendo el riesgo de mantener referencias a clientes desconectados.

  === Suscripciones frontend con SSE

  En el frontend, la lista de trabajo quirúrgica se conecta al servicio de SSE mediante `EventSource`. Las suscripciones se registran asociadas a la ruta de atención quirúrgica, por lo que solo están activas cuando la vista correspondiente está en uso. Cada suscripción indica un tópico Kafka y filtros de interés; cuando llega un evento que cumple esos filtros, la lista puede recargar o actualizar la información mostrada.

  Las suscripciones configuradas para la lista de trabajo fueron:

  - Atenciones quirúrgicas: escucha el tópico `api.hlth.patient-service` filtrando por tipos de atención quirúrgica y tipos de evento relevantes. Es especialmente importante escuchar actualizaciones, porque gran parte de la información operacional del proceso vive en los datos de la atención quirúrgica. Por ejemplo, avanzar de etapa dentro del quirófano técnicamente corresponde a actualizar la información de esa atención. Esta suscripción permite actualizar la grilla cuando una atención quirúrgica se crea, cambia de estado, actualiza sus hitos o finaliza.
  - Indicaciones quirúrgicas: escucha el tópico `api.hlth.indication` filtrando por tipos de indicación quirúrgica y eventos relevantes. Permite reflejar cambios en órdenes de urgencia, por ejemplo cuando una indicación es creada, iniciada, cancelada o finalizada.
  - Citas de Agenda: escucha el tópico `api.agenda.appointment` filtrando por tipos de cita quirúrgica y eventos relevantes. Permite actualizar programaciones electivas o de urgencia cuando una cita se crea, inicia, modifica, cancela o reagenda.
  - Evaluaciones clínicas: escucha el tópico `api.hlth.evaluation` filtrando por tipo de atención quirúrgica, tipos de evaluación relevantes y tipo de evento. Permite actualizar la lista cuando se registran evaluaciones asociadas al flujo, como el protocolo quirúrgico u otros documentos clínicos.

  Durante la implementación se ajustaron los filtros para permitir listas de valores y reducir eventos irrelevantes. También se incorporó un debounce configurable para evitar que múltiples eventos cercanos generen recargas excesivas de la grilla. Esto fue necesario porque una acción orquestada puede modificar más de una entidad y producir varios eventos en poco tiempo. Además, la lista de trabajo puede ser utilizada por múltiples personas de forma independiente, por lo que en operación normal pueden ocurrir muchos cambios con pocos segundos de diferencia. Por esta razón, se buscó usar los filtros del servicio de SSE de la forma más específica posible, escuchando solo los eventos necesarios para la vista, y agrupar recargas cercanas mediante debounce.

]

#capitulo(title: "Evaluación y validación")[
  La evaluación del trabajo se abordó considerando la naturaleza de la solución desarrollada. La mayor parte del esfuerzo estuvo concentrada en construir una nueva aplicación frontend para operar el proceso quirúrgico y en coordinar acciones que involucran distintos microservicios de la plataforma. Por ello, la validación debía comprobar principalmente dos aspectos: que la información mostrada al usuario fuera correcta y completa, y que las acciones ejecutaran los cambios esperados sobre el flujo quirúrgico.

  Los cambios realizados directamente en servicios backend fueron acotados y precisos. La excepción principal fue el orquestador dinámico, que introduce una forma configurable de coordinar actividades entre servicios. Sin embargo, la plataforma no cuenta con una arquitectura de pruebas automatizadas específica para validar orquestaciones completas de este tipo. Construir un conjunto de pruebas automatizadas para todos los casos habría requerido simular múltiples servicios, eventos, respuestas intermedias y estados del proceso, lo que habría consumido una parte importante del tiempo disponible. Por esta razón, se optó por una validación manual y formativa basada en recorridos cognitivos, inspecciones de usabilidad y pruebas funcionales sobre flujos completos.

  == Estrategia de evaluación

  La guía de evaluación de usabilidad usada como referencia distingue métodos rápidos y rigurosos, y describe técnicas como el recorrido cognitivo y la inspección de usabilidad para evaluar sistemas durante el proceso de desarrollo @BaloianPino2024Usabilidad. En este proyecto, esas técnicas resultaron adecuadas porque la solución se encontraba en construcción, debía reemplazar una versión anterior en un plazo acotado y requería validación constante de flujos operacionales.

  El recorrido cognitivo fue aplicado inicialmente por el memorista sobre las funcionalidades desarrolladas. Para cada flujo se verificó si el usuario podría identificar la acción correcta, comprender su efecto, ejecutarla y observar una retroalimentación coherente con el resultado esperado. Esta revisión se aplicó tanto sobre el frontend como sobre las acciones orquestadas, ya que muchas interacciones de la interfaz terminan ejecutando operaciones distribuidas sobre Agenda, HLTH, BPM o HEGC, o abriendo formularios clínicos provistos por la aplicación EHR.

  Una vez estabilizada una funcionalidad, el líder del proyecto revisaba la versión implementada y realizaba una inspección de usabilidad. Esta revisión permitía validar si el comportamiento era equivalente al flujo esperado, si la información visible era suficiente y si existían oportunidades de mejora en nombres, orden, disponibilidad de acciones o estructura visual. De esta manera, la evaluación no se realizó como una actividad única al final del desarrollo, sino como un proceso iterativo de mejora continua.

  En la evaluación inicial del frontend también se procuró seguir el `design system` de Lahuén, es decir, los patrones visuales y pautas de comportamiento ya utilizados en otras aplicaciones de la plataforma. Esto permitió mantener continuidad con interfaces previamente conocidas por los usuarios y reducir el costo de adaptación al nuevo módulo.

  == Validación funcional

  La validación funcional consistió en ejecutar manualmente los flujos principales de la aplicación de proceso quirúrgico y verificar el resultado visible en la lista de trabajo, los cambios de estado, la información registrada en la atención y la reacción de los monitores. Las pruebas se enfocaron en los siguientes elementos:

  - Información mostrada: se revisó que la grilla presentara correctamente documento, nombre, edad, especialidad, intervención, programación, ubicación, estado y acciones disponibles para cada caso.
  - Acciones del flujo: se probaron acciones como aceptar orden, recepcionar paciente, ingresar a pabellón, avanzar hitos intraoperatorios, iniciar y finalizar recuperación, iniciar traslado, devolver a unidad de origen, egresar paciente, suspender cirugía y cargar documentos clínicos.
  - Orquestaciones: se verificó que las acciones implementadas mediante orquestaciones ejecutaran las transiciones esperadas y actualizaran las entidades correspondientes.
  - Integración con Gestión Hospitales: se validó que el script de importación transformara las órdenes quirúrgicas electivas para crear citas compatibles con Agenda y con la nueva lista de trabajo.
  - Monitores: se revisó que el Monitor de pabellones y el Monitor de pacientes mostraran información coherente con los cambios realizados en el flujo.

  Estas pruebas permitieron detectar diferencias respecto del comportamiento anterior y corregirlas durante el desarrollo. En una primera etapa, el objetivo fue igualar el funcionamiento de la versión previa para evitar que los usuarios percibieran una pérdida de capacidades. Luego se incorporaron mejoras acotadas, como nuevas acciones, ajustes visuales, mayor claridad en estados y mejor presentación de información relevante.

  == Evaluación de usabilidad

  La evaluación de usabilidad combinó inspección experta, recorridos cognitivos y una encuesta SUS. El cuestionario SUS, propuesto por Brooke, es un instrumento breve de diez preguntas en escala Likert que permite obtener una aproximación rápida a la usabilidad percibida de un sistema @Brooke1996SUS. La guía de usabilidad utilizada como referencia recomienda interpretar este instrumento con cautela, especialmente cuando se aplica una traducción ad-hoc y cuando el resultado se encuentra cerca del valor de referencia habitual de 68 puntos @BaloianPino2024Usabilidad.

  La encuesta fue respondida por 10 personas que utilizan el software, incluyendo perfiles de enfermería, técnicos y anestesistas. El instrumento completo, con las diez preguntas en escala Likert de 1 a 5, se presenta en el @anexo-instrumentos-evaluacion.

  #figure(
    table(
      columns: 2,
      [_Métrica_], [_Resultado_],
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

  En este contexto, la primera versión tuvo como propósito reemplazar la versión anterior en el ambiente de producción, conservando las funcionalidades necesarias para evitar que los usuarios sintieran una pérdida en su flujo de trabajo. Al mismo tiempo, se incorporaron mejoras puntuales de alto impacto para facilitar la adaptación a la nueva versión. La comunicación posterior con usuarios permitió seguir corrigiendo problemas, ajustar comportamientos y avanzar hacia una versión más madura del módulo.

  == Limitaciones de la evaluación

  La evaluación realizada permitió validar funcionalmente el flujo y obtener una primera aproximación a la usabilidad percibida, pero presenta limitaciones. No se implementó una batería automatizada de pruebas para las orquestaciones dinámicas, por las restricciones técnicas y de tiempo ya señaladas. Además, la encuesta SUS entrega una señal útil, pero su interpretación debe ser cuidadosa por el tamaño de muestra, la dispersión de respuestas y el uso de una traducción no estandarizada.

  Por lo anterior, la validación debe entenderse como evidencia inicial de funcionamiento y aceptabilidad, no como una medición definitiva del impacto clínico u operacional del sistema. La madurez de la solución dependerá de nuevas iteraciones, uso sostenido en producción y futuras evaluaciones con usuarios finales.
]

#capitulo(title: "Resultados")[
  El resultado principal del trabajo fue la puesta en producción, en el Hospital Exequiel González Cortés, de una nueva versión del módulo de atención quirúrgica de la Plataforma Lahuén, reemplazando completamente la versión anterior de pabellón.   El desarrollo finalizó el 8 de abril y desde ese día la nueva versión comenzó a utilizarse en la operación real del hospital. Con esto, el flujo quirúrgico dejó de depender del motor de procesos deprecado y pasó a ejecutarse sobre la arquitectura actual de la plataforma.

  == Producto implementado

  La solución entregada quedó compuesta por tres aplicaciones frontend y un conjunto de integraciones backend. La primera corresponde a la aplicación de proceso quirúrgico, organizada como lista de trabajo operativa para pabellón. Esta aplicación permite visualizar pacientes, programaciones, estados, ubicaciones y acciones disponibles para cada etapa del flujo. La segunda corresponde al Monitor de pabellones, orientado a la coordinación interna del uso de quirófanos. La tercera corresponde al Monitor de pacientes, orientado a informar a familiares o acompañantes sobre el estado general del proceso.

  En el backend, el resultado incluyó la integración de cirugías electivas provenientes de Gestión Hospitales, la creación de citas quirúrgicas en Agenda, la coordinación de acciones mediante BPM y Temporal, y la definición de orquestaciones dinámicas para ejecutar transiciones del proceso. También se incorporaron suscripciones SSE para actualizar la información visible ante cambios relevantes de atenciones, citas, indicaciones y evaluaciones.

  Esta combinación permitió reconstruir el flujo funcional existente con una base técnica más mantenible.   La información principal del caso quirúrgico ya no depende de una instancia del motor de procesos deprecado, sino de entidades de dominio como indicaciones, citas y atenciones clínicas. Esto simplifica el soporte, facilita la observación de los datos y reduce el costo de futuras modificaciones.

  == Cobertura funcional alcanzada

  La nueva versión cubre los casos operacionales principales que abordaba la versión anterior y agrega mejoras acotadas sobre el flujo. Se implementó soporte para cirugías de urgencia y cirugías electivas, incluyendo la transformación de órdenes provenientes de Gestión Hospitales hacia citas quirúrgicas operables desde la lista de trabajo.

  La aplicación permite ejecutar las acciones necesarias para avanzar el proceso quirúrgico: aceptar órdenes de urgencia, recepcionar pacientes, ingresar a pabellón, registrar hitos intraoperatorios, iniciar recuperación, finalizar recuperación, iniciar traslados, devolver a unidad de origen, egresar pacientes, suspender cirugías, consultar ficha, cargar documentos clínicos, generar PDF del protocolo e imprimir brazaletes. Además, se incorporó la reversa de ingreso a pabellón, una mejora que permite corregir un caso operacional que podía ocurrir en la práctica y que antes no estaba abordado de forma explícita.

  En términos de documentación clínica, la solución permite cargar evaluación preanestésica, protocolo quirúrgico, pausas quirúrgicas y cuidados intraoperatorios, manteniendo la relación con la atención del paciente.

  La trazabilidad del proceso se mantuvo y se mejoró en algunos aspectos. La mayoría de las acciones relevantes conservan responsable, fecha y cambios de estado, y los hitos del pabellón quedan registrados dentro de la atención quirúrgica.   Aunque existe margen para fortalecer la auditoría y homogeneizar responsables en todos los casos, la nueva representación del estado permite reconstruir el recorrido del paciente de manera más clara que en la versión basada en instancias del motor de procesos deprecado.

  == Puesta en producción

  El paso a producción fue una etapa compleja debido a la cantidad de cambios involucrados. Para reducir el riesgo, durante el desarrollo se documentaron los ajustes necesarios para el despliegue, las configuraciones requeridas, las definiciones de orquestación y las integraciones con los servicios de la plataforma. Esta preparación permitió realizar el reemplazo completo de la versión anterior.

  Al momento de la salida a producción se realizaron pruebas controladas con un paciente de prueba. Durante el primer día se ejecutaron alrededor de diez atenciones quirúrgicas usando la nueva versión. Como parte del funcionamiento habitual de Lahuén, la empresa entregó soporte durante la jornada, de modo que los errores reportados por los usuarios pudieran ser revisados y corregidos rápidamente.

  Durante esta etapa se identificaron problemas que no habían aparecido en las pruebas de desarrollo. Algunos fueron leves y otros afectaban partes relevantes del flujo, pero fueron abordados mediante soporte constante y correcciones posteriores. Esto permitió estabilizar la operación inicial sin volver a la versión anterior.

  La aplicación comenzó a operar en el flujo real de pabellón, permitió atender pacientes y se mantuvo en uso mientras se realizaban los ajustes necesarios para estabilizar la primera versión.

  == Resultado técnico

  Desde el punto de vista técnico, el trabajo logró eliminar la dependencia operacional del motor de procesos deprecado. Las acciones del proceso ya no requieren mantener la lógica principal dentro de instancias de ese motor, sino que se apoyan en servicios de dominio, datos extendidos, eventos y orquestaciones acotadas.

  El orquestador dinámico fue un resultado relevante del trabajo. Permitió crear y modificar acciones complejas con mayor velocidad que si cada transición hubiese requerido un workflow específico. Durante el desarrollo y la salida a producción, algunos ajustes pudieron resolverse modificando definiciones de orquestación, sin realizar cambios grandes en el frontend ni en servicios de dominio.

  == Resultado de usabilidad

  La evaluación SUS obtuvo un promedio de 65,5 puntos con 10 participantes. Este resultado se encuentra cercano al valor de referencia habitual de 68 puntos, por lo que se interpreta como una señal de usabilidad aceptable, aunque mejorable. La dispersión de respuestas indica que algunos usuarios percibieron positivamente la herramienta, mientras que otros encontraron dificultades asociadas a complejidad, tedio o adaptación al nuevo flujo.

  Este resultado es coherente con el contexto de reemplazo de una aplicación utilizada previamente. La nueva versión conserva el flujo conocido, pero también modifica parte de la experiencia de uso y de la forma en que se presentan las acciones. Por ello, la evaluación no debe leerse como un cierre definitivo de usabilidad, sino como una primera medición de percepción en una etapa de transición y estabilización.

  En conjunto, los resultados muestran que se logró construir una versión operable, desplegada en producción y funcionalmente equivalente o superior a la versión anterior en los casos principales.
]

#capitulo(title: "Conclusiones")[
  Este trabajo permitió modernizar el módulo de atención quirúrgica de Lahuén, reemplazando una implementación funcionalmente valiosa pero técnicamente difícil de mantener por una solución integrada a la arquitectura actual de la plataforma. El resultado no fue un rediseño completo del proceso quirúrgico, sino una reconstrucción tecnológica del flujo existente, preservando su lógica operacional y habilitando nuevas capacidades de evolución.

  == Cumplimiento de objetivos

  El objetivo central se cumplió: se modernizó el módulo de atención quirúrgica de la Plataforma Lahuén, reconstruyendo su flujo operativo sobre la arquitectura actual de la empresa y dejando una nueva versión desplegada y operativa en el Hospital Exequiel González Cortés.   Con ello, el flujo dejó de depender de la implementación previa basada en el motor de procesos deprecado y pasó a representarse mediante componentes más alineados con la arquitectura actual de Lahuén.

  También se cumplió el objetivo de modernizar la aplicación frontend. La aplicación de proceso quirúrgico se implementó como una lista de trabajo con estados, acciones y adaptadores explícitos, siguiendo el `design system` actual de Lahuén; además, se reconstruyeron el Monitor de pabellones y el Monitor de pacientes.

  En términos funcionales, la solución aborda los flujos de urgencia y electivo, integra Gestión Hospitales con Agenda, permite operar las principales etapas del proceso quirúrgico e incorpora documentos clínicos relevantes. También agrega mejoras que no estaban cubiertas explícitamente en la versión anterior.

  == Complejidad del proceso quirúrgico

  Una de las principales conclusiones del trabajo es que el proceso quirúrgico es más complejo que una secuencia lineal de estados. El caso puede originarse en una orden de urgencia o en una cirugía electiva programada, pero durante el recorrido pueden aparecer evaluaciones, como el alta quirúrgica, hospitalizaciones previas o posteriores, solicitudes de traslado, suspensiones u otras acciones realizadas fuera de la aplicación de proceso quirúrgico que modifican el flujo esperado.

  Por esta razón, el flujo implementado debe entenderse como una versión operacionalmente útil y simplificada de un dominio más amplio. El objetivo de esta primera versión fue reemplazar la solución anterior y cubrir la mayor parte de los casos necesarios para operar, no resolver de una sola vez todos los escenarios posibles. Incluso con un esfuerzo importante por perfeccionar el flujo durante el desarrollo, no es realista conocer de antemano todas las variaciones que pueden aparecer en un pabellón. La experiencia en producción confirmó que algunos comportamientos solo aparecen cuando el sistema se enfrenta al uso real y a las variaciones propias del trabajo clínico.

  El caso del estado `Esperando egreso` ilustra esta dificultad. Durante la implementación se modeló una condición que parecía razonable: si el paciente tenía alta quirúrgica, podía entenderse que estaba listo para egresar. Sin embargo, en la práctica el alta puede registrarse antes de que finalice la recuperación, porque el cirujano no necesariamente permanece durante toda esa etapa. Por lo tanto, el sistema debía adaptarse al modelo real de atención del hospital y hacer que esa decisión tuviera efecto solo cuando el paciente estuviera en una etapa compatible con el egreso. El problema no se debió a una falla estructural de la arquitectura, sino a la dificultad de capturar todos los matices del flujo quirúrgico antes de observarlo en operación real.

  Algo similar ocurre con los traslados. La versión implementada permite operar los casos principales, pero existen escenarios más complejos en que el traslado puede cambiar después de finalizar recuperación, puede agregarse una nueva solicitud o puede aparecer una hospitalización definida desde otra aplicación. Estos casos requieren seguir refinando el modelo para adaptarlo mejor a la realidad de cada hospital. Esto es coherente con la orientación de Lahuén de adaptar la tecnología al modelo de atención y a los procesos asistenciales de cada establecimiento @LahuenHealthAbout.

  == Aciertos y decisiones técnicas

  Un acierto relevante fue separar el conocimiento funcional del proceso quirúrgico de la implementación previa basada en el motor de procesos deprecado. La versión anterior contenía una lógica operacional valiosa, pero su forma técnica dificultaba observar, corregir y extender el flujo. Al trasladar el estado a entidades de dominio y coordinar acciones mediante servicios y orquestaciones, el sistema queda mejor preparado para evolucionar.

  Otro acierto fue el uso de orquestaciones dinámicas. Aunque el mecanismo tiene limitaciones, permitió acelerar el desarrollo de acciones compuestas y reducir la necesidad de crear workflows específicos para cada transición.

  La modernización del frontend también fue un resultado positivo. La nueva aplicación ofrece una estructura más clara de estados y acciones, incorpora actualización en tiempo real y utiliza patrones actuales de la plataforma. Esto no solo mejora la experiencia del usuario frente a la versión anterior, sino que facilita el mantenimiento por parte del equipo de desarrollo.

  == Limitaciones y aprendizajes

  La principal limitación técnica del orquestador dinámico fue su naturaleza asíncrona. En varios casos esto es aceptable, porque las actualizaciones llegan mediante eventos y la interfaz puede refrescarse posteriormente. Sin embargo, para ciertas acciones habría sido deseable que el frontend pudiera esperar el término efectivo de la orquestación. Implementar orquestaciones dinámicas sincrónicas habría requerido una capacidad adicional que la plataforma no tenía disponible y que podía aumentar significativamente el costo del proyecto.

  También habría sido útil incorporar mecanismos de idempotencia o bloqueo para evitar ejecuciones duplicadas de una misma acción. En un entorno donde múltiples usuarios pueden operar sobre el mismo paciente, la coordinación concurrente es un aspecto importante. Esta mejora no fue priorizada para la primera versión, pero aparece como una línea clara de evolución.

  == Reflexión final

  La solución desarrollada no representa la versión definitiva del módulo quirúrgico, pero sí una base más sólida sobre la cual continuar evolucionando. El trabajo permitió pasar desde una implementación difícil de mantener hacia una versión desplegada en producción, operable y preparada para mejoras posteriores.

  En el contexto de una empresa SaaS como Lahuén, este resultado es especialmente relevante. El producto debe adaptarse progresivamente a la forma en que cada establecimiento organiza su atención, y esa adaptación requiere pruebas constantes, validación con usuarios y una arquitectura que permita corregir, extender y refinar el flujo sin rehacer el sistema completo. En retrospectiva, varias decisiones podrían haberse diseñado de mejor manera, pero la solución alcanzada fue suficiente para poner en producción un producto funcional y capaz de seguir mejorando. Este trabajo avanza en esa dirección: entrega una primera versión desplegada en producción, usable y mejorable, sobre la cual se pueden construir futuras iteraciones para cubrir más casos del proceso quirúrgico y apoyar de mejor manera la gestión de pabellones.
]

#capitulo(title: "Trabajo futuro")[
  La versión desarrollada cumple el objetivo de reemplazar la versión anterior y entregar una base operable en producción para el módulo quirúrgico. Sin embargo, la experiencia de desarrollo y puesta en producción mostró líneas de mejora importantes. Algunas corresponden a ajustes propios del proceso quirúrgico, mientras que otras afectan componentes transversales de la plataforma, como la coordinación entre microservicios, el orquestador dinámico, el rendimiento de las listas de trabajo y los mecanismos de trazabilidad.

  == Flexibilización del flujo quirúrgico

  Una primera línea de trabajo futuro es flexibilizar el flujo quirúrgico frente a cambios externos que hoy no se reflejan de forma suficiente en la atención quirúrgica. El caso más evidente ocurre después de finalizar la recuperación. En la versión actual, el flujo queda limitado por las alternativas previstas durante el desarrollo, pero en la operación real pueden aparecer cambios posteriores. Por ejemplo, un paciente electivo puede requerir un traslado a urgencia o una hospitalización no prevista inicialmente; de forma similar, un traslado solicitado puede cancelarse o modificarse.

  Estos escenarios requieren que la aplicación de proceso quirúrgico no dependa solo de las acciones ejecutadas desde la lista de trabajo. A futuro, el backend debería reaccionar ante eventos o cambios de estado generados en otros módulos, especialmente aquellos relacionados con solicitudes de traslado, hospitalización y atenciones activas. De esta forma, si cambia la situación del paciente, la atención quirúrgica podría actualizar su estado e información asociada para reflejar que el paciente debe ser hospitalizado, que debe aceptarse un traslado, o que un traslado previamente solicitado dejó de estar vigente.

  Una dificultad similar aparece al inicio del proceso. En cirugías electivas, es frecuente que el paciente sea hospitalizado antes de la intervención. En casos de urgencia, puede ocurrir que una indicación quirúrgica se genere desde una atención de urgencia y que luego el paciente sea hospitalizado, pasando a tener una nueva atención activa. Aunque estos casos no impiden necesariamente completar el flujo quirúrgico, generan molestias para los usuarios porque la información visible no siempre corresponde a la atención vigente. Por ello, una mejora relevante es que el flujo pueda reconocer estos cambios tempranos y actualizar la información de la atención quirúrgica para mostrar siempre la ficha y la atención activa del paciente.

  == Múltiples intervenciones en una misma atención

  Otro caso que requiere un mejor modelamiento es el de pacientes con más de una intervención quirúrgica en un mismo día. Actualmente es posible operar este escenario programando más de una cita y generando atenciones separadas, pero la solución puede requerir apoyo del área de soporte y no representa necesariamente el modelo ideal. En la práctica, un paciente puede tener dos o más intervenciones en una misma jornada, y este caso es más frecuente de lo que podría suponerse inicialmente.

  A futuro, el sistema debería permitir representar múltiples intervenciones dentro de una misma atención quirúrgica cuando corresponda. Esto implicaría revisar el modelo de datos, la relación entre cita, intervención, documentos clínicos, hitos y tiempos quirúrgicos. También exigiría definir cómo se registran formularios, pausas, recuperación y protocolos cuando existen varias intervenciones asociadas al mismo episodio de atención. Es un problema difícil, porque no solo afecta la interfaz, sino también la forma en que la plataforma entiende la unidad clínica y operacional del caso quirúrgico.

  == Sincronización de datos entre servicios

  La sincronización de datos entre Agenda, HLTH y XRM constituye otra línea de trabajo futuro relevante. Estos servicios manejan información de pacientes y atenciones desde perspectivas distintas, y no siempre tienen los mismos datos disponibles o actualizados. Como consecuencia, acciones como la recepción de un paciente en pabellón pueden fallar si falta información requerida en alguna de las bases de datos involucradas.

  Este problema no es exclusivo del módulo quirúrgico, sino una consecuencia general del modelo de microservicios de la empresa. Resolverlo requiere mecanismos de sincronización que mantengan actualizada la información compartida entre servicios, reaccionando ante cambios relevantes y actualizando las entidades relacionadas cuando corresponda. Una posible línea de evolución es implementar un componente o conjunto de procesos encargados de sincronizar, completar o igualar datos críticos de pacientes y atenciones entre Agenda, HLTH y XRM, reduciendo fallas derivadas de información desactualizada o incompleta y mejorando la continuidad operacional de las aplicaciones que dependen de esos datos.

  == Evolución del módulo completo de pabellón

  El trabajo desarrollado puede entenderse como un primer paso en la modernización del conjunto de funcionalidades asociadas a pabellón. La nueva aplicación de proceso quirúrgico reemplaza la operación del paciente dentro del flujo de pabellón, pero existen componentes relacionados que aún deben evolucionar. En particular, una mejora mayor sería reconstruir la lista de espera y programación quirúrgica que actualmente opera en Gestión Hospitales.

  Esta evolución permitiría integrar de mejor manera la programación de intervenciones con el proceso quirúrgico implementado en este trabajo. Sin embargo, se trata de un esfuerzo de magnitud comparable al realizado para la aplicación de proceso quirúrgico, porque involucra rediseñar una aplicación completa, preservar conocimiento operacional existente, integrar nuevos flujos con Agenda y asegurar continuidad de operación. Aun así, es un paso necesario para seguir modernizando el módulo completo de pabellón y reducir la dependencia de soluciones técnicas anteriores.

  == Mejoras del orquestador dinámico

  El orquestador dinámico permitió resolver acciones complejas sin crear un workflow específico para cada caso. No obstante, su versión actual tiene limitaciones que deben abordarse. La primera es su naturaleza asíncrona. Hoy, la aplicación no puede esperar directamente el término de una orquestación para aprovechar su respuesta en la interacción con el usuario. En varios casos esto se compensa mediante eventos y actualizaciones posteriores, pero sería preferible contar con una alternativa sincrónica o con un mecanismo que permita obtener una respuesta clara cuando la orquestación finaliza.

  También es necesario mejorar el manejo de fallas y reintentos. Actualmente, una orquestación dinámica puede fallar y no reintentarse automáticamente para evitar riesgos de duplicación de datos u otros efectos no deseados. Una posible mejora sería separar las actividades internas de cada orquestación en actividades individuales del workflow, de modo que si una actividad falla solo se reintente esa parte. Esta estrategia debe considerar las restricciones de Temporal, especialmente el tamaño de las respuestas y datos almacenados durante la ejecución.

  Aun con esa mejora, persisten desafíos importantes. Una orquestación podría quedar detenida en una actividad después de haber modificado parcialmente algunos datos, sin que exista un mecanismo general de compensación o rollback. Implementar ese tipo de comportamiento es complejo, porque el orquestador coordina llamadas a servicios independientes y no controla transacciones distribuidas entre ellos. Además, si se implementan orquestaciones sincrónicas, debe definirse cuidadosamente qué ocurre cuando una actividad falla: si la respuesta espera todos los reintentos, si devuelve un error inmediatamente, o si informa un estado intermedio que luego se completa de forma asíncrona. Estas decisiones son centrales para convertir el orquestador dinámico en un mecanismo más confiable y predecible para coordinar actividades entre microservicios.

  == Rendimiento y carga de información

  Otra mejora importante se relaciona con la cantidad de información que carga la lista de trabajo. En la versión actual, como el número diario de pacientes quirúrgicos es acotado, la aplicación muestra las atenciones del día en una sola lista. Sin embargo, cargar toda la información necesaria puede producir una carga significativa tanto para el servidor como para el frontend, especialmente por los datos provenientes de HLTH.

  El desafío es obtener suficiente información para calcular estados, acciones disponibles, evaluaciones realizadas y datos clínicos relevantes, sin realizar demasiadas llamadas al backend ni solicitar respuestas excesivamente grandes. El uso de datos embebidos permite que una entidad incluya información relacionada, como evaluaciones asociadas a una atención quirúrgica, pero también puede generar respuestas de gran tamaño si se incorporan más datos de los necesarios.

  A futuro se deberían evaluar mecanismos para reducir y filtrar mejor los datos cargados por la lista de trabajo. Esto puede incluir respuestas específicas para la vista de pabellón, proyecciones más acotadas de entidades, criterios de inclusión más finos para datos embebidos, o endpoints orientados a entregar exactamente la información requerida por la grilla. La dificultad principal es que la lista combina entidades de distintos microservicios y necesita suficiente contexto para operar correctamente, por lo que la optimización debe equilibrar número de llamadas, tamaño de respuesta y costo de procesamiento en frontend y backend.

  == Reversión de hitos y edición de tiempos

  En la operación diaria también aparecen necesidades de corrección manual. Durante el avance por las etapas de pabellón puede ocurrir que un usuario registre hitos en un orden equivocado, avance más de lo necesario o ingrese datos que no representan lo que realmente está ocurriendo. Por ello, sería útil incorporar mecanismos controlados para revertir ciertos hitos o etapas del proceso quirúrgico.

  Otra mejora relacionada es permitir modificar manualmente los tiempos registrados en los formularios que avanzan etapas. Actualmente estos formularios muestran información asociada al hito, pero no siempre permiten ajustar los tiempos antes de confirmar la acción. Considerando la importancia legal y operacional de los tiempos quirúrgicos, una futura versión debería permitir corregirlos de forma controlada, dejando trazabilidad clara de quién realizó el cambio, cuándo lo hizo y cuál fue el valor anterior.

  == Trazabilidad, responsables y seguridad de acciones

  Finalmente, una línea de mejora transversal es fortalecer la trazabilidad y seguridad de las acciones ejecutadas en pabellón. A futuro, todas las acciones relevantes deberían registrar de forma explícita el usuario responsable, el momento de ejecución y el contexto en que se realizó la acción. Esto permitiría auditar con mayor claridad el recorrido del paciente y las decisiones tomadas durante la atención quirúrgica.

  Además, la operación de pabellón suele realizarse en computadores compartidos por varios funcionarios. En ese contexto, no basta con autenticar al usuario al inicio de la sesión, porque durante la duración de esa sesión otra persona podría ejecutar acciones usando las credenciales ya abiertas. Una mejora posible es solicitar nuevamente la contraseña antes de ejecutar acciones sensibles, o implementar un mecanismo equivalente de reautenticación frecuente. El desafío es equilibrar seguridad, trazabilidad y usabilidad, evitando que el sistema se vuelva demasiado lento o incómodo para el trabajo clínico, pero asegurando que cada acción quede asociada al responsable real.
]

#show: end-doc

#apendice(title: "Arquitectura de la plataforma", label: <anexo-arquitectura-plataforma>)[
  El Capítulo 3 presentó la arquitectura frontend de Lahuén como una organización en tres niveles: la capa base compartida (`shared`), la clase `WebApp` y los plugins. Este anexo complementa esa descripción con detalles técnicos que la aplicación de proceso quirúrgico utiliza directamente.

  La base compartida `shared` agrupa componentes genéricos de interfaz —tablas, selectores, datepickers, typeaheads—, formateadores, utilidades JavaScript, proxies de API, estilos, imágenes, íconos y skins. Las skins, en particular, agrupan CSS y recursos visuales para adaptar una aplicación a una institución o contexto visual específico.

  `WebApp` carga la configuración de la aplicación combinando el manifiesto del proyecto frontend con una configuración asociada en MongoDB. El manifiesto define información del paquete y APIs disponibles; la configuración de MongoDB define variables de comportamiento, como plugins activos y parámetros específicos del dominio.

  #figure(
    image("./imagenes/arquitectura_web_app_1.png", width: 80%),
    caption: [Relación entre `WebApp`, aplicaciones, plugins y recursos compartidos en la arquitectura frontend de Lahuén.],
  ) <fig-arquitectura-web-app>

  La extensión mediante plugins se realiza a través de una clase base `Plugin` ubicada en `shared`, que entrega a cada plugin acceso a la aplicación, al store, a las APIs y a los eventos. De este modo, una aplicación puede cargar piezas de funcionalidad separadas sin mezclar toda la lógica en su base común.

  Para el patrón de listas de trabajo, o worklists, existe una aplicación base construida sobre `WebApp`, junto con `WorklistPlugin`, una extensión de `Plugin` que agrega comportamiento común para este tipo de plugins. Un plugin de worklist puede registrar módulos, componentes, menús, filtros, grillas, formularios, suscripciones a eventos y reglas del dominio, de modo que la aplicación base conserva la estructura común mientras cada plugin define cómo se muestran y operan los casos de un proceso específico.

  Además, existen plugins comunes de worklists como `standard`, que permiten reutilizar modelos y secciones de formularios entre aplicaciones. Estos componentes viven en un plugin porque son más específicos que los elementos genéricos de `shared`: por ejemplo, secciones de formularios asociadas a paciente, clínico, ubicación o admisión. En cambio, `shared` contiene piezas más transversales, como componentes de tabla, datepicker, select, typeahead, formateadores, utilidades, skins e íconos.

  == Modales de confirmación <anexo-modales-confirmacion>

  La aplicación de proceso quirúrgico utiliza modales de confirmación para acciones que requieren una decisión explícita del usuario antes de continuar. Estos modales se invocan mediante `WebApp.showQuestion`, que presenta un mensaje y opciones de confirmación. Si el usuario confirma, el diálogo resuelve exitosamente y la acción continúa su ejecución. En la @fig-anexo-modal-confirmacion se muestra un ejemplo de este patrón al devolver un paciente a su unidad de origen.

  #figure(
    image("./imagenes/anexo-devolver-unidad-de-origen.png", width: 60%),
    caption: [Ejemplo de modal de confirmación.],
  ) <fig-anexo-modal-confirmacion>

  == Side panels <anexo-side-panels>

  Para acciones que requieren seleccionar datos o completar información antes de ejecutarse, la aplicación utiliza side panels. El panel se muestra mediante `WebApp.actionPanel.show`, lo que permite montar un componente específico en un panel lateral sin abandonar el contexto de la lista de trabajo. La @fig-anexo-sidepanel-recepcion muestra un ejemplo en la recepción de un paciente, donde se selecciona la ubicación de pabellón antes de confirmar el ingreso.

  #figure(
    image("./imagenes/cap06-recepcion-paciente.png", width: 80%),
    caption: [Ejemplo de side panel.],
  ) <fig-anexo-sidepanel-recepcion>

  == Formularios tipo checklist <anexo-formularios-checklist>

  Para registros estructurados basados en preguntas y opciones, como los cuidados intraoperatorios y las pausas quirúrgicas, se utiliza un formulario tipo checklist llamado `scale form`. La configuración del checklist combina un tipo de evaluación, que indica que se trata de una escala, y un tipo de signo vital, que define las preguntas, opciones y observaciones del formulario.

  El tipo de evaluación contiene la configuración general del registro:

  ```json
  {
    "evlt_description": "Aplicación de escala/checklist",
    "evlt_label": "Escalas",
    "evlt_configuration": {
      "dischargeType": 0,
      "closeCareManager": false,
      "saveIfPatientServiceClosed": true
    }
  }
  ```

  El tipo de signo vital almacena en `vstp_extended_data` la estructura del checklist: título, tipo, cantidad de columnas, si permite observaciones y la lista de preguntas con sus opciones.

  ```json
  {
    "scales": {
      "cuidadosIntraoperatorios": {
        "type": "checklist",
        "columnCount": 4,
        "withSelection": false,
        "withObs": true,
        "sections": [
          {
            "questions": [
              {
                "id": "q1",
                "title": "LPP en pabellón",
                "options": [
                  { "label": "Alto", "value": "Alto" },
                  { "label": "Bajo", "value": "Bajo" }
                ],
                "obs": true
              }
            ]
          }
        ]
      }
    }
  }
  ```

  En la @fig-anexo-checklist-cuidados se muestra un ejemplo del formulario de cuidados intraoperatorios.

  #figure(
    image("./imagenes/cap06-accion-cuidados-intraoperatorios.png", width: 80%),
    caption: [Ejemplo de formulario tipo checklist.],
  ) <fig-anexo-checklist-cuidados>

  == Formularios clínicos mediante iframe <anexo-formularios-iframe>

  Para documentos formales que pertenecen a la ficha clínica del paciente, como la evaluación preanestésica y el protocolo quirúrgico, la aplicación carga formularios de la aplicación EHR mediante `WebApp.loadModalEvaluation`. Este método utiliza un modal de paciente, pero en lugar de montar un widget de checklist incorpora un `iframe` que carga el formulario configurado desde una ruta de EHR.

  En la @fig-anexo-formulario-protocolo se muestra el registro del protocolo quirúrgico como ejemplo de este mecanismo.

  #figure(
    image("./imagenes/cap06-accion-protocolo-qx.png", width: 80%),
    caption: [Ejemplo de formulario clínico cargado mediante iframe.],
  ) <fig-anexo-formulario-protocolo>

  La evaluación correspondiente debe existir previamente en la base de datos, con su esquema de validación y configuración de mensajes de error. Para el protocolo quirúrgico, por ejemplo, se define un tipo de evaluación con identificador `14`. Su `evlt_data_schema` valida la estructura del documento mediante secciones como `paciente`, `informacionDocumento`, `equipoMedico`, `intervencion` e `indications`. Su `evlt_configuration` asocia etiquetas legibles y mensajes de error personalizados a cada campo, de modo que EHR pueda verificar la información ingresada y comunicar al usuario qué datos aún faltan por completar.

  ```json
  {
    "evlt_description": "PROTOCOLO OPERATORIO",
    "evlt_data_schema": {
      "$schema": "http://json-schema.org/draft-07/schema#",
      "type": "object",
      "properties": {
        "paciente": { "type": "object" },
        "informacionDocumento": { "type": "object" },
        "equipoMedico": { "type": "object" },
        "intervencion": { "type": "object" },
        "indications": { "type": "array" }
      },
      "required": [
        "paciente",
        "informacionDocumento",
        "equipoMedico",
        "intervencion",
        "indications"
      ]
    },
    "evlt_configuration": {
      "formTitle": "Protocolo operatorio",
      "dataPathLabels": {
        "/paciente/documento": "Documento",
        "/intervencion/descripcionQuirurgica": "Descripción quirúrgica"
      },
      "errorHints": {
        "required": "Este campo es obligatorio",
        "minItems": "Debe agregar al menos un elemento"
      }
    }
  }
  ```
]

#apendice(title: "Instrumentos de evaluación", label: <anexo-instrumentos-evaluacion>)[
  El cuestionario SUS aplicado a los participantes se presenta en la @tab-encuesta-sus. Las preguntas utilizan una escala Likert de 1 (totalmente en desacuerdo) a 5 (totalmente de acuerdo).

  #figure(
    table(
      columns: (1fr, auto, auto, auto, auto, auto),
      align: (left, center, center, center, center, center),
      table.header([Pregunta], [1], [2], [3], [4], [5]),
      [1. Me gustaría usar esta herramienta frecuentemente.], [], [], [], [], [],
      [2. Considero que esta herramienta es innecesariamente compleja.], [], [], [], [], [],
      [3. Considero que la herramienta es fácil de usar.], [], [], [], [], [],
      [4. Considero necesario el apoyo de personal experto para poder utilizar esta herramienta.], [], [], [], [], [],
      [5. Considero que las funciones de la herramienta están bien integradas.], [], [], [], [], [],
      [6. Considero que la herramienta presenta muchas contradicciones.], [], [], [], [], [],
      [7. Imagino que la mayoría de las personas aprenderían a usar esta herramienta rápidamente.], [], [], [], [], [],
      [8. Considero que el uso de esta herramienta es tedioso.], [], [], [], [], [],
      [9. Me sentí muy confiado al usar la herramienta.], [], [], [], [], [],
      [10. Necesité saber bastantes cosas antes de poder empezar a usar esta herramienta.], [], [], [], [], [],
    ),
    caption: [Cuestionario SUS aplicado en la evaluación de usabilidad del módulo de pabellón.],
  ) <tab-encuesta-sus>
]

#apendice(title: "Documentos generados", label: <anexo-documentos-generados>)[
  #figure(
    image("./imagenes/cap06-pdf-protocolo.png", width: 60%),
    caption: [PDF generado mediante la acción `Ver PDF protocolo`.],
  ) <fig-anexo-documento-protocolo>
]

#apendice(title: "Uso de inteligencia artificial", label: <anexo-uso-ia>)[
  == Metodología de uso

  La metodología de uso consistió en definir primero el problema, el contexto y los criterios de salida; luego usar la herramienta para proponer borradores, resúmenes, reorganizaciones o implementaciones acotadas; y finalmente revisar el resultado antes de aceptarlo, corregirlo o descartarlo. La verificación fue siempre manual: en código, contrastando los cambios con la arquitectura del proyecto y validándolos con compilaciones o pruebas funcionales cuando correspondía; en redacción, revisando precisión técnica, tono y consistencia con las decisiones efectivamente tomadas durante el trabajo.

  == Prompt representativo

  El siguiente prompt es representativo del tipo de instrucciones utilizadas para redactar o reorganizar contenido del informe a partir de antecedentes ya definidos por el memorista:

  ```text
  Estoy trabajando en una memoria sobre la modernización del módulo de atención quirúrgica de la Plataforma Lahuén.

  Necesito reescribir una sección del informe en español formal, con tono de memoria de ingeniería, evitando redundancias con capítulos de diseño e implementación.

  Contexto que debes respetar:
  - La versión anterior del módulo era funcionalmente valiosa, pero técnicamente difícil de mantener y evolucionar.
  - No debes presentar la solución anterior como incorrecta o inútil.
  - La nueva solución conserva el flujo quirúrgico y reemplaza la dependencia del motor de procesos deprecado por una arquitectura más mantenible.
  - No inventes decisiones: usa solo la información entregada.
  - Si resumes funcionalidades o cambios, prioriza claridad y trazabilidad.

  Tu tarea es:
  - compactar el texto,
  - mantener los puntos importantes,
  - mover al capítulo de diseño solo lo que sea justificación conceptual,
  - dejar fuera listas largas de acciones si ya están explicadas en implementación.
  ```
]
