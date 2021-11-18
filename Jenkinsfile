pipeline {
    agent any
    stages {
        // stage("build image") {
        //     steps {
        //         script {
        //             def imageName='simongport/react-nodejs-example:1.0'
        //             echo "building image"
        //             sh "docker build -t ${imageName}"
        //             sh "docker push ${imageName}"
        //         }
        //     }
        // }
        stage("deploy") {
            steps {
                script {
                    echo "deploy image"
                    def containerName='jenkinspipeline'
                    def dockerCmd='docker run -p 3080:3080 -d simongport/react-nodejs-example:1.0'
                    sshagent(['ec2-server-key']) {
                        sh "docker stop ${containerName}"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@3.87.167.25 ${dockerCmd}"
                    }
                }
            }
        }
    }   
}