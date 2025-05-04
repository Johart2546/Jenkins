pipeline {
    agent any

    environment {
        FIREBASE_TOKEN = credentials('FIREBASE_TOKEN') // ต้องตั้งค่า credential ใน Jenkins ก่อน
    }

    stages {
        stage('Clone') {
            steps {
                echo 'Cloning repo...'
                git branch: 'main', 
                url: 'https://github.com/Johart2546/Jenkins.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building project...'
                sh 'npm install'
                sh 'npm run build' // สำหรับ Vite/React
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'npm test' // ถ้ามี test script
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying to Firebase...'
                sh 'firebase deploy --token $FIREBASE_TOKEN --non-interactive'
            }
        }
    }

    post {
        success {
            echo 'Deploy สำเร็จ!'
            // สามารถเพิ่ม slack notification หรือ email ได้ที่นี่
        }
        failure {
            echo 'Deploy ล้มเหลว!'
        }
    }
}