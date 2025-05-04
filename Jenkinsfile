pipeline {
    agent any

    environment {
        FIREBASE_TOKEN = credentials('FIREBASE_TOKEN')
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'  // ใช้ npm ไม่ใช่ rpm
            }
        }

        stage('Build Project') {
            steps {
                sh 'npm run build'
                // ตรวจสอบว่า build สำเร็จ
                script {
                    if (!fileExists('dist/index.html')) {
                        error('Build failed: dist/index.html not found!')
                    }
                }
            }
        }

        stage('Deploy to Firebase') {
            steps {
                sh 'firebase deploy --token $FIREBASE_TOKEN --non-interactive'
            }
        }
    }
}