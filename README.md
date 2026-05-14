**🚀 DevOps CI/CD + Terraform + Docker + Kubernetes Project
📌 Project Overview**
This project demonstrates a complete DevOps workflow including:
Infrastructure provisioning using Terraform (AWS EC2)
Application containerization using Docker
Deployment on Kubernetes (k3s cluster on EC2)
Simple Flask application
Git-based version control (GitHub)

The goal of this project is to simulate a real-world CI/CD pipeline + cloud deployment workflow using AWS and open-source DevOps tools.

**🏗️ Architecture Flow**
Developer → GitHub → Terraform → AWS EC2 → Docker → Kubernetes (k3s) → Application Running

**🧰 Technologies Used**
AWS EC2 (Cloud Infrastructure)
Terraform (Infrastructure as Code)
Docker (Containerization)
Kubernetes (k3s lightweight cluster)
Flask (Python Web Application)
Git & GitHub (Version Control)
Amazon Linux 2023

**📁 Project Structure**
CI_CD_May26/
│
├── Terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── .gitignore
│
├── app/
│   ├── app.py
│   ├── requirements.txt
│   ├── Dockerfile
│
└── README.md

**⚙️ Step 1: Infrastructure Setup (Terraform)**

Terraform is used to automatically create AWS infrastructure.

**🔹 Resources Created:**
EC2 Instance (Amazon Linux 2023)
Security Group (SSH + HTTP access)
Key Pair for SSH access
**▶️ Commands:**
cd Terraform
terraform init
terraform plan
terraform apply
**☁️ Step 2: AWS EC2 Setup**

**After Terraform execution:**

EC2 instance is created
Public IP is generated
SSH access enabled using .pem key
🔗 Connect to server:
ssh -i devops-key.pem ec2-user@<EC2-PUBLIC-IP>

**🐳 Step 3: Docker Setup (Application Containerization)**

A simple Flask application is containerized using Docker.

📄 app.py
from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "DevOps CI/CD Pipeline Working!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
    
**📄 requirements.txt**
flask

**📄 Dockerfile**
FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "app.py"]

▶️ Build Docker Image
docker build -t flask-app .
▶️ Run Container
docker run -d -p 5000:5000 flask-app

**☸️ Step 4: Kubernetes (k3s) Setup**

k3s (lightweight Kubernetes) is installed on EC2.

▶️ Check cluster:
sudo k3s kubectl get nodes

Expected output:
Ready    control-plane

▶️ Deploy application (optional enhancement)

Deploy Docker container in Kubernetes using YAML:

apiVersion: apps/v1
kind: Deployment
metadata:
  name: flask-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: flask-app
  template:
    metadata:
      labels:
        app: flask-app
    spec:
      containers:
      - name: flask-app
        image: flask-app
        ports:
        - containerPort: 5000
        
**🔐 Security Best Practices**
.terraform/ folder excluded using .gitignore
No AWS keys stored in GitHub
Sensitive files like .tfstate are ignored
SSH key used for secure EC2 access

**🚨 Issues Faced & Fixes**
❌ Issue 1: Terraform push failed (large files)
Cause: .terraform providers > 800MB
Fix: Added .gitignore and removed history
❌ Issue 2: Docker build failed
Cause: Incorrect Flask requirement (flask~)
Fix: Corrected to flask
❌ Issue 3: Kubernetes not starting
Fix: Restarted k3s service and verified cluster

**🎯 Key Learnings**
Terraform best practices for AWS provisioning
Importance of .gitignore in DevOps projects
Docker containerization workflow
Kubernetes cluster setup using k3s
Debugging cloud + CI/CD issues
Git history cleanup techniques

**🚀 Future Improvements**
CI/CD pipeline using GitHub Actions or Jenkins
Terraform remote backend 
Prometheus + Grafana monitoring
Load balancing using Nginx ingress
Multi-environment setup (Dev / Prod)

**👨‍💻 Author **

DevOps Engineer Portfolio Project by Ambedkar Rani Subbiah

**Built for learning:**

Cloud Infrastructure (AWS)
CI/CD Automation
Kubernetes Deployment
Real-world DevOps workflows

**⭐ Result**

✔ Infrastructure created using Terraform
✔ Application containerized using Docker
✔ Deployed on Kubernetes (k3s)
✔ Clean GitHub repository
✔ End-to-end DevOps pipeline simulated
