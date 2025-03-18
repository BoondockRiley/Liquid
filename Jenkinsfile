pipeline {
  agent any
  stages {
    stage('Dev') {
      steps {
        git(url: 'Jenkinsfile', branch: 'main', credentialsId: 'github-token2', poll: true)
      }
    }

  }
}