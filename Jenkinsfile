pipeline {
    agent any
    environment {
        FRONTEND_IMAGE = "vishu0939/frontend"
        USER_IMAGE = "vishu0939/user-service"
        PRODUCT_IMAGE = "vishu0939/product-service"
    }


//clone code from github to jenkins workspace

    stages {
        stage ('CODE CLONE from github url TO JENKINS WORKSPACE') {
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
        

//build image

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

//docker hub login

        stage('DOCKER HUB LOGIN') {
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

//image push 

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


//DEPLOYMENT

        stage('DEPLOYMENT ON KUBERNETES') {
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
                        
                        kubectl rollout restart deployment/frontend -n microservices
                        kubectl rollout restart deployment/user-services -n microservices
                        kubectl rollout restart deployment/product-service -n microservices

                        kubectl get pods -n microservices

                        kubectl rollout status deployment/frontend -n microservices
                        kubectl rollout status deployment/user-services -n microservices
                        kubectl rollout status deployment/product-service -n microservices
                     '''
                }
            }
        }
    }
}
