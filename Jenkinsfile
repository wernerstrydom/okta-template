pipeline {
    options {
        disableConcurrentBuilds()
    }
    agent none
    triggers {
        pollSCM 'H/2 * * * *'
    }
    environment {
        OKTA_API_TOKEN         = credentials('okta-api-token')
        OKTA_BASE_URL          = credentials('okta-base-url')
        OKTA_ORG_NAME          = credentials('okta-org-name')
    }
    stages {
        stage('Plan') {
            agent any
            when {
                branch 'master'
            }
            steps {
                sh 'terraform -v'         
                sh 'terraform init'
                sh 'terraform plan -input=false'
            }
        }
        stage('Promote') {
            agent any 
            when {
                branch 'master'
            }
            steps {
                timeout(time: 60, unit: 'MINUTES') {
                    input(id: 'Promotion Gate', message: 'Promote changes?', ok: 'Promote')
                }
            }
        }
        stage('Apply') {
            agent any
            when {
                branch 'master'
            }
            steps {
                sh 'terraform -v'         
                sh 'terraform init'
                sh 'terraform apply -input=false -auto-approve'
            }
        }
    }
}
