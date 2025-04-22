variable "region" {
  default     = "us-east-1"
  description = "Default region"
  type        = string
}

variable "environment_name" {
  description = "Default environment name"
  type        = string
}

variable "environment_slug" {
  description = "Default environment slug"
  type        = string
}

variable "project" {
  description = "Default project name"
  type        = string
}

variable "TFSTATE_S3BUCKET_PREFIX" {
  description = "Default s3 bucket prefix"
  default     = "goodsystems"
  type        = string
}

variable "principal_arn" {
  description = "The arn of the principal to be used for access"
  type        = string
}