pipeline {
  agent any
  stages {
    stage('Dev') {
      parallel {
        stage('Dev') {
          steps {
            echo 'Start'
          }
        }

        stage('Git') {
          steps {
            git(url: 'https://github.com/BoondockRiley/Liquid', branch: 'main', changelog: true, credentialsId: 'github-token2', poll: true)
          }
        }

        stage('Directory') {
          steps {
            bat(script: 'pwd', returnStatus: true)
          }
        }

      }
    }

    stage('Pause') {
      steps {
        echo 'Pause'
      }
    }

    stage('Test') {
      steps {
        echo 'Start Test Deployment'
      }
    }

  }
}