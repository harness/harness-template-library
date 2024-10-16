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

## Harness Hiearchy Setup Details
variable "organization_id" {
  type        = string
  description = "[Required] Provide an existing organization reference ID.  Must exist before execution"
}

variable "project_id" {
  type        = string
  description = "[Required] Provide an existing project reference ID.  Must exist before execution"
}
