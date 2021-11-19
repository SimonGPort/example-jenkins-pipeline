def gv
def gvUpdate

pipeline {
    agent any
    stages {
        stage("init") {
            steps{
                script{
                    gv=load "version.groovy"
                    gvUpdate=load "update-version.groovy"
                }
            }
        }

        stage("increment version") {
            steps {
                script {
                    def image_name_init='simongport/react-nodejs-example'
                    echo "increment version"

                    env.VERSION=gv.versionApp()
                    echo "${env.VERSION}"
                    // env.IMAGE_NAME='simongport/react-nodejs-example:2 .'
                    env.IMAGE_NAME="${image_name_init}:${env.VERSION} ."

                    echo "image-name to build: ${env.IMAGE_NAME}"
                    int actual_version_number = env.VERSION.toInteger()

                    int old_version_number=actual_version_number-1
                    String old_version = String.valueOf(old_version_number);
                    env.OLD_IMAGE_NAME="${image_name_init}:${old_version}"
                    echo "old version: ${env.OLD_IMAGE_NAME}"
                }
            }
        }

        // stage("build image") {
        //     steps {
        //         script {
        //             echo "building image"
        //             echo "docker build -t ${env.IMAGE_NAME}"
        //             sh "docker build -t ${env.IMAGE_NAME}"
        //         }
        //     }
        // }

        //  stage("push image to dockerhub") {
        //     steps {
        //         script {
        //             echo "push image"
        //             sh "docker push $IMAGE_NAME"
        //         }
        //     }
        // }

        // stage("deploy") {
        //     steps {
        //         script {
        //             echo "deploy image"
        //             def shellCmd="bash ./server-cmds.sh $IMAGE_NAME $OLD_IMAGE_NAME"
        //             sshagent(['ec2-server-key-2']) {
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

                    def versionContent=readFile('version.groovy')
                    int actual_version_number_update = env.VERSION.toInteger()
                    int next_version_number=actual_version_number_update+1
                    String new_version = String.valueOf(next_version_number);
                    def new_version_script=gvUpdate(new_version)
                    echo "new_version_script: ${new_version_script}"
                    // echo "next version: ${new_version}"

                    // versionContent=versionContent.replace(env.VERSION,new_version)

                    writeFile([file: 'version.groovy', text: new_version_script])
                    def version2=readFile('version.groovy')
                    echo "${version2}"


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