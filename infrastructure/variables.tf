variable "s3_bucket_name" {
  description = "Name of the bucket where the content is stored"
  type        = string
  default     = "000-super-important-content-999"
}

variable "frontend_artefacts_location" {
  description = "Path to frontend application artefacts"
  type        = string
  default     = "../frontend/dist/frontend"
}

variable "put_cw_role_name" {
  description = "Name of the role to be used to put logs into CloudWatch"
  type        = string
  default     = "lambda-role"
}

variable "put_cw_role_boundary" {
  description = "Name of the boundary (if applicable) to be applied to the CloudWatch role"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to be applied to all created resources"
  type        = map(string)
  default = {
    CreatedBy = "Terraform"
  }
}
