pipeline {
    agent any
    
    tools{
        maven 'Maven'
    }
    stages {
        stage('clone') {
            steps {
              git 'https://github.com/musabsyd/maven-webapp.git'
            }
        }
        stage('build'){
            steps{
                 sh 'mvn clean package'
            }
        }
        stage('docker image'){
            steps {
                sh 'docker build -t musabsyed/mavenwebapp .'
            }
        }
        stage('k8s deploy'){
            steps{
               sh 'kubectl apply -f k8s-deploy.yml'
            }
        }
    }
}

