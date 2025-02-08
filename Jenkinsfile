pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/your-username/jenkins-ci-cd-demo.git'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: "${GIT_REPO}"
            }
        }

        stage('Build') {
            steps {
                echo 'Building the application...'
                sh 'mvn clean package' // Use 'npm install' for Node.js projects
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'mvn test' // Use 'npm test' for JavaScript projects
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                // Example for Docker deployment
                sh '''
                docker build -t myapp .
                docker run -d -p 8081:8080 myapp
                '''
            }
        }
    }
}
