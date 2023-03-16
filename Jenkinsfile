pipeline {
    agent {  
        docker {
            image 'maven:3.8.3-jdk-11-slim'
            args '-v $HOME/.m2:/root/.m2'
        }
    }
    stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }

        stage ('Build') {
            steps {
                sh 'mvn -Dmaven.test.failure.ignore=true install' 
            }
            post {
                success {
                    junit 'target/surefire-reports/**/*.xml' 
                }
            }
        }

        stage ('Fortify merge') {
            steps {
                echo "In the fortify merge"
            }
        }
    }
}
