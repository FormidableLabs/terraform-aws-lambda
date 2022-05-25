variable "artifact_bucket" {
  description = "(Required) S3 bucket containing lambda artifacts"
  type        = string
}

variable "artifact_key" {
  description = "(Required) S3 key of the lambda artifact to deploy."
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
