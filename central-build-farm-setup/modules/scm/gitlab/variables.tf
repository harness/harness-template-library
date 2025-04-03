variable "source_code_manager_url" {
  type        = string
  description = "URL of the GitLab repository or account"
}

variable "source_code_manager_connection_type" {
  type        = string
  description = "GitLab connection type: Account or Repo"
  default     = "Account"
}

variable "source_code_manager_validation_repo" {
  type        = string
  description = "[Optional] Repository to test the connection with"
  default     = null
}

variable "source_code_manager_auth_type" {
  type        = string
  description = "Authentication type for GitLab: http, ssh"
}

variable "scm_username" {
  type        = string
  description = "Please provide the ID of the SCM Connector Credentials - Username"
}

variable "scm_password" {
  type        = string
  description = "Please provide the ID of the SCM Connector Credentials - Password"
}

variable "scm_ssh_key" {
  type        = string
  description = "Please provide the ID of the SCM Connector Credentials - SSH-KEY"
  default     = null
}

variable "enable_api_authentication" {
  type        = bool
  description = "Enable API authentication using the provided password/token"
  default     = true
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
  description = "List of delegate selectors to use for the connector"
  default     = ["build-farm"]
}

variable "tags" {
  type        = map(any)
  description = "[Optional] Provide a Map of Tags to associate with the resources"
  default     = {}
}
