output "cluster_name" {
  value       = module.eks.cluster_id
  description = "The name of the EKS cluster"
}

output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "The endpoint of the EKS cluster"
}
output "cluster_version" {
  value       = module.eks.cluster_version
  description = "The version of the EKS cluster"
}
output "oidc_provider_arn" {
  value       = module.eks.cluster_oidc_issuer_url
  description = "The OIDC provider ARN for the EKS cluster"
}
output "cluster_certificate_authority_data" {
  value       = module.eks.cluster_certificate_authority_data
  description = "The certificate authority data for the EKS cluster"
}