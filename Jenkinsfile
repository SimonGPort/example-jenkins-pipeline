pipeline {
    agent any
    stages {
        stage("build image") {
            steps {
                script {
                    echo "building image"
                }
            }
        }
        stage("deploy") {
            steps {
                script {
                    def dockerCmd='docker run -p 3080:3080 -d simongport/react-nodejs-example:1.0'
                    sshagent(['ec2-server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@3.87.167.25 ${dockerCmd}"
                    }
                }
            }
        }
    }   
}