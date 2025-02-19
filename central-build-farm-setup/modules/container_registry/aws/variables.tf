variable "tags" {
  type        = map(any)
  description = "[Optional] Provide a Map of Tags to associate with the resources"
  default     = {}
}

variable "support_self_hosted" {
  type        = bool
  description = "Should Self-Hosted Build Infrastructures connectors be added?"
  default     = true
}

variable "support_harness_cloud" {
  type        = bool
  description = "Should Harness Cloud Build Infrastructures connectors be added?"
  default     = false
}

variable "delegate_selectors" {
  type        = list(string)
  description = "Delegate selectors"
  default     = ["build-farm"]
}

variable "container_registry_username" {
  type        = string
  description = "Please provide the ID of the ContainerRegistry Connector Credentials - Username"
  default     = null
}

variable "container_registry_password" {
  type        = string
  description = "Please provide the ID of the ContainerRegistry Connector Credentials - Password"
  default     = null
}

# Connector Specific
variable "region" {
  type        = string
  description = "[Optional] Choose the default AWS Region"
  default     = "us-east-1"
}

variable "authentication_type_self_hosted" {
  type        = string
  description = "[Optional] Choose the authentication type for the connectors"
  default     = "manual"
}

variable "authentication_type_harness_cloud" {
  type        = string
  description = "[Optional] Choose the authentication type for the connectors"
  default     = "manual"
}

variable "iam_role_arn" {
  type        = string
  description = "[Optional] The IAM Role to assume the credentials from"
  default     = null
}

variable "cross_account_role_arn" {
  type        = string
  description = "[Optional] The Amazon Resource Name (ARN) of the role that you want to assume. This is an IAM role in the target AWS account."
  default     = null
}

variable "cross_account_external_id" {
  type        = string
  description = "[Optional] If the administrator of the account to which the role belongs provided you with an external ID, then enter that value."
  default     = null
}
