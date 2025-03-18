pipeline {
  agent {
    docker {
      image 'liquibase:latest'
    }

  }
  stages {
    stage('Git') {
      steps {
        echo 'Dev Start'
        git(url: 'https://github.com/BoondockRiley/Liquid', branch: 'main', credentialsId: 'github-token2')
      }
    }

    stage('Docker') {
      steps {
        bat 'liquibase --version\''
      }
    }

  }
}