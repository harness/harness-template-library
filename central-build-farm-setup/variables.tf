# Variable Management Details
variable "build_infrastructure_type" {
  type        = string
  description = "Select the Build infrastructure types to support - internal, cloud, or both"
  default     = "internal"

  validation {
    condition = (
      contains(["internal", "cloud", "both"], lower(var.build_infrastructure_type))
    )
    error_message = <<EOF
        Validation of Build Infrastructure Type Failed.
            * Must be one of the following:
            - internal
            - cloud
            - both
        EOF
  }
}

variable "container_registry_type" {
  type        = string
  description = "What type of Container Registry Connector type will be used as the default Build Farm Registry"
  default     = "docker"

  validation {
    condition = (
      contains(["docker", "artifactory", "aws"], lower(var.container_registry_type))
    )
    error_message = <<EOF
        Validation of Container Registry Type Failed.
            * Must be one of the following:
            - docker
            - artifactory
            - aws
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

variable "delegate_selectors" {
  type        = list(string)
  description = "Delegate selectors"
  default     = ["build-farm"]
}

# AWS Connectors
variable "region" {
  type        = string
  description = "[Optional] Choose the default AWS Region"
  default     = "us-east-1"
}

variable "authentication_type_self_hosted" {
  type        = string
  description = "[Optional] Choose the authentication type for the Self-Hosted Connectors"
  default     = "manual"
}

variable "authentication_type_harness_cloud" {
  type        = string
  description = "[Optional] Choose the authentication type for the Harness Cloiud Connectors"
  default     = "manual"
}

variable "iam_role_arn" {
  type        = string
  description = "[Optional] The IAM Role to assume the credentials from"
  default     = null
}
