pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'availability-tracker'
    }

    stages {
        stage('Clone Code') {
            steps {
                git 'https://github.com/YOUR_USERNAME/YOUR_REPO.git'
            }
        }

        stage('Lint Code') {
            steps {
                sh 'npx eslint . || true'
            }
        }

        stage('Check Formatting') {
            steps {
                sh 'npx prettier --check . || true'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Run Docker Compose') {
            steps {
                sh 'docker compose down || true'
                sh 'docker compose up -d --build'
            }
        }
    }
}
