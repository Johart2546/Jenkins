pipeline {
    agent any
    
    options {
        timeout(time: 15, unit: 'MINUTES')
        retry(2)
    }

    environment {
        FIREBASE_TOKEN = credentials('FIREBASE_TOKEN')
        PROJECT_URL = 'https://jenkins-2xd8.web.app'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                url: 'https://github.com/Johart2546/Jenkins.git',
                credentialsId: 'FIREBASE_TOKEN'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm ci'
            }
        }

        stage('Build Project') {
            steps {
                sh 'npm run build'
                archiveArtifacts artifacts: 'dist/**/*', fingerprint: true
            }
        }

        stage('Verify Build') {
            steps {
                script {
                    if (!fileExists('dist/index.html')) {
                        error("Build ล้มเหลว - ไม่พบไฟล์ index.html!")
                    }
                }
            }
        }

        stage('Deploy to Firebase') {
            steps {
                sh 'firebase deploy --token $FIREBASE_TOKEN --non-interactive --only hosting'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            slackSend(
                channel: '#deploy-notifications',
                color: 'good',
                message: """
                ✅ Deploy สำเร็จ!
                Project: ${env.JOB_NAME} #${env.BUILD_NUMBER}
                Hosting URL: ${PROJECT_URL}
                Console: ${env.BUILD_URL}
                """
            )
        }
        failure {
            slackSend(
                channel: '#deploy-notifications',
                color: 'danger',
                message: """
                ❌ Deploy ล้มเหลว!
                Project: ${env.JOB_NAME} #${env.BUILD_NUMBER}
                Console: ${env.BUILD_URL}
                """
            )
        }
    }
}