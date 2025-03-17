pipeline {
    agent any

    stages {
        stage('Dev') {
            steps {
                echo 'We begin'

                // Checkout the GitHub repo
                git branch: 'main', 
                    credentialsId: 'github-token', 
                    url: 'https://github.com/BoondockRiley/Liquid.git'
            }
        }

        stage('Run Script') {
            steps {
                echo 'Running Bash script'

                // Run the script using Git Bash
                bat '"C:\\Program Files\\Git\\bin\\bash.exe" -c "/c/Users/ben_r/Documents/GitHub/LB/Liquid/runme.sh"'
            }
        }

        stage('Test') {
            steps {
                echo 'We begin again'
            }
        }
    }
}
