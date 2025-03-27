variable "region" {
  default     = "us-east-1"
  description = "default region"
}

variable "environment_name" {
  description = "default environment type"
}

variable "environment_slug" {
  description = "default environment slug"
}

variable "project" {
  description = "default project name"
}

variable "TFSTATE_S3BUCKET_PREFIX" {
  description = "default s3 bucket prefix"
  default     = "goodsystems"

}