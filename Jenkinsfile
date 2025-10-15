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
        cucumber buildStatus: 'FAILURE', fileIncludePattern: 'cucumber.json', jsonReportDirectory: 'target/cucumber-reports', missingIncludes: 'SKIP_BUILD'
        publishHTML(
          target: [
            reportDir: 'target/karate-reports',
            reportFiles: 'karate-summary.html',
            reportName: 'Karate Report',
            keepAll: true,
            alwaysLinkToLastBuild: true
          ]
        )
      }
    }
  }

  post {
    always {
      archiveArtifacts artifacts: 'target/karate-reports/**', onlyIfSuccessful: false
    }
  }
}
