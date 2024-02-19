pipeline {
    agent any
    tools {
        maven 'mvn_3.9.6'
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package' //清理+打包
                sh "mv target/hellojava.war target/hellojava-${GIT_COMMIT}.war" //重命名包名
                archiveArtifacts artifacts: "target/hellojava-${GIT_COMMIT}.war", fingerprint: true //加入本地制品库
            }
        }
        stage('Static Analysis') {
            //https://docs.sonarsource.com/sonarqube/latest/setup-and-upgrade/install-the-server/introduction/
            //https://docs.sonarsource.com/sonarqube/latest/analyzing-source-code/scanners/sonarscanner/
            steps {
                //安装SonarQube Scanner插件 >> 全局工具配置 > SonarQube Scanner 安装 > Name, SONAR_RUNNER_HOME
                tool name: 'sonarqube_scanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'

                //系统管理 >> SonarQube servers > Name, Server URL, Server authentication token
                withSonarQubeEnv('sonarqube_server') {// 从Jenkins配置中获取SonarQube服务器的URL和身份验证令牌
                    sh 'sonar-scanner'
                }
            }
        }
        stage('Deploy with Ansible') {
            steps {
                withCredentials([
                    sshUserPrivateKey(credentialsId: '54e6cd1d-d917-4427-ac13-6d7ff0abdc39', keyFileVariable: 'SSH_KEY'),
                    string(credentialsId: '563e5a99-0d79-4b2d-a2e8-0061db54fbf5', variable: 'ANSIBLE_BECOME_PASS')
                ]) {
                    sh '''
                        ansible-playbook \
                        -u guobin \
                        -e "ansible_ssh_private_key_file=${SSH_KEY}" \
                        -e "artifact=../target/hellojava-${GIT_COMMIT}.war" \
                        -e "ansible_become_password=${ANSIBLE_BECOME_PASS}" \
                        -i ansible/inventory.ini \
                        ansible/deploy.yml
                    '''
                }
            }
        }
    }
}
