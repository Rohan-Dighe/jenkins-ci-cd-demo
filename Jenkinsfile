pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/Rohan-Dighe/jenkins-ci-cd-demo.git'
        IMAGE_NAME = 'myapp'
        DOCKER_PORT = '8081:8080'
        DOCKER_CMD = '/usr/bin/docker'  // Explicitly define full path to Docker
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
                sh 'pwd && ls -l' // Check the workspace directory
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
                ${DOCKER_CMD} build -t ${IMAGE_NAME} .
                
                # Stop and remove any existing container
                ${DOCKER_CMD} stop ${IMAGE_NAME} || true
                ${DOCKER_CMD} rm ${IMAGE_NAME} || true

                # Run the new container
                ${DOCKER_CMD} run -d --name ${IMAGE_NAME} -p ${DOCKER_PORT} ${IMAGE_NAME}
                '''
            }
        }
    }
}
