pipeline {
    agent any
    environment {
        FRONTEND_IMAGE = "vishu0939/frontend"
        USER_IMAGE = "vishu0939/user-service"
        PRODUCT_IMAGE = "vishu0939/product-service"
    }
    stages {
        stage ('project clone from github url') {
            steps{
                checkout scm
            }
        }

        stage ('verify workspace') {
            steps{
                sh '''
                echo "current directory: "
                pwd
                echo "repo structure: "
                ls -R
                '''
            }
        }
        

        stage('BUILD FRONTEND IMAGE') {
            steps{
                dir('microservices-project/frontend'){
                    sh '''
                    docker build -t ${FRONTEND_IMAGE}:latest .
                    '''
                }
            }
        }
    }
}
