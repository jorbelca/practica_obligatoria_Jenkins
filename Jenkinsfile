pipeline {
    agent any
    tools {
        nodejs 'node 20'
    }
    parameters {
        string(name: 'Executor',defaultValue:'user' description: 'Nom de la persona que executa la pipeline')
        string(name: 'Motiu',defaultValue:'cap', description: 'Motiu per executar la pipeline')
        string(name: 'Chat_ID',defaultValue:'01234', description: 'ID del xat de Telegram per a notificacions')
    }
    stages {
        stage('Comprovar inputs') {
            steps {
                script {
                    sh ''' 
                    Executor: `${params.Executor}`\n
                    Motiu: `${params.Motiu}`\n
                    Chat ID: `${params.Chat_ID}`
                     '''
                }
            }
        }

        // stage('lint') {
        //     steps {
        //         sh '''
        //         npm install
        //         npm run lint
        //         '''
        //     }
        // }
    }      
}