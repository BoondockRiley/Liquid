pipeline {
    agent {
        docker {
            image 'liquibase/liquibase:4.31.1' // Specify the correct version of the image
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
                bat """
                liquibase --version
                echo %CD%  // Display current working directory in Windows
                """
            }
        }
    }
}
