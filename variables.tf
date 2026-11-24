variable "vpc_id" {
  description = "ID of the company-approved existing VPC"
  type        = string
}

variable "subnet_id" {
  description = "ID of the company-approved existing subnet"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket the EC2 role can access"
  type        = string
}