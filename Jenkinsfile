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
        // stage('Comprovar inputs') {
        //     steps {
        //         script {
        //             sh """
        //             echo "Executor: ${params.Executor}"
        //             echo "Motiu: ${params.Motiu}"
        //             echo "Chat ID: ${params.Chat_ID}"
        //             """
        //         }
        //     }
        // }
        stage('Install dependencies') {
            steps {
                script {
                    sh '''
                    npm install
                    '''
                }
            }
        }
        stage('Lint') {
            steps {
                sh '''
                npm run lint
                '''
            }
        }
        stage('Test') {
            steps {
                script {
                    sh '''
                    def testResult = sh(script: 'npm test', returnStatus: true)
                    env.TEST_RESULT = testResult == 0 ? 'success' : 'failure'
                    '''
                }
            }
        }
        stage('Update_Readme') {
            steps {
                script {
                    // Llama al script pasando el resultado de los test como argumento
                    sh """
                    node jenkinsScripts/updateReadme.js ${env.TEST_RESULT}
                    """
                }
            }
        }
    
    }      
}