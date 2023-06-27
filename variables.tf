variable "server_side_encryption" {
  description = "Specifies server-side encryption of the object in S3. Valid values are \"AES256\" and \"aws:kms\"."
  type        = string
  default     = null
}

variable "region" {
  type        = string
  description = "AWS region for deploy"
  default     = "eu-central-1"
}

variable "tags" {
  description = "Tags for resource"
  type        = map(string)
  default     = { Project = "Yeew", Terraform = "true" }
}

variable "server_side_encryption_configuration" {
  description = "Map containing server-side encryption configuration."
  type        = any
  default     = {}
}