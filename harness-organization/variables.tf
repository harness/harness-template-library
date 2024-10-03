variable "harness_platform_account" {
  type        = string
  description = "[Required] Enter the Harness Platform Account Number"
}

variable "organization_id" {
  type        = string
  description = "[Optional] New Organization Identifier. If not provided, then the organization_name will be formatted to replace spaces and dashes with underscores"
  default     = null
}

variable "organization_name" {
  type        = string
  description = "[Required] New Organization Name"
}

variable "organization_description" {
  type        = string
  description = "[Optional] New Organnization Description"
  default     = "Harness Organnization managed by Solutions Factory"
}

variable "tags" {
  type        = map(any)
  description = "[Optional] Provide a Map of Tags to associate with the resources"
  default     = {}
}
