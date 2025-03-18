pipeline {
  agent any  // This will run on any available node (including master if no agents are specified)
  environment {
    LIQUIBASE_CREDS = credentials('liquibase-credentials')  // Ensure these credentials are set up in Jenkins
    LIQUIBASE_DIR = "Liquid/data/liquibase"
    CHANGELOG_FILE = "example-changelog.sql"  // Update with your actual changelog file name
    DEV_DB_URL = "jdbc:postgresql://localhost:5433/dev_database"
    QA_DB_URL = "jdbc:postgresql://localhost:5434/qa_database"
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
        script {
          // Running Liquibase status
          sh """
            liquibase status --url="${DEV_DB_URL}" --changeLogFile="${LIQUIBASE_DIR}/${CHANGELOG_FILE}" --username="${DB_USERNAME}" --password="${DB_PASSWORD}"
          """
        }
      }
    }

    stage('Liquibase Update') {
      steps {
        script {
          // Running Liquibase update
          sh """
            liquibase update --url="${DEV_DB_URL}" --changeLogFile="${LIQUIBASE_DIR}/${CHANGELOG_FILE}" --username="${DB_USERNAME}" --password="${DB_PASSWORD}"
          """
        }
      }
    }
  }
  post {
    always {
      // Wrap cleanWs() inside a node block
      node {
        cleanWs()  // Clean workspace at the end of the pipeline
      }
    }
  }
}
