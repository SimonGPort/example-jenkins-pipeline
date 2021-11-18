pipeline {
    agent any
    stages {
        stage("build image") {
            steps {
                script {
                    def imageName='simongport/react-nodejs-example:1.1'
                    echo "building image"
                    sh "docker build -t ${imageName} ."
                    sh "docker push ${imageName}"
                }
            }
        }
        stage("deploy") {
            steps {
                script {
                    echo "deploy image"
                    def shellCmd="bash ./server-cmds.sh"
                    sshagent(['ec2-server-key']) {
                        sh "scp server-cmds.sh ec2-user@3.87.167.25:/home/ec2-user"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@3.87.167.25 ${shellCmd}"
                    }
                }
            }
        }
    }   
}