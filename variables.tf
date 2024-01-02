data "aws_caller_identity" "current" {}

variable "env" {
  type        = string
  description = "Value to use as a suffix in resource names and provide uniquness. E.g. 'dev', 'prod', 'test', etc."

  validation {
    condition     = can(regex("[[:alnum:]]", var.env))
    error_message = "The short_id can contain only alphanumeric chars."
  }
}

variable "name" {
  type        = string
  description = "Name of the project"
}

variable "ecr_image_url" {
  type        = string
  description = "(Optional) docker image URL"
  default     = null
}

variable "subnets" {
  type        = set(string)
  description = "(optional) Subnets where Lambda function will be set ('subnet-xxxxxxxx')"
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "(optional) VPC ID"
}

variable "security_groups" {
  type        = list(string)
  description = "(optional) Security groups where Lambda function will be set ('sg-xxxxxxxx')"
  default     = []
}

variable "lambda_memory_size" {
  type        = number
  default     = 128
  description = "Memory size for Lambda functions"
}

variable "lambda_timeout" {
  type        = number
  default     = 6
  description = "Timeout for Lambda functions"
}

variable "lambda_environment_variables" {
  type        = map(any)
  description = "(optional) Environment variables for Lambda functions"
  default     = null
}

variable "extra_policy_statements" {
  type        = list(any)
  default     = []
  description = "Additional policy statements to be added to the Lambda execution policy."
}

variable "override_command" {
  type        = string
  description = "override CMD command od the docker image"
  default     = null
}

variable "override_directory" {
  type        = string
  description = "override WORKDIR command od the docker image"
  default     = null
}
