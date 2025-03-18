pipeline {
    agent none  // No global agent, use specific agents for each stage
    stages {
        stage('Checkout Code') {
            agent any  // Runs on any available Jenkins node
            steps {
                echo 'Checking out repository...'
                git branch: 'main', 
                    credentialsId: 'github-token', 
                    url: 'https://github.com/BoondockRiley/Liquid.git'
            }
        }

        stage('Liquibase Command') {
            agent {
                docker {
                    image 'liquibase/liquibase:latest'  // Use Liquibase Docker image
                    args '-v /c/ProgramData/Jenkins/.jenkins/workspace/Liquid_main:/mnt/jenkins_workspace' // Mount Jenkins workspace to Docker container
                }
            }
            steps {
                script {
                    // Run Liquibase inside the container to check the version
                    sh """
                    liquibase --version  // Check Liquibase version to confirm it's working
                    """
                }
            }
        }
    }
}
