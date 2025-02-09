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
                deleteDir() // Clean workspace before cloning
                git branch: 'main', url: "${GIT_REPO}"
            }
        }

        stage('Build') {
            steps {
                echo 'Building the application...'
                sh 'mvn clean package -DskipTests'
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
                /usr/bin/docker build -t ${IMAGE_NAME} .
                /usr/bin/docker run -d -p ${DOCKER_PORT} ${IMAGE_NAME}
                '''
            }
        }
    }
}
