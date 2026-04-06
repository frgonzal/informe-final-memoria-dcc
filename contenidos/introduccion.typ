== Contexto general

La digitalización de procesos clínicos y hospitalarios se ha transformado en una necesidad prioritaria para los sistemas de salud. La creciente demanda asistencial, la presión por optimizar recursos escasos y la necesidad de contar con información oportuna para la toma de decisiones han impulsado el desarrollo de plataformas digitales capaces de integrar distintos ámbitos de la operación hospitalaria. En este escenario, los sistemas de información en salud han dejado de ser simples repositorios de datos para convertirse en herramientas activas de gestión clínica, coordinación operativa y trazabilidad de procesos.

Dentro de los distintos ámbitos hospitalarios, la gestión quirúrgica representa uno de los procesos más complejos. Su ejecución requiere coordinar pacientes, equipos clínicos, pabellones, equipamiento, camas y tiempos de atención, todo ello en un contexto donde conviven actividades programadas y situaciones de urgencia. El proceso quirúrgico no se limita al acto operatorio, sino que comprende un flujo más amplio que comienza con la indicación de una cirugía, continúa con su aceptación o programación, sigue con la preparación preoperatoria, el ingreso a pabellón, la ejecución de la cirugía, la recuperación y, finalmente, el egreso o traslado del paciente.

La correcta gestión de este flujo tiene consecuencias directas sobre la eficiencia hospitalaria, la calidad de la atención y la seguridad del paciente. Un sistema capaz de representar adecuadamente el proceso quirúrgico, registrar sus hitos y apoyar la coordinación entre sus distintos participantes puede transformarse en un componente clave para mejorar tanto la operación diaria como la capacidad de análisis y mejora continua de una institución de salud.

== Organización

El presente trabajo se desarrolla en el contexto de una empresa chilena de tecnología en salud orientada al diseño e implementación de soluciones digitales para establecimientos clínicos. La organización ha construido una plataforma digital que integra distintos módulos relacionados con la atención de pacientes, la gestión asistencial y la operación hospitalaria, con el objetivo de ofrecer una solución extensible e interoperable.

Dentro de esta plataforma, el módulo de pabellón ocupa un lugar estratégico, ya que articula el trabajo quirúrgico con otros componentes clínicos y administrativos del sistema. Su función no es únicamente registrar eventos, sino también apoyar el seguimiento de los pacientes quirúrgicos, facilitar la coordinación entre equipos y entregar visibilidad del estado del proceso. Debido a ello, cualquier mejora o modernización de este módulo tiene un impacto relevante tanto en la operación clínica como en la evolución tecnológica de la plataforma en su conjunto.

== Problema

A pesar de contar con una implementación funcional del proceso quirúrgico, el módulo existente presenta limitaciones importantes desde el punto de vista tecnológico y de mantenibilidad. La solución actual fue construida sobre tecnologías heredadas y mecanismos propios de orquestación, lo que permitió resolver necesidades operativas en su momento, pero que hoy dificulta la evolución del sistema.

Esta situación genera varios problemas. En primer lugar, la lógica del proceso quirúrgico se encuentra fuertemente acoplada a componentes específicos, lo que hace más costoso modificar el flujo, incorporar nuevas acciones o adaptar el módulo a otros contextos hospitalarios. En segundo lugar, la base tecnológica heredada limita la integración con la arquitectura moderna del resto de la plataforma, dificultando la reutilización de componentes y la incorporación de capacidades transversales como mejor observabilidad, manejo robusto de errores y sincronización eficiente con otras partes del sistema. En tercer lugar, la existencia de una solución especializada y dependiente de tecnologías antiguas introduce deuda técnica, afectando la estabilidad, la escalabilidad y la velocidad con que pueden implementarse mejoras.

Desde una perspectiva funcional, esto se traduce en una brecha entre lo que el sistema ya logra hacer y lo que necesita ofrecer en el futuro. Aunque el módulo permite representar y operar el flujo quirúrgico, no cuenta todavía con una base suficientemente moderna, flexible y reusable como para sostener su evolución de manera segura y sostenible.

== Motivación y relevancia

La modernización del proceso quirúrgico resulta relevante por razones tanto operativas como tecnológicas. Desde el punto de vista del dominio clínico, la gestión de pabellones y del flujo intraoperatorio requiere una coordinación precisa y una trazabilidad clara de cada etapa del proceso. Disponer de una herramienta que refleje adecuadamente el estado de cada paciente, las transiciones relevantes y las acciones posibles en cada momento puede contribuir a mejorar la visibilidad del proceso y apoyar la toma de decisiones por parte de los equipos clínicos.

Desde el punto de vista tecnológico, este proyecto responde a la necesidad de alinear el módulo quirúrgico con la arquitectura actual de la plataforma, reduciendo deuda técnica y sentando bases más sólidas para futuras extensiones. Modernizar este componente no solo mejora su mantenibilidad y confiabilidad, sino que también permite que el sistema evolucione hacia una solución más reusable y adaptable a distintos establecimientos de salud.

La relevancia del trabajo también radica en que aborda un problema real dentro de un entorno de producción, donde las decisiones de diseño e implementación deben responder tanto a requerimientos técnicos como a necesidades operativas concretas. En ese sentido, el proyecto no se limita a proponer una solución teórica, sino que busca construir una mejora efectiva sobre un sistema que ya forma parte del trabajo cotidiano de una organización del sector salud.

== Objetivos

El objetivo general de este trabajo es modernizar el proceso de atención quirúrgica de una plataforma digital de salud, de modo que opere de forma estable sobre una arquitectura actualizada, con un flujo completo y trazable para pacientes quirúrgicos, tanto en cirugías electivas como de urgencia.

Para alcanzar este objetivo general, se plantean los siguientes objetivos específicos:

- Modelar de forma explícita el flujo de atención quirúrgica mediante un conjunto coherente de estados y acciones.
- Modernizar la vista de atención quirúrgica para integrarla adecuadamente a la plataforma y representar la información relevante de cada paciente.
- Reemplazar el mecanismo heredado de orquestación por una solución más moderna y robusta para coordinar acciones complejas del flujo.
- Mejorar la trazabilidad de los hitos del proceso quirúrgico, de modo que sea posible reconstruir el recorrido de un caso y disponer de información útil para análisis posteriores.
- Validar la solución mediante pruebas funcionales y despliegues controlados que permitan verificar su uso en un entorno real.
- Dejar una base técnica y documental que facilite la evolución futura del módulo de pabellón.

== Resumen de la solución

La solución propuesta consiste en modernizar el núcleo del proceso de atención quirúrgica sobre la arquitectura actual de la plataforma, manteniendo su valor clínico y operativo, pero reemplazando los componentes heredados que dificultan su evolución. Para ello, se plantea modelar el flujo de atención quirúrgica como una secuencia explícita de estados y transiciones, donde cada acción relevante del usuario tenga un comportamiento claramente definido y trazable.

En el backend, la modernización considera la incorporación de un mecanismo de orquestación más robusto para aquellas operaciones que requieren coordinar múltiples pasos o servicios. Esto permite separar mejor la lógica del proceso, manejar fallas de manera más controlada y dar mayor observabilidad a la ejecución del flujo. En paralelo, se busca consolidar un modelo de dominio unificado para representar cada atención quirúrgica, integrando datos clínicos, de programación y de ubicación del paciente.

En el frontend, la solución se materializa en una vista de atención quirúrgica integrada a la plataforma, concebida como una lista de trabajo que muestra el estado de los pacientes y permite ejecutar las acciones correspondientes a cada etapa. De esta manera, la solución busca combinar claridad operativa para los usuarios con una arquitectura más mantenible y extensible desde el punto de vista del desarrollo de software.

== Alcance

El alcance del trabajo se concentra en la modernización del proceso de atención quirúrgica, especialmente en el flujo intraoperatorio y en las etapas cercanas a este. Esto incluye la representación del flujo de pacientes quirúrgicos, la ejecución de acciones asociadas a cambios de estado y el registro de hitos relevantes para la trazabilidad del proceso.

No forma parte del alcance una reconstrucción completa de todo el módulo de pabellón ni un rediseño integral del sistema de listas de espera quirúrgicas. En cambio, el proyecto se enfoca en una parte acotada pero fundamental del problema, buscando construir una base tecnológica moderna sobre la cual puedan apoyarse futuras mejoras y extensiones.

Esta delimitación permite trabajar sobre un objetivo abordable dentro del contexto del proyecto, al mismo tiempo que deja preparado el terreno para continuar evolucionando el sistema en etapas posteriores.

== Estructura del documento

El presente informe se organiza de la siguiente manera. En primer lugar, se presenta el estado del arte y el contexto técnico y operativo del problema abordado. Luego, se describen los objetivos del trabajo y la solución propuesta, incluyendo el modelado del flujo de atención quirúrgica y las principales decisiones de diseño. A continuación, se expone el plan de trabajo y el desarrollo realizado, detallando los avances implementados tanto en la vista de atención quirúrgica como en la unificación de datos, el manejo de estados y acciones, y la nueva orquestación del proceso. Finalmente, se presentan la evaluación del trabajo realizado, las conclusiones y las posibles líneas de trabajo futuro.
