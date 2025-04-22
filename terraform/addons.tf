module "eks-blueprints-addons" {
  source  = "registry.opentofu.org/aws-ia/eks-blueprints-addons/aws"
  version = "v1.21.0"

  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = module.eks.cluster_endpoint
  cluster_version   = module.eks.cluster_version
  oidc_provider_arn = module.eks.oidc_provider_arn

  eks_addons = {
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }
}
