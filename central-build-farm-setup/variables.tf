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
      contains(["docker", "aws", "gcp", "azure"], lower(var.container_registry_type))
    )
    error_message = <<EOF
        Validation of Container Registry Type Failed.
            * Must be one of the following:
            - docker
            - aws
            - gcp
            - azure
        EOF
  }
}

variable "container_registry_provider_type" {
  type        = string
  description = "Choose a Generic Container Registry Type"
  default     = "DockerHub"

  validation {
    condition = (
      contains(["DockerHub", "Harbor", "Quay", "Other"], var.container_registry_provider_type)
    )
    error_message = <<EOF
        Validation of Generic Container Registry Type Failed.
            * Must be one of the following:
            - DockerHub
            - Harbor
            - Quay
            - Other
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
      contains(["github", "bitbucket", "gitlab"], lower(var.source_code_manager_type))
    )
    error_message = <<EOF
        Validation of Source Code Manager Type Failed.
            * Must be one of the following:
            - github
            - bitbucket
            - gitlab
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
variable "source_code_manager_auth_type" {
  type        = string
  description = "[Optional] Choose the authentication type for the SCM Connectors"
  default     = "http"
}
variable "artifact_manager_type" {
  type        = string
  description = "What type of Artifact Manager Connector type will be used as the default Build Farm Registry"
  default     = "nexus"

  validation {
    condition = (
      contains(["nexus", "artifactory", "oci_helm", "http_helm"], lower(var.artifact_manager_type))
    )
    error_message = <<EOF
        Validation of Container Registry Type Failed.
            * Must be one of the following:
            - nexus
            - artifactory
            - oci_helm
            - http_helm
        EOF
  }
}
variable "artifact_manager_url" {
  type        = string
  description = "Please provide the default URL for the Connector - e.g. https://mycompany.jfrog.io/module_name/."
  default     = "skipped"
}
variable "artifact_manager_auth_type" {
  type        = string
  description = "Choose the authentication type for the Artifact Manager Connectors. Allowed values: 'UsernamePassword', 'Anonymous'"
  default     = "Anonymous"

  validation {
    condition     = contains(["UsernamePassword", "Anonymous"], var.artifact_manager_auth_type)
    error_message = "Invalid authentication type. Allowed values are 'UsernamePassword' or 'Anonymous'."
  }
}
variable "nexus_version" {
  type        = string
  description = "Choose the Nexus Version for Nexus Connectors. Allowed values: '2.x', '3.x'"
  default     = "2.x"
  validation {
    condition     = contains(["2.x", "3.x"], var.nexus_version)
    error_message = "Invalid Nexus version. Allowed values are '2.x' or '3.x'."
  }
}
variable "delegate_selectors" {
  type        = list(string)
  description = "Delegate selectors"
  default     = ["build-farm"]
}

variable "authentication_type_self_hosted" {
  type        = string
  description = "[Optional] Choose the authentication type for the Self-Hosted Connectors"
  default     = "manual"
}

variable "authentication_type_harness_cloud" {
  type        = string
  description = "[Optional] Choose the authentication type for the Harness Cloud Connectors"
  default     = "manual"
}

# AWS Connectors
variable "region" {
  type        = string
  description = "[Optional] Choose the default AWS Region"
  default     = "us-east-1"
}

variable "iam_role_arn" {
  type        = string
  description = "[Optional] The IAM Role to assume the credentials from"
  default     = null
}

variable "aws_cross_account_role_arn" {
  type        = string
  description = "[Optional] The Amazon Resource Name (ARN) of the role that you want to assume. This is an IAM role in the target AWS account."
  default     = null
}

variable "aws_cross_account_external_id" {
  type        = string
  description = "[Optional] If the administrator of the account to which the role belongs provided you with an external ID, then enter that value."
  default     = null
}


# GCP Connectors
variable "gcp_workload_pool_id" {
  type        = string
  description = "Workload Pool ID for OIDC authentication"
  default     = null
}

variable "gcp_provider_id" {
  type        = string
  description = "Provider ID for OIDC authentication"
  default     = null
}

variable "gcp_project_id" {
  type        = string
  description = "GCP Project ID for OIDC authentication"
  default     = null
}

variable "gcp_service_account_email" {
  type        = string
  description = "Service Account Email for OIDC authentication"
  default     = null
}

# Azure
variable "azure_application_id" {
  type        = string
  description = "Azure application ID for authentication"
  default     = null
}

variable "azure_tenant_id" {
  type        = string
  description = "Azure tenant ID for authentication"
  default     = null
}

variable "azure_environment_type" {
  type        = string
  description = "ENV TYPE: AZURE or AZURE_US_GOVERNMENT"
  default     = "AZURE"
}

variable "azure_user_assigned_client_id" {
  type        = string
  description = "Client ID for User Assigned Managed Identity"
  default     = null
}

variable "artifact_manager_delegate" {
  type        = list(string)
  description = "Delegate selectors"
  default     = ["build-farm"]
}
