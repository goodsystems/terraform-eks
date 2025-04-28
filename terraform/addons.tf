data "aws_iam_policy" "AmazonEBSCSIDriverPolicy" {
  name = "AmazonEBSCSIDriverPolicy"
}

resource "aws_iam_role" "CSIDriverRole" {
  name = "AmazonEKSPodIdentityAmazonEBSCSIDriverRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "pods.eks.amazonaws.com"
        },
        "Action" : [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "mazonEBSCSIDriverPolicyAttachment" {
  policy_arn = data.aws_iam_policy.AmazonEBSCSIDriverPolicy.arn
  role       = aws_iam_role.CSIDriverRole.name
}

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
      pod_identity_association = {
        role_arn        = aws_iam_role.CSIDriverRole.arn
        service_account = "example-sa"
      }
    }
  }
}
