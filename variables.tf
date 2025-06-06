variable "kubernetes_version" {
  default     = 1.31
  description = "kubernetes version"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "default CIDR range of the VPC"
}

variable "aws_region" {
  default = "us-east-1"
  description = "aws region"
}

variable "use_fargate" {
  description = "Whether to use Fargate instead of EKS Managed Node Groups"
  type        = bool
  default     = false  # Set to false to use Managed Node Groups
}


