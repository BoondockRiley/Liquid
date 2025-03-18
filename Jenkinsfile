pipeline {
    agent {
        docker {
            image 'liquibase/liquibase:latest' // Use the latest version of the Liquibase Docker image
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

        stage('Liquibase Command') {
            steps {
                script {
                    // Define Windows-style and Docker-compatible paths
                    def workspacePath = "C:/ProgramData/Jenkins/.jenkins/workspace/Liquid_main"
                    def workspaceDockerPath = "/mnt/jenkins_workspace"

                    // Run Liquibase inside the container with correct path mounting
                    bat """
                    docker run -d -t -v ${workspacePath}:${workspaceDockerPath} -w ${workspaceDockerPath} liquibase/liquibase:latest liquibase --version
                    """
                }
            }
        }
    }
}
