pipeline {
    agent any
    tools {
        maven 'mvn_3.9.6'
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
}
