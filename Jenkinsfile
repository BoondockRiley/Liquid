pipeline {
  agent {
    docker { image 'liquibase/liquibase:4.4.2' }
  }
  environment {
    LIQUIBASE_DIR = "Liquid/data/liquibase"
    CHANGELOG_FILE = "example-changelog.sql" 
    DEV_DB_URL = "jdbc:postgresql://localhost:5433/postgres"
    QA_DB_URL = "jdbc:postgresql://localhost:5434/postgres"
    DB_USERNAME = "postgres"
    DB_PASSWORD = "secret"
  }
  stages {
    stage('Checkout Code') {
      steps {
        echo 'Checking out repository...'
        git branch: 'main', 
            credentialsId: 'github-token', 
            url: 'https://github.com/BoondockRiley/Liquid.git'
      }
    }

    stage('Liquibase Status') {
      steps {
        sh """
          liquibase status --url="${DEV_DB_URL}" --changeLogFile="${LIQUIBASE_DIR}/${CHANGELOG_FILE}" --username="${DB_USERNAME}" --password="${DB_PASSWORD}"
        """
      }
    }
    stage('Liquibase Update') {
      steps {
        sh """
          liquibase update --url="${DEV_DB_URL}" --changeLogFile="${LIQUIBASE_DIR}/${CHANGELOG_FILE}" --username="${DB_USERNAME}" --password="${DB_PASSWORD}"
        """
      }
    }
  }
  post {
    always {
      cleanWs()
    }
  }
}
