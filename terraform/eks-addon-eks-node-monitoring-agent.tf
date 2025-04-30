resource "aws_eks_addon" "eks_node_monitoring_agent" {
  cluster_name                = module.eks.cluster_name
  addon_name                  = "eks-node-monitoring-agent"
  resolve_conflicts_on_update = "OVERWRITE"

}