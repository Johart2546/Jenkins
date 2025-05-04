pipeline {
    agent any

    environment {
        FIREBASE_TOKEN = credentials('FIREBASE_TOKEN')
        PATH = "/usr/local/bin:/usr/bin:/bin:/usr/local/nodejs/bin:$PATH"  // เพิ่ม path ของ npm
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    echo "PATH: $PATH"  // สำหรับ debug
                    which npm         // ตรวจสอบ path ของ npm
                    npm install
                '''
            }
        }

        stage('Build Project') {
            steps {
                sh 'npm run build'
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