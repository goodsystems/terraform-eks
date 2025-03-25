terraform {
  required_version = "~> 1.5.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.89.0"
    }
  }
}

# Provider definition
provider "aws" {
  region = var.region

  default_tags {
    tags = {
      "Environment_name" = var.environment_name,
      "Environment_slug" = var.environment_slug,
      "Project"          = var.project,
      "ManagedBy"        = "Terraform"
    }
  }
}
