pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/Rohan-Dighe/jenkins-ci-cd-demo.git'
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning repository...'
                git branch: 'main', url: "${GIT_REPO}"
            }
        }

        stage('Build') {
            steps {
                echo 'Building the application...'

                // Check the current directory and list files
                sh 'pwd'
                sh 'ls -l'

                // Change to the 'my-app' directory and run Maven there
                dir('my-app') {  // Adjust if your folder name differs
                    sh 'mvn clean package'
                }
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                dir('my-app') {
                    sh 'mvn test'
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                dir('my-app') {
                    sh '''
                    docker build -t myapp .
                    docker run -d -p 8081:8080 myapp
                    '''
                }
            }
        }
    }
}
