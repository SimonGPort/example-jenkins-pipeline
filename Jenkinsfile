pipeline {
    agent any
    stages {
          stage("increment version") {
            steps {
                script {
                    def image_name_init='simongport/react-nodejs-example'
                    echo "increment version"
                    def version=readFile('version.sh')
                    env.IMAGE_NAME="${image_name_init}:${version}"
                    echo "${env.IMAGE_NAME}"
                    double version_number = Double.parseDouble(version);
                    version_number=version_number+0.1
                    String new_version = String.valueOf(version_number);
                    echo "${version_number}"

                    String currentDir = new File(".").getAbsolutePath()
                    echo"${currentDir}"

                    writeFile([file: 'version.sh', text: new_version])
                    // File new_version_file = new File ('version.sh')
                    // new_version_file.write(new_version)

                    def version2=readFile('version.sh')
                    echo "${version2}"
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