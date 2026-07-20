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
    }

    post{
       success{
          echo "pipeline success"
       }
       failure{
          echo "pipeline failed"
       }
    }
}

