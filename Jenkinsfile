pipeline {
  agent any

  stages {
    stage('Dev') {
      steps {
        echo 'We begin'
        
        // Checkout Git repository
        git branch: 'main', 
            credentialsId: 'github-token', 
            url: 'https://github.com/BoondockRiley/Liquid.git'
      }
    }

    stage('Test') {
      steps {
        echo 'We begin again'
      }
    }
  }
}
