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
  description = "[Optional] The organization where the template will live, leave blank for account level. Provide an existing organization reference ID.  Must exist before execution"
  default     = null
}

variable "project_id" {
  type        = string
  description = "[Optional] The project where the template will live, leave blank for organization or account level. Provide an existing project reference ID.  Must exist before execution"
  default     = null
}

## Template details
variable "template_name" {
  type        = string
  description = "[Required] Name of the secret manager template"
  default     = "CyberArk Conjur"
}

variable "template_version" {
  type        = string
  description = "[Required] Version strings for the template"
  default     = "1.0"
}