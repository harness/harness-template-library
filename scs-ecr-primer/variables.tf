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

variable "organization_id" {
  type        = string
  description = "[Optional] Existing Organization ID to scope the templates to. Must exist before execution. Leave null for Account-level templates."
  default     = null
}

variable "project_id" {
  type        = string
  description = "[Optional] Existing Project ID to scope the templates to. Must exist before execution. Requires organization_id to also be set."
  default     = null
}
