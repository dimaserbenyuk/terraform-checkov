terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.6.0"
    }
  }
  # backend "s3" {
  #   profile        = "dmytro"
  #   bucket         = "aws-terraform-states-adonce"
  #   key            = "terraform.tfstate"
  #   region         = "eu-central-1"
  #   dynamodb_table = "aws-terraform-states-adonce-lock"
  #   encrypt        = true
  # }
}

# Configure the AWS Provider
provider "aws" {
  access_key = "dedwdwdw"
  secret_key = "dedwefdwed"

}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.adonce-test.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.adonce-test.certificate_authority[0].data)
  # token                  = data.aws_eks_cluster_auth.default.token

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.adonce-test.id]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.adonce-test.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.adonce-test.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.adonce-test.id]
      command     = "aws"
    }
  }
}