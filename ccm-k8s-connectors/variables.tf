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

variable "delegate_name" {
  type        = string
  description = "The name of the delegate that has been deployed in your cluster"
}

variable "cluster_name" {
  type        = string
  default     = null
  description = "The name of the cluster, if different from the delegate name"
}

variable "description" {
  type        = string
  default     = ""
  description = "Description of the cluster to add to the connectors"
}

variable "enable_optimization" {
  type        = bool
  default     = false
  description = "If optimization (autostopping) should be enabled for this cluster (requires additional in-cluster deployment)"
}