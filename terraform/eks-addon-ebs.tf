resource "aws_iam_role" "AmazonEBSCSIDriver" {
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

resource "aws_iam_role_policy_attachment" "AmazonEBSCSIDriver" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.AmazonEBSCSIDriver.name
}

resource "aws_eks_addon" "ebs" {
  cluster_name                = module.eks.cluster_name
  addon_name                  = "aws-ebs-csi-driver"
  resolve_conflicts_on_update = "OVERWRITE"
  pod_identity_association {
    role_arn        = aws_iam_role.AmazonEBSCSIDriver.arn
    service_account = "ebs-csi-controller-sa"
  }
}
