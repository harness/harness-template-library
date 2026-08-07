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

variable "tags" {
  type        = map(any)
  description = "[Optional] Provide a Map of Tags to associate with the resources"
  default     = {}
}

####################
# Remove this block and add your custom variable declarations below
#
# The purpose of this file is to collect all Terraform variable declarations into a single
# manageable file.
#
# All items should include the following - `type` and `description`
#
# For sensitive information, use the `sensitve = true` parameter
# For [Optional] items, set the value to null unless there is a specific default value required.
####################

## Harness Hierarchy Setup Details
variable "organization_id" {
  type        = string
  description = "[Required] Provide an existing organization reference ID.  Must exist before execution"
}

variable "project_id" {
  type        = string
  description = "[Required] Provide an existing project reference ID.  Must exist before execution"
}

variable "repository_name" {
  type        = string
  description = "[Required] Provide the repository name. This value will be used to configure the pipeline"
}

variable "repository_path" {
  type        = string
  description = "[Required] Provide the repository path. This value will be used to configure the source code for pipeline"
}

variable "repository_connector_ref" {
  type        = string
  description = "[Optional] Provide the repository connector. When 'null', the pipeline will be configured to use Harness Code Repository for the pipeline source code"
  default     = null
}

variable "branches" {
  type        = string
  description = "[Optional] When configured for 'all' or a specific branches, new pipeline triggers will be added to execute the pipeline when updates are made to branches"
  default     = "skipped"
}

variable "webhook_type" {
  type        = string
  description = "[Required] Provide a supported webhook type"

  validation {
    condition = (
      contains(["harness", "github", "bitbucket"], lower(var.webhook_type))
    )
    error_message = <<EOF
        Validation of Webhook Type Failed.
            * Must be one of the following:
            - harness
            - github
            - bitbucket
        EOF
  }
}
