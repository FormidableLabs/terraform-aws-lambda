variable "s3_bucket" {
  description = <<EOF
  The S3 bucket location containing the function's deployment package. Conflicts with filename and image_uri. 
  This bucket must reside in the same AWS region where you are creating the Lambda function.
  EOF
  default     = null
  type        = string
}

variable "s3_key" {
  description = "The S3 key of an object containing the function's deployment package. Conflicts with filename and image_uri."
  default     = null
  type        = string
}

variable "filename" {
  description = "The path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options and image_uri cannot be used."
  default     = null
  type        = string
}

variable "handler" {
  description = "(Required) Path to the code entrypoint."
  type        = string
}

variable "log_retention_in_days" {
  description = "Log retention in number of days."
  type        = number
  default     = 14
}

variable "memory_size" {
  description = "Amount of memory to allocate to the lambda function."
  type        = number
  default     = 2048
}

variable "namespace" {
  description = "Namespacing for multiple environments in a single stage"
  default     = ""
}

variable "publish" {
  description = "Enable versioning for this lambda"
  default     = false
}

variable "service" {
  description = "(Required) Name of the service"
  type        = string
}

variable "stage" {
  description = "(Required) Stage name (eg. development, staging, production)"
  type        = string
}

variable "policies" {
  description = "Additional IAM policies to attach to the lambda's IAM role."
  type        = list(any)
  default     = []
}

variable "runtime" {
  description = "Runtime the lambda function should use."
  type        = string
  default     = "nodejs14.x"
}

variable "tags" {
  description = "Additional tags to apply to the log group."
  type        = map(any)
  default     = {}
}

variable "timeout" {
  description = "Value for the max number of seconds the lambda function will run."
  type        = number
  default     = 20
}

variable "variables" {
  description = "Map of environment variables to set on the lambda."
  type        = map(any)
  default     = {}
}
