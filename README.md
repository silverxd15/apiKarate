# apiKarate

Este repositorio contiene un proyecto base de pruebas automatizadas con [Karate](https://github.com/karatelabs/karate) ejecutable con Maven y preparado para integrarse en un pipeline de Jenkins.

## Requisitos locales

* Java 17
* Maven 3.9+

Ejecuta las pruebas localmente con:

```bash
mvn test
```

## Pipeline de Jenkins

Incluye un `Jenkinsfile` declarativo preparado para ejecutar las pruebas de Karate en un agente con Maven y JDK configurados en Jenkins (por ejemplo, herramientas llamadas `jdk-17` y `maven-3.9`).

El pipeline realiza los siguientes pasos:

1. **Checkout** del repositorio mediante `checkout scm`.
2. **Ejecución de pruebas** con Maven estableciendo el entorno `KARATE_ENV`, los tags y el número de hilos (configurables mediante variables de entorno en Jenkins).
3. **Publicación de reportes** JUnit y del reporte HTML nativo de Karate. Además, se archivan los resultados para su consulta posterior.

Variables disponibles:

* `KARATE_ENV` (por defecto `cert`)
* `KARATE_TAGS` (por defecto `@regresion`)
* `KARATE_THREADS` (por defecto `4`)

Puedes sobreescribirlas definiendo variables en tu job de Jenkins o a nivel de multibranch pipeline.

Asegúrate de que el plugin **HTML Publisher** esté instalado en Jenkins para visualizar el reporte `karate-summary.html`.
