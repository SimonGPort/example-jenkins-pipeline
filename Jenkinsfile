pipeline {
    agent any
    environment{
        IMAGE_NAME=''
    }
    stages {
          stage("increment version") {
            steps {
                script {
                    def image_name_init='simongport/react-nodejs-example'
                    echo "increment version"
                    def version=readFile('version.sh')
                    echo "ici:${version}"
                    env.IMAGE_NAME="test"
                    echo "${env.IMAGE_NAME}"
                }
            }
        }
        // stage("build image") {
        //     steps {
        //         script {
        //             echo "building image"
        //             sh "docker build -t ${env.IMAGE_NAME} ."
        //         }
        //     }
        // }
        //  stage("push image to dockerhub") {
        //     steps {
        //         script {
        //             echo "push image"
        //             sh "docker push ${env.IMAGE_NAME}"
        //         }
        //     }
        // }
        // stage("deploy") {
        //     steps {
        //         script {
        //             echo "deploy image"
        //             def shellCmd="bash ./server-cmds.sh"
        //             sshagent(['ec2-server-key']) {
        //                 sh "scp server-cmds.sh ec2-user@54.89.35.30:/home/ec2-user"
        //                 sh "ssh -o StrictHostKeyChecking=no ec2-user@54.89.35.30 ${shellCmd}"
        //             }
        //         }
        //     }
        // }
    }   
}