# EKS Terraform Module Setup

This repository provides Terraform configurations to set up an Amazon EKS (Elastic Kubernetes Service) cluster, integrate it with Karpenter for automatic scaling, and optionally use Fargate for serverless Kubernetes workloads.

## Components
- **EKS Cluster**: Manages the Kubernetes cluster, including VPC setup, subnets, node groups, and add-ons like `kube-proxy` and `vpc-cni`.
- **Karpenter**: Auto-scaling solution that automatically provisions and scales EC2 nodes based on the workloads in the cluster.
- **Fargate (Optional)**: Serverless compute engine for running Kubernetes pods without managing EC2 instances. Configurable via a variable (`use_fargate`).
- **Helm**: Deploys Karpenter to the cluster using Helm charts.
- **Security Groups & IAM Roles**: Defines security groups and roles for EKS worker nodes and Karpenter.

## Setup Instructions

### 1. **Configure Terraform Providers:**
   - **AWS provider**: For creating resources in your AWS account.
   - **Kubernetes provider**: To manage Kubernetes resources.
   - **Helm provider**: For deploying Helm charts to the EKS cluster.
   - **Kubectl provider**: For interacting with Kubernetes via `kubectl`.

### 2. **EKS Cluster Configuration:**
   - The cluster will be deployed using the `terraform-aws-modules/eks/aws` module.
   - It includes public access to the Kubernetes API endpoint and enables Karpenter for scaling.

### 3. **Karpenter Setup:**
   - Karpenter will be deployed to manage the EC2 node scaling.
   - A custom IAM role is created for Karpenter to manage EC2 instances.

### 4. **Fargate (Optional):**
   - If `use_fargate` is set to `true`, the cluster will use AWS Fargate profiles for serverless workloads. Otherwise, EKS managed node groups will be used.

## Usage

### 1. **Variables:**
   - `kubernetes_version`: Version of Kubernetes to deploy (default: 1.31).
   - `aws_region`: AWS region to deploy resources (default: `us-east-1`).
   - `use_fargate`: Set to `true` to use Fargate instead of EKS Managed Node Groups (default: `false`).

### 2. **Terraform Configuration:**
   - Run `terraform init` to initialize the Terraform workspace.
   - Run `terraform apply` to create the resources in AWS.

## Outputs:
- **cluster_id**: The EKS cluster ID.
- **cluster_endpoint**: Endpoint for accessing the EKS control plane.
- **cluster_security_group_id**: Security group IDs attached to the cluster.
- **region**: AWS region where the resources are deployed.
- **oidc_provider_arn**: OIDC provider ARN for the EKS cluster.

## Files in the Repository

- **`eks.tf`**: Main Terraform configuration for deploying the EKS cluster, Karpenter, and related resources.
- **`locals.tf`**: Local variables used in the configuration.
- **`main.tf`**: Defines Terraform providers and modules.
- **`output.tf`**: Specifies output values to be displayed after deployment.
- **`securitygroup.tf`**: Defines security groups for the worker nodes.
- **`variables.tf`**: Defines input variables for the configuration.
- **`vpc.tf`**: Configures VPC, subnets, and NAT gateway.

## Requirements
- Terraform >= 0.12
- AWS CLI installed and configured
- kubectl for interacting with the EKS cluster

## Notes
- Ensure your AWS credentials are set up before running `terraform apply`.
- Modify the `use_fargate` variable if you prefer Fargate instead of managed node groups.
