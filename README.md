# Multi-AZ Dockerized WordPress on AWS (Terraform)

![Terraform](https://img.shields.io/badge/Terraform-IaC-7B42BC?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange?logo=amazonaws)
![Docker](https://img.shields.io/badge/Docker-Containers-2496ED?logo=docker)
![WordPress](https://img.shields.io/badge/WordPress-CMS-21759B?logo=wordpress)
![Status](https://img.shields.io/badge/Status-Production--ready-green)

<img src="/images/Terraform_project.drawio.png"></img>

---

## Overview

This project provisions a **highly available, production-style WordPress environment on AWS** using Terraform.  
It solves a common real-world problem: running WordPress in a way that is **fault-tolerant, secure, repeatable, and easy to manage**, without relying on manual setup or single-instance deployments.

The infrastructure is fully defined as code, deployed across **multiple Availability Zones**, and designed to reflect patterns commonly used in real production environments.

---

## High-level architecture

- **Terraform remote state** stored securely in S3
- **Custom VPC** with public and private subnets across two AZs
- **Application Load Balancer (ALB)** with HTTP → HTTPS redirection
- **Two EC2 instances** (one per AZ) running Dockerized WordPress
- **Amazon RDS (MySQL)** in private subnets
- **ACM-managed TLS certificates**
- **Route 53** for DNS and domain management
- **Strict security groups** following least-privilege principles

This setup ensures that no single instance failure takes the site down.

---

## What makes this project strong (from a recruiter’s perspective)

### 1. Clear separation of concerns with Terraform modules
Each major component lives in its own module:
- `vpc` – networking, subnets, routing, NAT gateways
- `sg` – security groups and traffic boundaries
- `alb` – load balancer, listeners, target groups
- `ec2` – compute and Docker bootstrap
- `rds` – managed database layer
- `acm` & `route53` – HTTPS and DNS

This makes the codebase **readable, testable, and easy to extend**, instead of a single monolithic Terraform file.

---

### 2. Multi-AZ design for resilience
- EC2 instances are spread across **two Availability Zones**
- ALB performs health checks and routes traffic only to healthy targets
- RDS is isolated in **private subnets**, inaccessible from the internet

If one AZ or instance fails, traffic continues to flow.

---

### 3. Dockerized application layer
WordPress runs inside Docker containers on EC2:
- Predictable, repeatable runtime
- Faster recovery and redeployment
- Clean separation between OS and application

Docker is installed and configured automatically using **cloud-init**, removing manual steps entirely.

---

### 4. Security-first decisions
- No database access from the internet
- RDS only accepts traffic from EC2 security group
- SSH access restricted to a single trusted IP
- HTTPS enforced at the ALB level with ACM certificates
- Public exposure limited strictly to the ALB

This mirrors how real production workloads are locked down.

---

### 5. Remote state and locking
Terraform state is stored in **S3 with encryption enabled**, ensuring:
- Safe collaboration
- State durability
- Reduced risk of accidental corruption

---

## Business and real-world benefits

- **Reliability**: Multi-AZ design minimizes downtime
- **Scalability**: Additional EC2 instances can be added behind the ALB
- **Security**: Clear network boundaries and least-privilege access
- **Cost control**: Uses small instance sizes and managed services
- **Maintainability**: Modular Terraform code makes changes low-risk
- **Repeatability**: Entire environment can be recreated from scratch

This is the kind of setup suitable for a small production workload, internal tool, or client project.

---

## Screenshots

<img src="/images/wordpressBlog.png"></img>

---

## How to use (high level)

1. Configure AWS credentials locally
2. Create a `terraform.tfvars` file with sensitive values (not committed)
3. Initialize Terraform:
   ```bash
   terraform init
4. Review the plan:
    ```bash
   terraform plan
5. Apply:
    ```bash
   terraform apply
After deployment, WordPress is accessible via the configured domain name.

---

## Future improvements

- Move EC2 instances to an Auto Scaling Group
- Add RDS Multi-AZ for database-level failover
- Store secrets in AWS Secrets Manager
- Add CloudWatch alarms and logs
- Introduce a CI/CD pipeline for Terraform validation
- Replace EC2 with ECS or EKS for container orchestration

---


## Final notes

This project focuses on clarity, correctness, and real-world patterns, not shortcuts.
It demonstrates how to design and deploy a secure, scalable WordPress stack using modern infrastructure practices.

Feel free to explore, adapt, or extend it.