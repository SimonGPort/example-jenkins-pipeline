pipeline {
    agent any
    stages {
          stage("increment version") {
            steps {
                script {
                    def image_name_init='simongport/react-nodejs-example'
                    echo "increment version"

                    def version=readFile('version.txt')
                    // env.IMAGE_NAME='simongport/react-nodejs-example:2 .'
                    env.IMAGE_NAME="${image_name_init}:${version} ."

                    echo "image-name to build: ${IMAGE_NAME}"
                    int actual_version_number = version.toInteger()

                    int next_version_number=actual_version_number+1
                    String new_version = String.valueOf(next_version_number);
                    echo "next version: ${new_version}"

                    int old_version_number=actual_version_number-1
                    String old_version = String.valueOf(old_version_number);
                    env.OLD_IMAGE_NAME="${image_name_init}:${old_version}"
                    echo "old version: ${OLD_IMAGE_NAME}"

                    writeFile([file: 'version.txt', text: new_version])
                    def version2=readFile('version.txt')
                }
            }
        }

        stage("build image") {
            steps {
                script {
                    echo "building image"
                    echo "docker build -t ${IMAGE_NAME}"
                    sh "docker build -t ${IMAGE_NAME}"
                }
            }
        }

         stage("push image to dockerhub") {
            steps {
                script {
                    echo "push image"
                    sh "docker push $IMAGE_NAME"
                }
            }
        }

        stage("deploy") {
            steps {
                script {
                    echo "deploy image"
                    def shellCmd="bash ./server-cmds.sh $IMAGE_NAME $OLD_IMAGE_NAME"
                    sshagent(['ec2-server-key-2']) {
                        sh "scp server-cmds.sh ec2-user@54.89.35.30:/home/ec2-user"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@54.89.35.30 ${shellCmd}"
                    }
                }
            }
        }

        stage("commit version update") {
            steps {
                script {
                    echo "commit version update"
                    withCredentials([usernamePassword(credentialsId: 'github-id-access-token',passwordVariable:'PASS', usernameVariable:'USER')]){
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