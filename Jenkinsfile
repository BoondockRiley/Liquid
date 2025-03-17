pipeline {
    agent any

    environment {
        LIQUIBASE_PATH = "/usr/local/bin/liquibase"  
        CHANGELOG_FILE = "QA/Tables/changelog.sql"
        DEV_DB_URL = "jdbc:postgresql://localhost:5433/dvdrental"
        QA_DB_URL = "jdbc:postgresql://localhost:5434/dvdrental"
        DB_USER = "postgres"
        DB_PASS = "secret"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Fetching latest code from GitHub...'
                git branch: 'main', 
                    credentialsId: 'github-token', 
                    url: 'https://github.com/BoondockRiley/Liquid.git'
            }
        }

        stage('Apply Changes to DEV') {
            steps {
                echo 'Running Liquibase on DEV...'
                script {
                    def status = sh(
                        script: """
                        ${LIQUIBASE_PATH} --url=${DEV_DB_URL} --username=${DB_USER} --password=${DB_PASS} --changeLogFile=${CHANGELOG_FILE} update
                        """,
                        returnStatus: true
                    )
                    if (status != 0) {
                        error "Liquibase update failed on DEV. Stopping pipeline."
                    }
                }
            }
        }

        stage('Verify DEV Liquibase Warnings') {
            steps {
                echo 'Checking Liquibase status on DEV...'
                script {
                    def status = sh(
                        script: """
                        ${LIQUIBASE_PATH} --url=${DEV_DB_URL} --username=${DB_USER} --password=${DB_PASS} --changeLogFile=${CHANGELOG_FILE} status --verbose
                        """,
                        returnStatus: true
                    )
                    if (status != 0) {
                        error "Liquibase found warnings on DEV. Stopping pipeline."
                    }
                }
            }
        }

        stage('Apply Changes to QA') {
            steps {
                echo 'Running Liquibase on QA...'
                script {
                    def status = sh(
                        script: """
                        ${LIQUIBASE_PATH} --url=${QA_DB_URL} --username=${DB_USER} --password=${DB_PASS} --changeLogFile=${CHANGELOG_FILE} update
                        """,
                        returnStatus: true
                    )
                    if (status != 0) {
                        error "Liquibase update failed on QA. Stopping pipeline."
                    }
                }
            }
        }

        stage('Verify QA Liquibase Warnings') {
            steps {
                echo 'Checking Liquibase status on QA...'
                script {
                    def status = sh(
                        script: """
                        ${LIQUIBASE_PATH} --url=${QA_DB_URL} --username=${DB_USER} --password=${DB_PASS} --changeLogFile=${CHANGELOG_FILE} status --verbose
                        """,
                        returnStatus: true
                    )
                    if (status != 0) {
                        error "Liquibase found warnings on QA. Stopping pipeline."
                    }
                }
            }
        }

    }

    post {
        success {
            echo "Pipeline completed successfully! Liquibase updates applied to DEV and QA."
        }
        failure {
            echo "Pipeline failed. Check logs for details."
        }
    }
}
