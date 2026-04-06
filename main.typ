#import "final.typ": conf, resumen, dedicatoria, agradecimientos, start-doc, end-doc, capitulo, apendice
#import "metadata.typ": metadata

#show: conf.with(metadata: metadata)

#resumen(metadata: metadata)[]

#dedicatoria[]

#agradecimientos[]

#show: start-doc


#capitulo(title: "Introducción")[
  #include "contenidos/introduccion.typ"
]

#capitulo(title: "Contexto y situación actual")[
  #include "contenidos/contexto-situacion-actual.typ"
]

#capitulo(title: "Estado del arte / marco teórico")[
  #include "contenidos/estado-arte-marco-teorico.typ"
]

#capitulo(title: "Análisis del problema y requerimientos")[
  #include "contenidos/analisis-problema-requerimientos.typ"
]

#capitulo(title: "Diseño de la solución")[
  #include "contenidos/diseno-solucion.typ"
]

#capitulo(title: "Implementación")[
  #include "contenidos/implementacion.typ"
]

#capitulo(title: "Evaluación y validación")[
  #include "contenidos/evaluacion-validacion.typ"
]

#capitulo(title: "Resultados")[
  #include "contenidos/resultados.typ"
]

#capitulo(title: "Conclusiones")[
  #include "contenidos/conclusiones.typ"
]

#capitulo(title: "Trabajo futuro")[
  #include "contenidos/trabajo-futuro.typ"
]

#capitulo(title: "Bibliografía")[
  #include "contenidos/bibliografia.typ"
]

#capitulo(title: "Anexos")[
  #include "contenidos/anexos.typ"
]

#show: end-doc
