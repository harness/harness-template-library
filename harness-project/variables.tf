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
  description = "[Required] Provide an organization reference ID.  Must exist before execution"
}

variable "project_id" {
  type        = string
  description = "[Optional] New Project Identifier. If not provided, then the project_name will be formatted to replace spaces and dashes with underscores"
  default     = null
}

variable "project_name" {
  type        = string
  description = "[Required] New Project Name"
}

variable "project_description" {
  type        = string
  description = "[Optional] New Project Description"
  default     = "Harness Project managed by Solutions Factory"
}

variable "tags" {
  type        = map(any)
  description = "[Optional] Provide a Map of Tags to associate with the resources"
  default     = {}
}
