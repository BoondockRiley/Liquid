pipeline {
    agent {
        docker {
            image 'liquibase/liquibase:'
            reuseNode true
        }
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

        stage("Liquibase Pre Check") {
            steps {
             sh 'liquibase --version'
         }
     }
    }
}

pipeline {
  agent any  // This will run on any available node (including master if no agents are specified)
  environment {
    //LIQUIBASE_DIR = "Liquid/data/liquibase"
   // CHANGELOG_FILE = "example-changelog.sql"  // Update with your actual changelog file name
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
    script {
      bat """
        pwd
        """
    }
  }
}


    stage('Liquibase Update') {
      steps {
        script {
          // Running Liquibase update using bat instead of sh for Windows
          bat """
            liquibase update --url="${DEV_DB_URL}" --changeLogFile="\\Liquid\\data\\liquibase\\example-changelog.sql" --username="${DB_USERNAME}" --password="${DB_PASSWORD}"
          """
        }
      }
    }
  }
  post {
    always {
      // Clean workspace
      cleanWs()
    }
  }
}
