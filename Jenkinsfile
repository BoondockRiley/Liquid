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
             bat "
             'liquibase --version'
             'PWD'
             " 
         }
     }
    }
}
