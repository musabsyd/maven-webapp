---

# 🚀 Jenkins CI/CD with AWS EKS – Installation & Pipeline Setup

---

## 🔹 Step 8: Install AWS CLI on Jenkins Server

📌 **Official AWS Documentation**
👉 [https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

### 🧰 Execute the Following Commands

```bash
sudo apt install unzip -y
```

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```

```bash
unzip awscliv2.zip
```

```bash
sudo ./aws/install
```

### ✅ Verify AWS CLI Installation

```bash
aws --version
```

---

## 🔹 Step 9: Install kubectl on Jenkins Server

### 🧰 Execute the Following Commands

```bash
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
```

```bash
chmod +x ./kubectl
```

```bash
sudo mv ./kubectl /usr/local/bin
```

### ✅ Verify kubectl Installation

```bash
kubectl version --short --client
```

---

## 🔹 Step 10: Update EKS Cluster Config File on Jenkins Server

### 🖥️ From EKS Management Host

Copy the kubeconfig file:

```bash
cat ~/.kube/config
```

---

### 🖥️ On Jenkins Server (for Jenkins user)

```bash
cd /var/lib/jenkins
```

```bash
sudo mkdir .kube
```

```bash
sudo vi .kube/config
```

📌 **Paste the copied kubeconfig content here**

---

### 🖥️ Update kubeconfig for Ubuntu User (Optional Check)

```bash
aws eks update-kubeconfig --region ap-south-1 --name <your-eks-cluster-name>
```

### ✅ Verify EKS Cluster Connectivity

```bash
kubectl get nodes
```

📌 **Note:**
You should be able to see the EKS worker nodes listed here.

---

## 🔹 Step 11: Create Jenkins CI/CD Pipeline Job

### 🧩 Pipeline Stages

* **Stage 1:** Clone Git Repository
* **Stage 2:** Maven Build
* **Stage 3:** Create Docker Image
* **Stage 4:** Push Docker Image to Registry
* **Stage 5:** Deploy Application to EKS (Kubernetes)

---

## 📄 Jenkins Declarative Pipeline (`Jenkinsfile`)

```groovy
pipeline {
    agent any

    tools {
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
                sh 'docker build -t musabsyed/mavenwebapp .'
            }
        }

        stage('k8s deployment') {
            steps {
                sh 'kubectl apply -f k8s-deploy.yml'
            }
        }
    }
}
```

---

## ✅ Final Outcome

✔ AWS CLI Installed
✔ kubectl Installed
✔ Jenkins Connected to EKS
✔ CI/CD Pipeline Deploying App to Kubernetes

---
Here’s **Step 12** added in the **same GitHub-ready Markdown style**, clean and professional 👌
You can append this directly to your existing `README.md`.

---

## 🔹 Step 12: Access Application in Browser

After successful deployment to the **EKS cluster**, the application should be accessible via the **Load Balancer URL**.

### 🌐 Application Access URL

```text
http://<LOAD-BALANCER-DNS>/<context-path>/
```

📌 **Example:**

```text
http://a1b2c3d4e5f6.elb.amazonaws.com/mavenwebapp/
```

---

### 🔍 How to Get Load Balancer URL

Run the following command on the Jenkins server or EKS management host:

```bash
kubectl get svc
```

Look for the **EXTERNAL-IP** of the service of type `LoadBalancer`.

---

### ✅ Verification Checklist

✔ Application deployed successfully
✔ Kubernetes service is running
✔ Load Balancer is created
✔ Application opens in browser

---

## 🎉 Setup Completed Successfully!

You have successfully implemented:

* Jenkins CI/CD Pipeline
* Maven Build Automation
* Docker Image Creation
* Deployment to AWS EKS
* Application Access via Load Balancer

🚀 **End-to-End CI/CD with Jenkins + Docker + Kubernetes (EKS) is DONE!**

---

