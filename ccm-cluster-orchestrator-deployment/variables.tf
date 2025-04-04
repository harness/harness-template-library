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

variable "service_name" {
  type        = string
  description = "[Optional] Enter the name of the service"
  default     = "Cluster Orchestrator"
}

variable "docker_connector" {
  type        = string
  description = "[Optional] Docker connector ID for pulling orchestrator image"
  default     = "account.harnessImage"
}

variable "image" {
  type        = string
  description = "[Optional] Orchestrator docker image to use. Must follow repo/image format"
  default     = "harness/cluster-orchestrator"
}

## Harness Hiearchy Setup Details
variable "organization_id" {
  type        = string
  description = "[Optional] The organization where the resources will live, leave blank for account level. Provide an existing organization reference ID.  Must exist before execution"
  default     = null
}

variable "project_id" {
  type        = string
  description = "[Optional] The project where the resources will live, leave blank for organization or account level. Provide an existing project reference ID.  Must exist before execution"
  default     = null
}