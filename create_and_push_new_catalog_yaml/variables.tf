# Harness Account Setup
variable "harness_platform_url" {
  type        = string
  description = "[Optional] Enter the Harness Platform URL.  Defaults to Harness SaaS URL"
  default     = "https://app.harness.io/gateway"
}

variable "harness_platform_account" {
  type        = string
  description = "[Required] Enter the Harness Platform Account Number"
}

variable "harness_platform_key" {
  type        = string
  description = "[Required] Enter the Harness Platform API Key for your account"
  default     = null # If Not passed, then the ENV HARNESS_PLATFORM_API_KEY will be used
  sensitive   = true
}

variable "tags" {
  type        = map(any)
  description = "[Optional] Provide a Map of Tags to associate with the resources"
  default     = {}
}

## Harness Hiearchy Setup Details
variable "organization_id" {
  type        = string
  description = "[Required] Provide an existing organization reference ID.  Must exist before execution"
}

variable "project_id" {
  type        = string
  description = "[Required] Provide an existing project reference ID.  Must exist before execution"
}

## Git Connector Setup Details
variable "git_connector_ref" {
  type        = string
  description = "[Optional] Git connector for pushing catalog entries"
  default     = ""
}

variable "git_connector_type" {
  type        = string
  description = "[Required] The type of git connector used"
  validation {
    condition     = contains(["HarnessAccount", "HarnessOrganization", "HarnessProject", "Github", "Gitlab", "Bitbucket", "AzureRepo"], var.git_connector_type)
    error_message = "The git_connector_type value must be one of HarnessAccount, HarnessOrganization, HarnessProject, Github, Gitlab, Bitbucket or AzureRepo."
  }
}

variable "git_organization_name" {
  type        = string
  description = "[Optional] Git organization name, used for Github and AzureRepo types"
  default     = ""
}

variable "git_workspace_name" {
  type        = string
  description = "[Optional] Git workspace name, used for BitBucket types"
  default     = ""
}

variable "git_grouppath_name" {
  type        = string
  description = "[Optional] Git group path name, used for Gitlab types"
  default     = ""
}

variable "git_project_name" {
  type        = string
  description = "[Optional] Git project name, used for Gitlab, Bitbucket and Azure types"
  default     = ""
}

variable "git_repository_name" {
  type        = string
  description = "[Required] Git repository name to push catalogs to"
}

variable "git_branch_name" {
  type        = string
  description = "[Required] Git branch to commit catalogs to"
}

variable "harness_create_repo" {
  type        = bool
  description = "[Optional] Create the Harness code repo to be used"
  default     = false
}

## Pipeline Infrastructure Variables
variable "kubernetes_connector" {
  type        = string
  description = "[Required] Enter the existing Kubernetes connector if local K8s execution should be used when running the Execution pipeline.  Must exist before execution"
  default     = "skipped"
}

variable "kubernetes_namespace" {
  type        = string
  description = "[Optional] Enter the existing Kubernetes namespace if local K8s execution should be used when running the Execution pipeline.  Must exist before execution"
  default     = "default"
}

variable "kubernetes_node_selectors" {
  type        = map(any)
  description = "[Optional] Optional Kubernetes Node Selectors"
  default     = {}
}

variable "kubernetes_override_image_connector" {
  type        = string
  description = "[Optional] Enter an existing Container Registry connector to use which overrides the default connector.  Must exist before execution"
  default     = "skipped"
}
