data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "${var.TFSTATE_S3BUCKET_PREFIX}-${var.environment_name}-terraform-state"
    key    = "terraform-network/terraform.tfstate"
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
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.11"

  cluster_name    = "${var.environment_name}-eks-cluster"
  cluster_version = "1.30"

  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets_id

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
