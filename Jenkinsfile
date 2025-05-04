pipeline {
    agent any

    environment {
        FIREBASE_TOKEN = credentials('FIREBASE_TOKEN')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Johart2546/Jenkins.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build Project') {
            steps {
                sh 'npm run build' // สำหรับ Vite จะสร้างไฟล์ใน /dist
            }
        }

        stage('Deploy to Firebase') {
            steps {
                sh 'firebase deploy --token $FIREBASE_TOKEN --non-interactive'
            }
        }
    }

    post {
        success {
            slackSend(
                channel: '#your-channel',
                message: "Deploy สำเร็จ: ${env.BUILD_URL}\nHosting URL: https://jenkins-2xd8.web.app"
            )
        }
        failure {
            slackSend(
                channel: '#your-channel',
                message: "Deploy ล้มเหลว: ${env.BUILD_URL}"
            )
        }
    }
}