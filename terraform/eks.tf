data "aws_caller_identity" "current" {}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "${var.TFSTATE_S3BUCKET_PREFIX}-${var.environment_name}-tofu-state"
    key    = "terraform-network/tofu.tfstate"
    region = "us-east-1"
  }
}

locals {
  tags = {
    Blueprint  = "${var.environment_name}-eks"
    GithubRepo = "github.com/aws-ia/terraform-aws-eks-blueprints"
  }
}




module "eks" {
  source  = "registry.terraform.io/terraform-aws-modules/eks/aws"
  version = "20.35.0"



  cluster_name                   = "${var.environment_name}-eks-cluster"
  cluster_version                = "1.32"
  cluster_endpoint_public_access = true
  # create_kms_key                 = false
  # cluster_encryption_config = {
  #     provider_key_arn = "arn:aws:kms:us-east-1:596979533546:key/0a2c4b5e-3f8d-4b7c-9f6d-0a2c4b5e3f8d"
  #     resources       = ["secrets"]
  #   }


  access_entries = {
    administrator = {
      principal_arn = "${var.principal_arn}"

      policy_association = {
        name   = "administrator"
        policy = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
        access_scope = {
          type = "cluster"
        }
      }
    }
  }

  vpc_id                   = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids               = data.terraform_remote_state.vpc.outputs.private_subnets_id
  control_plane_subnet_ids = data.terraform_remote_state.vpc.outputs.public_subnets_id

  eks_managed_node_groups = {
    initial = {
      instance_types = ["t3a.medium"]

      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }

  tags = local.tags
}