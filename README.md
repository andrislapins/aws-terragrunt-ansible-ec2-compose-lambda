[![whoami CI pipeline](https://github.com/andrislapins/aws-terragrunt-ansible-ec2-compose-lambda/actions/workflows/ci.yml/badge.svg)](https://github.com/andrislapins/aws-terragrunt-ansible-ec2-compose-lambda/actions/workflows/ci.yml)

# aws-terragrunt-ansible-ec2-compose-lambda

The project involves provisioning an AWS server with a custom domain and deploying a web application using various AWS services and DevOps tools. The infrastructure is defined using Terraform and configured with Ansible. The application is containerized using Docker and managed with Docker Compose. Traefik is used as a reverse proxy, and monitoring is set up with Grafana and Prometheus. CI/CD pipelines are implemented using GitHub Actions to automate testing and deployment processes.

## Project Overview

The main objectives of this project were:

- Provision an AWS EC2 instance.
- Set up a custom domain using AWS Route53.
- Deploy a web application using Docker and Docker Compose.
- Implement monitoring and logging with Grafana and Prometheus.
- Automate infrastructure provisioning with Terraform and Ansible.
- Set up CI/CD pipelines using GitHub Actions for [traefik/whoami](https://github.com/traefik/whoami)

## Technologies Used

The following technologies and services were utilized in this project:

- **AWS Services**:
  - AWS EC2
  - AWS S3
  - AWS Lambda
  - AWS SNS
  - AWS SSM
  - AWS CloudWatch

- **Load balancing and DNS**
  - Traefik
  - Cloudflare

- **Infrastructure as Code**:
  - Terragrunt
  - Terraform
  - Ansible

- **Containerization and Orchestration**:
  - Docker Compose

- **Monitoring and Logging**:
  - Grafana
  - Prometheus

- **CI/CD**:
  - GitHub Actions