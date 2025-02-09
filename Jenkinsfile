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

                // Check the current directory and list files
                sh 'pwd'
                sh 'ls -l'

                // Run Maven Build
                sh '''
                if [ -f "mvnw" ]; then
                    chmod +x mvnw
                    ./mvnw clean package
                else
                    mvn clean package
                fi
                '''
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                sh '''
                if [ -f "mvnw" ]; then
                    ./mvnw test
                else
                    mvn test
                fi
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'

                // Check if Docker is installed
                sh '''
                if ! command -v docker &> /dev/null
                then
                    echo "Error: Docker is not installed or not in PATH"
                    exit 1
                fi
                '''

                // Build and Run Docker Container
                sh '''
                docker build -t ${IMAGE_NAME} .
                docker stop ${IMAGE_NAME} || true
                docker rm ${IMAGE_NAME} || true
                docker run -d --name ${IMAGE_NAME} -p ${DOCKER_PORT} ${IMAGE_NAME}
                '''
            }
        }
    }
}
