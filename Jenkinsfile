pipeline {
    agent any
    environnement{
        DOCKERHUB_USERNAME='simongport'
        DOCKERHUB_PASSWORD='a11otoiq!'
    }
    stages {
        stage("build image") {
            steps {
                script {
                    def imageName='simongport/react-nodejs-example:1.0'
                    echo "building image"
                    sh "docker build -t ${imageName} ."
                    sh "docker login -u ${env.DOCKERHUB_USERNAME} -p ${env.DOCKERHUB_PASSWORD}"
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