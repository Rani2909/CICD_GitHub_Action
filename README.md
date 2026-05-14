📌 DevOps CI/CD Pipeline Project (Docker + Kubernetes + Terraform + AWS)
🚀 Project Overview

This project demonstrates a complete DevOps CI/CD pipeline using modern tools like Terraform, AWS EC2, Docker, and Kubernetes (K3s).

It automates infrastructure provisioning, application containerization, and deployment of a simple Python Flask application.

🏗️ Architecture Flow
Developer → GitHub → CI/CD (Jenkins/GitHub Actions)
        → Docker Image Build
        → Push to EC2 Server
        → Kubernetes (K3s) Deployment
        → Application Running on Browser

⚙️ Technologies Used
AWS EC2 (Cloud Infrastructure)
Terraform (Infrastructure as Code)
Linux (Amazon Linux 2023)
Docker (Containerization)
Kubernetes (K3s lightweight cluster)
Python Flask (Application)
Git & GitHub (Version Control)

📁 Project Structure
CI_CD_Project/
│
├── Terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│
├── app/
│   ├── app.py
│   ├── requirements.txt
│   ├── Dockerfile
│
├── kubernetes/
│   ├── deployment.yaml
│   ├── service.yaml
│
└── README.md

☁️ Step 1: Infrastructure Provisioning (Terraform)

Terraform is used to create AWS infrastructure automatically.

Features:
EC2 instance creation
Security group configuration
Key pair generation
Run Commands:
cd Terraform
terraform init
terraform plan
terraform apply

🖥️ Step 2: Connect to EC2
ssh -i devops-key.pem ec2-user@<PUBLIC_IP>

🐳 Step 3: Install Docker
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
newgrp docker

Verify:

docker --version

☸️ Step 4: Install Kubernetes (K3s)
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable traefik" sh -

Check cluster:

sudo k3s kubectl get nodes

🐍 Step 5: Flask Application
app.py
from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "DevOps CI/CD Pipeline Working!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
📦 requirements.txt
flask

🐳 Step 6: Dockerfile
FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

CMD ["python", "app.py"]

🔨 Step 7: Build & Run Docker Image
docker build -t flask-app .
docker run -d -p 5000:5000 flask-app

Test:

curl localhost:5000

☸️ Step 8: Kubernetes Deployment (K3s)
deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: flask-app
spec:
  replicas: 2
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
service.yaml
apiVersion: v1
kind: Service
metadata:
  name: flask-service
spec:
  type: NodePort
  selector:
    app: flask-app
  ports:
    - port: 5000
      targetPort: 5000
      nodePort: 30007

🚀 Deploy to Kubernetes
sudo k3s kubectl apply -f deployment.yaml
sudo k3s kubectl apply -f service.yaml

Check pods:
sudo k3s kubectl get pods

🌐 Access Application
http://<EC2_PUBLIC_IP>:30007

📊 Future Improvements
CI/CD automation using Jenkins
Docker image push to AWS ECR
Prometheus + Grafana monitoring
Helm charts for deployment
Multi-node Kubernetes cluster


⭐ Conclusion
This project demonstrates:
Infrastructure as Code (Terraform)
Containerization (Docker)
Orchestration (Kubernetes K3s)
Cloud deployment (AWS EC2)
End-to-end DevOps workflow
