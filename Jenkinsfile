pipeline {
    agent any

    // environment {
    //     // Paths and database configurations
    //     LIQUIBASE_DIR = "C:/Users/ben_r/Documents/GitHub/LB/Liquid/data/liquibase"
    //     CHANGELOG_FILE = "example-changelog.sql"  // Update with actual changelog file
    //     DEV_DB_URL = "jdbc:postgresql://localhost:5433/dev_database"
    //     QA_DB_URL = "jdbc:postgresql://localhost:5434/qa_database"
    //     DB_USERNAME = "postgres"
    //     DB_PASSWORD = "secret"
    // }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out repository...'
                git branch: 'main', 
                    credentialsId: 'github-token', 
                    url: 'https://github.com/BoondockRiley/Liquid.git'
            }
        }

        stage('Liquibase Update DEV') {
            steps {
                echo 'Running Liquibase update on DEV database...'

                script {
                    def devResult = bat(
                        script: """
                            cd /d "${LIQUIBASE_DIR}"
                            liquibase update --changelog-file=${CHANGELOG_FILE} \
                            --url=${DEV_DB_URL} --username=${DB_USERNAME} --password=${DB_PASSWORD}
                        """,
                        returnStatus: true
                    )

                    if (devResult != 0) {
                        error "Liquibase update failed for DEV database!"
                    }
                }
            }
        }

        stage('Liquibase Verify DEV') {
            steps {
                echo 'Verifying Liquibase status on DEV database...'

                script {
                    def statusResult = bat(
                        script: """
                            cd /d "${LIQUIBASE_DIR}"
                            liquibase status --changelog-file=${CHANGELOG_FILE} \
                            --url=${DEV_DB_URL} --username=${DB_USERNAME} --password=${DB_PASSWORD} --verbose
                        """,
                        returnStatus: true
                    )

                    if (statusResult != 0) {
                        error "Liquibase status check failed for DEV database!"
                    }
                }
            }
        }

        stage('Liquibase Update QA') {
            steps {
                echo 'Running Liquibase update on QA database...'

                script {
                    def qaResult = bat(
                        script: """
                            cd /d "${LIQUIBASE_DIR}"
                            liquibase update --changelog-file=${CHANGELOG_FILE} \
                            --url=${QA_DB_URL} --username=${DB_USERNAME} --password=${DB_PASSWORD}
                        """,
                        returnStatus: true
                    )

                    if (qaResult != 0) {
                        error "Liquibase update failed for QA database!"
                    }
                }
            }
        }

        stage('Liquibase Verify QA') {
            steps {
                echo 'Verifying Liquibase status on QA database...'

                script {
                    def statusResult = bat(
                        script: """
                            cd /d "${LIQUIBASE_DIR}"
                            liquibase status --changelog-file=${CHANGELOG_FILE} \
                            --url=${QA_DB_URL} --username=${DB_USERNAME} --password=${DB_PASSWORD} --verbose
                        """,
                        returnStatus: true
                    )

                    if (statusResult != 0) {
                        error "Liquibase status check failed for QA database!"
                    }
                }
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
