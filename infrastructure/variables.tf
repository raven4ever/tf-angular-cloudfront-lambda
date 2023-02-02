variable "vpc_id" {
  description = "VPC ID where the Neptune Cluster will be deployed"
  type        = string
  default     = ""
}

variable "website_bucket_name" {
  description = "Name of the bucket where the Angular content is stored"
  type        = string
  default     = "000-books-angular-site-999"
}

variable "frontend_artefacts_location" {
  description = "Path to frontend application artefacts"
  type        = string
  default     = "../frontend/dist/frontend"
}

variable "api_stage_path" {
  description = "Stage path to access the backend"
  type        = string
  default     = "books"
}

variable "api_stage_name" {
  description = "Name of the API GW stage"
  type        = string
  default     = "prod"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function to be created"
  type        = string
  default     = "books-backend-lambda"
}

variable "lambda_role_name" {
  description = "Name of the role to be used to put logs into CloudWatch"
  type        = string
  default     = "lambda-backend-role"
}

variable "lambda_role_boundary" {
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
