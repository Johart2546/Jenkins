pipeline {
    agent any

    environment {
        FIREBASE_TOKEN = credentials('FIREBASE_TOKEN')
        PATH = "/usr/local/bin:/usr/bin:/bin:/usr/local/nodejs/bin"  
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    try {
                        sh 'npm install'
                    } catch (err) {
                        error("❌ npm install ล้มเหลว: ${err.message}")
                    }
                }
            }
        }

        stage('Build Project') {
            steps {
                sh 'npm run build'
                script {
                    if (!fileExists('dist/index.html')) {
                        error('❌ Build ล้มเหลว: ไม่พบไฟล์ dist/index.html')
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