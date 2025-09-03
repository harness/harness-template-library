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

variable "organization_id" {
  type        = string
  description = "The Organization ID where the pipeline will be created"
}

variable "project_id" {
  type        = string
  description = "The Project ID where the pipeline will be created"
}

variable "template_organization_id" {
  type        = string
  description = "The Organization ID where the Template exists"
  default     = null
}

variable "template_project_id" {
  type        = string
  description = "The Project ID where the Template exists"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}

variable "pipeline_name" {
  type        = string
  description = "The name of the pipeline to create"
}

variable "repository_connector_ref" {
  type        = string
  description = "[Optional] Provide the repository connector. When 'skipped', the pipeline will be configured to use Harness Code Repository for the pipeline source code"
  default     = "skipped"
}

variable "repository_path" {
  type        = string
  description = "[Required] Provide the repository path. This value will be used to configure the source code for pipeline"
}

variable "branches" {
  type        = string
  description = "[Optional] When configured for 'all' or a specific branch, a new pipeline trigger will be added to execute the pipeline when updates are made to branches"
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
