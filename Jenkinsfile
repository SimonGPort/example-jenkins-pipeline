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
                    echo "image-name to build: ${env.IMAGE_NAME}"
                    double version_number = Double.parseDouble(version);
                    version_number=version_number+0.1
                    String new_version = String.valueOf(version_number);
                    echo "next version: ${new_version}"

                    old_version=version_number-0.1
                    String old_version = String.valueOf(old_version);
                    env.OLD_IMAGE_NAME="${image_name_init}:${old_version}"
                    echo "old version: ${env.OLD_IMAGE_NAME}"

                    writeFile([file: 'version.sh', text: new_version])
                    def version2=readFile('version.sh')
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
        stage("commit version update") {
            steps {
                script {
                    echo "commit version update"
                    withCredentials([usernamePassword(credentialsId: 'github-id',passwordVariable:'PASS', usernameVariable:'USER')]){
                        sh 'git config user.email "simon.giroux.portelance@gmail.com"'
                        sh 'git config user.name "jenkins"'

                        sh 'git status'
                        sh 'git branch'
                        sh 'git config --list'
                        
                        sh "git remote set-url origin https://${USER}:${PASS}@github.com/SimonGPort/example-jenkins-pipeline.git"
                        sh 'git add .'
                        sh 'git commit -m "ci: version bump"'
                        sh 'git push origin HEAD:master'

                    }
                }
            }
        }
    }   
}