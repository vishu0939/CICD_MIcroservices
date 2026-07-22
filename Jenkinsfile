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

        stage('BUILD USER SERVICE IMAGE') {
            steps{
                dir('microservices-project/user-service'){
                    sh '''
                    docker build -t ${USER_IMAGE}:latest .
                    '''
                }
            }
        }
        stage('BUILD PRODUCT SERVICE IMAGE') {
            steps{
                dir('microservices-project/product-service'){
                    sh '''
                    docker build -t ${PRODUCT_IMAGE}:latest .
                    '''
                }
            }
        }
        stage('Docker Hub Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {

                    sh '''
                       echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }


        stage('Push Frontend Image') {
            steps {
                sh '''
                    docker push ${FRONTEND_IMAGE}:latest
                '''
            }
        }
        stage('Push User Service Image') {
            steps {
                sh '''
                    docker push ${USER_IMAGE}:latest
                '''
            }
        }
        stage('Push Product Service Image') {
            steps {
                sh '''
                    docker push ${PRODUCT_IMAGE}:latest
                '''
            }
        }


        stage('Verify Kubernetes') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {

                     sh '''
                        export AWS_DEFAULT_REGION=eu-west-1
                        aws sts get-caller-identity
                        kubectl version --client
                        kubectl get nodes
                        kubectl get pods -n microservices
                     '''
                }
            }
        }
    }
}
