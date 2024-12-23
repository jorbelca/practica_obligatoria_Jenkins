pipeline {
    agent any
    tools {
        nodejs 'node 20'
    }
    stages {
        stage('Petició de dades') {
            steps {
                script {
                    // Captura els valors de l'etapa input
                    env.Params = input message: 'Proporcioneu les dades necessàries:',
                        parameters: [
                            string(name: 'Executor', description: 'Nom de la persona que executa la pipeline'),
                            string(name: 'Motiu', description: 'Motiu per executar la pipeline'),
                            string(name: 'Chat ID', description: 'ID del xat de Telegram per a notificacions')
                        ]
                }
            }
        }
        stage('Comprovar inputs') {
            steps {
                sh '''
                echo "Executor: $Parms.Executor"
                echo "Motiu: $Parms.Motiu"
                echo "Chat ID: $Parms.Chat_ID"
                '''
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