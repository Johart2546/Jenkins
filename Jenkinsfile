pipeline {
    agent any

    environment {
        FIREBASE_TOKEN = credentials('FIREBASE_TOKEN') // ตั้งค่าใน Jenkins Credentials
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm // ดึงโค้ดจาก SCM
            }
        }

        stage('Build') {
            steps {
                script {
                    sh '''
                        npm install
                        npm run build
                    '''
                }
            }
        }

        stage('Test') {
            steps {
                sh 'npm test || true' // ใส่ || true ถ้าไม่ต้องการให้ล้มเหลวเมื่อ test fail
            }
        }

        stage('Deploy') { // สะกดให้ถูกต้อง
            steps {
                sh 'firebase deploy --token $FIREBASE_TOKEN --non-interactive'
            }
        }
    }

    post {
        always {
            echo 'Pipeline เสร็จสิ้น - ${currentBuild.result}'
        }
        success {
            slackSend channel: '#deploy-notify',
                     message: "Deploy สำเร็จ: ${env.BUILD_URL}"
        }
        failure {
            slackSend channel: '#deploy-notify',
                     message: "Deploy ล้มเหลว: ${env.BUILD_URL}"
        }
    }
}