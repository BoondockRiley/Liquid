pipeline {
    agent {
        docker {
            image 'liquibase/liquibase:latest'  // Use the latest version or specify the version
        }
    }
    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out repository...'
                git branch: 'main', 
                    credentialsId: 'github-token2', 
                    url: 'https://github.com/BoondockRiley/Liquid.git'
            }
        }

        stage('Liquibase Command') {
            steps {
                script {
                    // Run Liquibase inside the container using bat (Windows)
                    bat """
                    liquibase --version  // Check Liquibase version to confirm it's working
                    """
                }
            }
        }
    }
}
