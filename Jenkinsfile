pipeline {
    agent any
    
    // ตั้งค่าให้ Jenkins ตรวจสอบการเปลี่ยนแปลงทุก 1 นาที (Fallback หาก Webhook ล้มเหลว)
    triggers { pollSCM('H/1 * * * *') } 

    environment {
        FIREBASE_TOKEN = credentials('FIREBASE_TOKEN') // ต้องตั้งค่าใน Jenkins ด้วย
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']],
                    extensions: [],
                    userRemoteConfigs: [[
                        url: 'https://github.com/Johart2546/Jenkins.git',
                        credentialsId: 'FIREBASE_TOKEN' // ต้องตั้งค่าใน Jenkins ด้วย
                    ]]
                ])
            }
        }

        stage('Install & Build') {
            steps {
                sh '''
                    npm install
                    npm run build
                '''
                // ตรวจสอบว่ามีไฟล์ Build จริง
                script {
                    if (!fileExists('dist/index.html')) {
                        error('Build Failed: dist/index.html not found!')
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

    post {
        success {
            slackSend(
                channel: '#deploy-notify',
                message: "✅ Deploy สำเร็จ!\nURL: https://your-project.web.app"
            )
        }
        failure {
            slackSend(
                channel: '#deploy-notify',
                message: "❌ Deploy ล้มเหลว!\nดู Log: ${env.BUILD_URL}"
            )
        }
    }
}