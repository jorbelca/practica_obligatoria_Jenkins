pipeline {
    agent any
    tools {
        nodejs 'node 20'
    }
    parameters {
        string(name: 'Executor', description: 'Nom de la persona que executa la pipeline')
        string(name: 'Motiu', description: 'Motiu per executar la pipeline')
        string(name: 'Chat_ID', description: 'ID del xat de Telegram per a notificacions')
    }
    stages {
        stage('Petició de dades') {
            steps {
                input message: 'Proporcioneu les dades necessàries:',
                    parameters: [
                        string(name: 'Executor', description: 'Nom de la persona que executa la pipeline'),
                        string(name: 'Motiu', description: 'Motiu per executar la pipeline'),
                        string(name: 'Chat_ID', description: 'ID del xat de Telegram per a notificacions')
                    ]
            }
        }
        stage('Comprovar inputs') {
            steps {
                script {
                    echo "Executor: ${params.Executor}"
                    echo "Motiu: ${params.Motiu}"
                    echo "Chat ID: ${params.Chat_ID}"
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