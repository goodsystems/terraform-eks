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
  source  = "registry.opentofu.org/terraform-aws-modules/eks/aws"
  version = "v20.35.0"


  cluster_name    = "${var.environment_name}-eks-cluster"
  cluster_version = "1.32"

  access_entries = {
    developer = {
      principal_arn = "arn:aws:iam::711319931294:user/zuzana"

      policy_associations = {
        developer = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
          access_scope = {
            namespaces = ["default"]
            type       = "namespace"
          }
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
