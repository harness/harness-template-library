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

## Harness Hierarchy Setup Details
variable "organization_id" {
  type        = string
  description = "[Required] Provide an existing organization reference ID.  Must exist before execution"
}

variable "project_id" {
  type        = string
  description = "[Required] Provide an existing project reference ID.  Must exist before execution"
}

variable "harness_api_key_secret_ref" {
  type        = string
  description = "[Required] Reference to a Harness Secret containing a Harness Platform API Key with permission to update default execution images (e.g. account.harness_api_key)"
}

################################################
# Pipeline Configuration
################################################
variable "modules" {
  type        = list(string)
  description = "[Optional] Modules to create a manual default image update pipeline for"
  default     = ["ci", "idp", "iacm"]
  validation {
    condition     = alltrue([for module in var.modules : contains(["ci", "idp", "iacm"], module)])
    error_message = "Invalid module specified.  Must be one of: ci, idp, iacm"
  }
}

variable "exclude_images" {
  type        = list(string)
  description = "[Optional] Default image fields to exclude from the pipeline variables"
  default     = ["iacmAnsible", "iacmAwsCdk", "iacmCheckov", "iacmModuleTest", "iacmOpenTofu", "iacmTFCompliance", "iacmTFLint", "iacmTFSec", "iacmTerraform", "iacmTerragrunt"]
}
################################################
