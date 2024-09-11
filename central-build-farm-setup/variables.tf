# Variable Management Details

## Harness Account Provider Connection Details
variable "harness_platform_url" {
  type        = string
  description = "[Optional] Enter the Harness Platform URL.  Defaults to Harness SaaS URL"
  default     = "https://app.harness.io/gateway"
}

variable "harness_platform_account" {
  type        = string
  description = "[Required] Enter the Harness Platform Account Number"
  default     = null # If Not passed, then the ENV HARNESS_ACCOUNT_ID will be used
  sensitive   = true
}

variable "harness_platform_key" {
  type        = string
  description = "[Required] Enter the Harness Platform API Key for your account"
  default     = null # If Not passed, then the ENV HARNESS_PLATFORM_API_KEY will be used
  sensitive   = true
}

variable "use_self_hosted" {
  type        = bool
  description = "Configure a Kubernetes Connector for use as a Centralized Build Farm"
  default     = true
}

variable "container_registry_type" {
  type        = string
  description = "What type of Container Registry Connector type will be used as the default Build Farm Registry"
  default     = "docker"

  validation {
    condition = (
      contains(["docker", "artifactory"], lower(var.container_registry_type))
    )
    error_message = <<EOF
        Validation of Container Registry Type Failed.
            * Must be one of the following:
            - docker
            - artifactory
        EOF
  }
}

variable "container_registry_url" {
  type        = string
  description = "Provide the URL to which the Container Registry connector will connect"
  default     = "https://index.docker.io/v2/"
}

variable "source_code_manager_type" {
  type        = string
  description = "What type of Source Code Manager Connector type will be used as the default Build Farm SCM"
  default     = "github"

  validation {
    condition = (
      contains(["github", "bitbucket"], lower(var.source_code_manager_type))
    )
    error_message = <<EOF
        Validation of Source Code Manager Type Failed.
            * Must be one of the following:
            - github
            - bitbucket
        EOF
  }
}

variable "source_code_manager_url" {
  type        = string
  description = "Please provide the default URL for the Connector - e.g. https://github.com"
}

variable "source_code_manager_validation_repo" {
  type        = string
  description = "Please provide the validation URL for the Connector - e.g. harness/terraform-provider-harness"
}
