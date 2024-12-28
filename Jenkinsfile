pipeline {
    agent any
    tools {
        nodejs 'node 20'
    }
    parameters {
        string(name: 'Executor',defaultValue:'user', description: 'Nom de la persona que executa la pipeline')
        string(name: 'Motiu',defaultValue:'cap', description: 'Motiu per executar la pipeline')
        string(name: 'Chat_ID',defaultValue:'01234', description: 'ID del xat de Telegram per a notificacions')
    }
    stages {
        stage('Install dependencies') {
            steps {
                script {
                    sh 'npm install'
                }
            }
        }
        stage('Lint') {
            steps {
                script{
                    def lintResult = sh(script: 'npm run lint', returnStatus: true)
                    env.ESLINT_RESULT = lintResult == 0 ? 'success' : 'failure'
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    def testResult = sh(script: 'npm test', returnStatus: true)
                    env.TEST_RESULT = testResult == 0 ? 'success' : 'failure'
                }
            }
        }
        stage('Update_Readme') {
            steps {
                script {
                    def update_readme = sh (script: "node jenkinsScripts/updateReadme.js ${env.TEST_RESULT}",returnStatus:true)
                    env.README_RESULT = update_readme == 0 ? 'success' : 'failure'
                }
            }
        }
           post {
                always{
                     withCredentials([gitUsernamePassword(credentialsId: 'b2343be2-2a1a-4059-baa4-2653be9343cc', gitToolName: 'Default')]) {
                        script {
                            sh """
                                ./jenkinsScripts/gitPush.sh '${params.Executor}' '${params.Motiu}'
                            """
                        }
                    }
                }
            }
        
        // stage("Push to Git Repository") {
        //     steps {
        //         withCredentials([gitUsernamePassword(credentialsId: 'b2343be2-2a1a-4059-baa4-2653be9343cc', gitToolName: 'Default')]) {
        //             sh """
        //                 # Asegurar-se que no hay conflictos al cambiar de rama
        //                 git add README.md
        //                 git commit -m 'Guardando cambios antes del checkout' || echo "Nada que commitear"
                        
        //                 # Cambiar a la rama ci_jenkins
        //                 git fetch origin
        //                 git checkout ci_jenkins || git checkout -b ci_jenkins
                        
        //                 # Actualizar cambios remotos
        //                 git pull origin ci_jenkins --rebase || echo "Nada que actualizar"
                        
        //                 # Confirmar y subir los cambios
        //                 git add README.md
        //                 git commit -m 'Pipeline executada per ${params.Executor}. Motiu: ${params.Motiu}' || echo "Nada que commitear"
        //                 git push -u origin ci_jenkins
        //                 """
        //         }
        //     }
        // }

        stage('Build') {
            steps {
                script {
                    sh 'npm run build'
                }
            }
        }
    
        stage('Deploy to Vercel') {
            when {
                allOf {
                    expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' } // Només si tot ha anat bé
                }
            }
            steps { 
                // Instalar el CLI de vercel en Jenkins
                script {
                    sh 'npm install -g vercel'
                }
                script {
                    // Executar l'script per desplegar a Vercel
                    withCredentials([string(credentialsId: 'vercel-token-id', variable: 'VERCEL_TOKEN')]) {
                        def deploy = sh (script: './jenkinsScripts/deployVercel.sh' ,returnStatus:true)
                        env.DEPLOY_RESULT = deploy == 0 ? 'success' : 'failure'
                    }
                }
            }
        }

        stage('Notification') {
                    steps { 
                        script {
                            // Executar l'script per notificar a Telegram
                            withCredentials([string(credentialsId: 'bot_token', variable: 'BOT_TOKEN')]) {
                                sh """
                                node ./jenkinsScripts/notification.js ${params.Chat_ID} \
                                ${env.ESLINT_RESULT} ${env.TEST_RESULT} ${env.README_RESULT} ${env.DEPLOY_RESULT}
                                """
                            }
                        }
                    }
                }
    
    }      
}