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
                withCredentials([sshUserPrivateKey(credentialsId: '54e6cd1d-d917-4427-ac13-6d7ff0abdc39', keyFileVariable: 'SSH_KEY')]) {
                    //sh 'ansible-playbook -u guobin -e "ansible_ssh_private_key_file=$SSH_KEY" /etc/ansible/test.yml'
                    //sh 'ansible-playbook -u guobin -e "ansible_ssh_private_key_file=${SSH_KEY} artifact=/var/lib/jenkins/workspace/hellojava/target/hellojava-${GIT_COMMIT}.war" -i /etc/ansible/hosts /etc/ansible/hellojava.yml'
                    sh 'ansible-playbook -u guobin -e "ansible_ssh_private_key_file=${SSH_KEY} artifact=/var/lib/jenkins/workspace/hellojava/target/hellojava-${GIT_COMMIT}.war" -i inventory.ini deploy.yml'
                }
            }
        }
    }
}
