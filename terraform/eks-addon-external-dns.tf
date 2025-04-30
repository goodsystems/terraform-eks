resource "aws_iam_role" "external_dns" {
  name = "AmazonEKSPodIdentityExternalDNSRole"
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

resource "aws_iam_role_policy_attachment" "external_dns" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
  role       = aws_iam_role.external_dns.name
}

resource "aws_eks_addon" "external_dns" {
  cluster_name                = module.eks.cluster_name
  addon_name                  = "external-dns"
  resolve_conflicts_on_update = "OVERWRITE"
  pod_identity_association {
    role_arn        = aws_iam_role.external_dns.arn
    service_account = "external-dns"
  }
}
