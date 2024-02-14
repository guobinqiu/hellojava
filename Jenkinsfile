pipeline {
    agent any
    tools {
        maven 'mvn_3.9.6'
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
                sh "mv target/hellojava.war target/hellojava-${GIT_COMMIT}.war"
            }
        }
    }
}
