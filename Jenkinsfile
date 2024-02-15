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
                withCredentials([
                    sshUserPrivateKey(credentialsId: '54e6cd1d-d917-4427-ac13-6d7ff0abdc39', keyFileVariable: 'SSH_KEY'),
                    string(credentialsId: 'ansible_become_password', variable: 'ANSIBLE_BECOME_PASS')
                ]) {
                    sh 'ansible-playbook -u guobin -e "ansible_ssh_private_key_file=${SSH_KEY} artifact=target/hellojava-${GIT_COMMIT}.war ansible_become_password=${ANSIBLE_BECOME_PASS}" playbook.yml'" -i inventory.ini deploy.yml'
                }
            }
        }
    }
}
