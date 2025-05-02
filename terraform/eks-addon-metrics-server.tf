resource "aws_eks_addon" "metrics_server" {
  cluster_name                = module.eks.cluster_name
  addon_name                  = "metrics-server"
  resolve_conflicts_on_update = "OVERWRITE"

}