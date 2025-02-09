pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/Rohan-Dighe/jenkins-ci-cd-demo.git'
        IMAGE_NAME = 'myapp'
        DOCKER_PORT = '8081:8080'
        DOCKER_CMD = '/usr/bin/docker' // Explicitly define full path to Docker (if needed)
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
                sh 'pwd && ls -l' // Check the workspace directory (for debugging)
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

                script {
                    def projectDir = findProjectDir() // Find the project directory

                    sh """
                        cd "${projectDir}"  // <--- Change to project directory
                        pwd                 // Verify the current directory
                        ls -l             // Verify the contents of the directory
                        ${DOCKER_CMD} build -t ${IMAGE_NAME} .
                        ${DOCKER_CMD} stop ${IMAGE_NAME} || true
                        ${DOCKER_CMD} rm ${IMAGE_NAME} || true
                        ${DOCKER_CMD} run -d --name ${IMAGE_NAME} -p ${DOCKER_PORT} ${IMAGE_NAME}
                    """
                }
            }
        }
    }
}


// Helper function to find the project directory.  This is a more robust approach
// in case the cloned repository is in a subdirectory.
def findProjectDir() {
    def possibleDirs = findFiles('pom.xml').collect { it.getParent() }
    if (possibleDirs.size() == 1) {
        return possibleDirs[0]
    } else if (possibleDirs.size() > 1) {
        // Handle cases where you might have multiple pom.xml files (submodules, etc.)
        echo "Warning: Multiple pom.xml files found.  Using the first one: ${possibleDirs[0]}"
        return possibleDirs[0]
    } else {
        error("No pom.xml file found.  Cannot determine project directory.")
    }
}
