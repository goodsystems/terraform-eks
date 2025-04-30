resource "aws_eks_addon" "prometheus_node_exporter" {
  cluster_name                = module.eks.cluster_name
  addon_name                  = "prometheus-node-exporter"
  resolve_conflicts_on_update = "OVERWRITE"

}