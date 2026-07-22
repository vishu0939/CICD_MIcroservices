# 🚀 Production-Ready CI/CD Microservices Deployment on AWS EKS

## 📌 Project Overview

This project demonstrates a complete production-ready CI/CD pipeline for deploying Dockerized microservices on Amazon EKS using Jenkins, Docker, Kubernetes, Terraform, Route 53, and AWS Load Balancer Controller.

---

## 🛠 Tech Stack

- AWS EC2
- Amazon EKS
- Terraform
- Docker
- Docker Hub
- Jenkins
- Kubernetes
- AWS Load Balancer Controller
- Route 53
- AWS Certificate Manager (ACM)
- Git & GitHub

---

## 📂 Project Structure

```
CICD_Microservices/
│
├── Jenkinsfile
│
├── microservices-eks/
│   ├── terraform/
│   └── kubernetes/
│
└── microservices-project/
    ├── frontend/
    ├── user-service/
    └── product-service/
```

---

## ⚙ Features

- Infrastructure Provisioning using Terraform
- Amazon EKS Cluster
- Dockerized Microservices
- Jenkins CI/CD Pipeline
- GitHub Webhook Integration
- Automatic Docker Image Build
- Automatic Docker Hub Push
- Kubernetes Deployment
- Rolling Updates
- AWS ALB Ingress
- Route 53 Custom Domain
- HTTPS using ACM SSL Certificate

---

## 🌐 Application URLs

Frontend

```
https://aide-v.xyz
```

User Service

```
https://aide-v.xyz/users
```

Product Service

```
https://aide-v.xyz/products
```

---

## 🚀 CI/CD Workflow

```
Developer
      │
      ▼
GitHub Push
      │
      ▼
GitHub Webhook
      │
      ▼
Jenkins Pipeline
      │
      ▼
Build Docker Images
      │
      ▼
Push Images to Docker Hub
      │
      ▼
Restart Kubernetes Deployments
      │
      ▼
Amazon EKS
      │
      ▼
Application Available via HTTPS
```

---

## 📜 Author

**Vishal**

GitHub:
https://github.com/vishu0939
