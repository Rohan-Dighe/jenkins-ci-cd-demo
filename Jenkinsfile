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
                // Check the current directory and list the files to ensure we're in the correct directory
                sh 'pwd'  // Print the current working directory
                sh 'ls -l' // List files to ensure the presence of the pom.xml

                // If pom.xml is in a subfolder (for example, 'my-app'), use the 'dir' block to navigate there
                // Change 'my-app' to the actual folder name if necessary
                dir('my-app') {  // Replace 'my-app' with the correct subfolder, if needed
                    sh 'mvn clean package'
                }
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                dir('my-app') {  // Again, adjust if necessary
                    sh 'mvn test'
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                // Example for Docker deployment
                dir('my-app') {  // Adjust if necessary
                    sh '''
                    docker build -t myapp .
                    docker run -d -p 8081:8080 myapp
                    '''
                }
            }
        }
    }
}
