pipeline {
  agent any

  tools {
    jdk 'jdk-17'
    maven 'maven-3.9'
  }

  environment {
    KARATE_ENV = 'cert'
    KARATE_TAGS = '@regresion'
    KARATE_THREADS = '4'
  }

  options {
    timestamps()
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Run Karate Tests') {
      steps {
        script {
          // Genera el JSON compatible con el plugin de Cucumber:
          def karateOpts = "--tags ${env.KARATE_TAGS} --threads ${env.KARATE_THREADS} --format cucumber:target/cucumber-reports/cucumber.json"
          if (isUnix()) {
            sh "mvn -B -q -Dkarate.env=${env.KARATE_ENV} -Dkarate.options=\"${karateOpts}\" test"
          } else {
            bat "mvn -B -q -Dkarate.env=%KARATE_ENV% -Dkarate.options=\"${karateOpts}\" test"
          }
        }
      }
    }

    stage('Publish Reports') {
      steps {
        script {
          def surefirePattern = isUnix() ? 'target/surefire-reports/*.xml' : 'target\\surefire-reports\\*.xml'
          junit allowEmptyResults: true, testResults: surefirePattern
        }

        // Reporte Cucumber (usar SOLO parámetros válidos)
        cucumber(
          jsonReportDirectory: 'target/cucumber-reports',
          fileIncludePattern: 'cucumber.json',
          buildStatus: 'UNSTABLE' // usa 'FAILURE' si quieres romper el build ante fallos
        )

        // Reporte HTML nativo de Karate
        publishHTML(target: [
          reportDir: 'target/karate-reports',
          reportFiles: 'karate-summary.html',
          reportName: 'Karate Report',
          keepAll: true,
          alwaysLinkToLastBuild: true
        ])

        // (Opcional) Archiva el JSON de Cucumber para auditoría
        archiveArtifacts artifacts: 'target/cucumber-reports/cucumber.json', fingerprint: true
      }
    }
  }

  post {
    always {
      archiveArtifacts artifacts: 'target/karate-reports/**', onlyIfSuccessful: false
    }
  }
}
