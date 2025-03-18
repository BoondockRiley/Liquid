pipeline {
  agent none
  stages {
    stage('Setup Docker') {
      agent { label 'docker-agent' } // Replace with the appropriate node label
      steps {
        script {
          def workspace = pwd() // Get the absolute path to the Jenkins workspace
          echo "Workspace: ${workspace}"

          docker.image('liquibase/liquibase:4.4.2').inside("-v ${workspace}:/mnt/workspace") {
            sh 'liquibase status --url="jdbc:postgresql://localhost:5433/dev_database" --changeLogFile="Liquid/data/liquibase/example-changelog.sql" --username="postgres" --password="secret"'
          }
        }
      }
    }
  }
}
