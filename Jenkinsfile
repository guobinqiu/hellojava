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
        stage('Deploy with Ansible') {
            steps {
                sh 'ansible-playbook -u guobin -e "ansible_ssh_private_key_file=$SSH_KEY,artifact=/var/lib/jenkins/workspace/hellojava/target/hellojava-${GIT_COMMIT}.war" /etc/ansible/hellojava.yml'
            }
        }
    }
}
