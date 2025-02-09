pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/Rohan-Dighe/jenkins-ci-cd-demo.git'
        IMAGE_NAME = 'myapp'
        DOCKER_PORT = '8081:8080'
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning repository...'
                deleteDir()  // Clean workspace before cloning
                git branch: 'main', url: "${GIT_REPO}"
            }
        }

        stage('Build') {
            steps {
                echo 'Building the application...'

                // Check the current directory and list files
                sh 'pwd'
                sh 'ls -l'

                // Run Maven from the root directory (if pom.xml is there)
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'mvn test'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                sh '''
                docker build -t ${IMAGE_NAME} .
                docker run -d -p ${DOCKER_PORT} ${IMAGE_NAME}
                '''
            }
        }
    }
}
