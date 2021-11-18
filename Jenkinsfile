pipeline {
    agent any
    environment{
        IMAGE_NAME='simongport/react-nodejs-example:1.4'
    }
    stages {
        stage("build image") {
            steps {
                script {
                    echo "building image"
                    sh "docker build -t ${env.IMAGE_NAME} ."
                }
            }
        }
         stage("push image to dockerhub") {
            steps {
                script {
                    echo "push image"
                    sh "docker push ${env.IMAGE_NAME}"
                }
            }
        }
        stage("deploy") {
            steps {
                script {
                    echo "deploy image"
                    def shellCmd="bash ./server-cmds.sh"
                    sshagent(['ec2-server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@54.89.35.30 ${shellCmd}"
                    }
                }
            }
        }
    }   
}