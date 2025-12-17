Step - 8 : Install AWS CLI in JENKINS Server
URL : https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

Execute below commands to install AWS CLI

sudo apt install unzip 
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version
Step - 9 : Install Kubectl in JENKINS Server
Execute below commands in Jenkins server to install kubectl

curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin
kubectl version --short --client
Step - 10 : Update EKS Cluster Config File in Jenkins Server
Execute below command in Eks Management host & copy kube config file data
$ cat .kube/config

Execute below commands in Jenkins Server and paste kube config file
$ cd /var/lib/jenkins
$ sudo mkdir .kube
$ sudo vi .kube/config

Execute below commands in Jenkins Server and paste kube config file for ubuntu user to check EKS Cluster info

 aws eks update-kubeconfig --region ap-south-1 --name <your-eks-cluster-name>
check eks nodes
$ kubectl get nodes
Note: We should be able to see EKS cluster nodes here.

Step - 11 : Create Jenkins CI CD Job
Stage-1 : Clone Git Repo
Stage-2 : Maven Build
Stage-3 : Create Docker Image
Stage-4 : Push Docker Image to Registry
Stage-5 : Deploy app in k8s eks cluster
pipeline {
    agent any
    
    tools{
        maven "Maven-3.9.9"
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/ashokitschool/maven-web-app.git'
            }
        }
        stage('Maven Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Docker Image') {
            steps {
                sh 'docker build -t ashokit/mavenwebapp .'
            }
        }
        stage('k8s deployment') {
            steps {
                sh 'kubectl apply -f k8s-deploy.yml'
            }
        }
    }
}

Step - 12 : Access Application in Browser
We should be able to access our application
URL : http://LBR/context-path/
We are done with our Setup
