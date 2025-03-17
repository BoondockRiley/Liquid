pipeline {
    agent any

    environment {
        DEV_DB_URL = 'jdbc:postgresql://localhost:5433/postgres'
        QA_DB_URL = 'jdbc:postgresql://localhost:5434/postgres'
        DB_USERNAME = 'postgres'
        DB_PASSWORD = 'secret'
        LIQUIBASE_DIR = 'data/liquibase'
        CHANGELOG_FILE = 'example-changelog.sql'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out repository...'

                // Checkout the GitHub repo
                git branch: 'main', 
                    credentialsId: 'github-token', 
                    url: 'https://github.com/BoondockRiley/Liquid.git'
            }
        }

        stage('Liquibase Update DEV') {
            steps {
                echo 'Running Liquibase update on DEV database...'

                script {
                    def devCmd = """
                        cd "${LIQUIBASE_DIR}" && \
                        liquibase update --changelog-file=${CHANGELOG_FILE} \
                        --url=${DEV_DB_URL} \
                        --username=${DB_USERNAME} \
                        --password=${DB_PASSWORD}
                    """

                    // Execute Liquibase update for DEV in Git Bash
                    def devResult = bat(script: "C:\\Program Files\\Git\\bin\\bash.exe -c '${devCmd}'", returnStatus: true)

                    // Stop pipeline if Liquibase fails
                    if (devResult != 0) {
                        error "Liquibase update failed for DEV database!"
                    }
                }
            }
        }

        stage('Liquibase Update QA') {
            steps {
                echo 'Running Liquibase update on QA database...'

                script {
                    def qaCmd = """
                        cd "${LIQUIBASE_DIR}" && \
                        liquibase update --changelog-file=${CHANGELOG_FILE} \
                        --url=${QA_DB_URL} \
                        --username=${DB_USERNAME} \
                        --password=${DB_PASSWORD}
                    """

                    // Execute Liquibase update for QA in Git Bash
                    def qaResult = bat(script: "C:\\Program Files\\Git\\bin\\bash.exe -c '${qaCmd}'", returnStatus: true)

                    // Stop pipeline if Liquibase fails
                    if (qaResult != 0) {
                        error "Liquibase update failed for QA database!"
                    }
                }
            }
        }

        stage('Test') {
            steps {
                echo 'Pipeline completed successfully.'
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
        }
        success {
            echo 'Liquibase updates completed successfully on both DEV and QA.'
        }
        failure {
            echo 'Pipeline failed during Liquibase updates.'
        }
    }
}
