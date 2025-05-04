pipeline {
    agent any
    environment {
        FIREBASE_TOKEN = credentials('FIREBASE_TOKEN')
    }
    stages {
        // แก้ไข Checkout SCM ให้มีเพียงครั้งเดียว
        stage('Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']],
                    extensions: [],
                    userRemoteConfigs: [[url: 'https://github.com/your-repo.git']]
                ])
            }
        }

        stage('Install & Build') {
            steps {
                sh '''
                    npm install
                    npm run build
                '''
            }
        }

        stage('Test') {
            steps {
                sh 'npm test || true'  // ใช้ || true หากต้องการให้ Pipeline ต่อแม้ Test Fail
            }
        }

        stage('Deploy') {
            steps {
                sh 'firebase deploy --token $FIREBASE_TOKEN --non-interactive'
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'dist/**/*'  // สร้าง artifacts จากไฟล์ build
            cleanWs()  // ล้าง workspace
        }
    }
}