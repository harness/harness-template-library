#################################
# Harness Platform Configuration
#################################

variable "harness_platform_url" {
  type        = string
  description = "Harness Platform URL. Defaults to Harness SaaS gateway endpoint."
  default     = "https://app.harness.io/gateway"
}

variable "harness_platform_account" {
  type        = string
  description = "Harness Platform Account ID (Required)."
}

variable "organization_id" {
  type        = string
  description = "Optional: Existing Organization ID for use with template. Must exist before execution."
  default     = null
}

variable "project_id" {
  type        = string
  description = "Optional: Existing Project ID for use with template. Must exist before execution."
  default     = null
}

variable "tags" {
  type        = map(any)
  description = "Optional: Tags to associate with Harness resources."
  default     = {}
}

## Pipeline Control Mechanisms
variable "include_security_testing" {
  type        = bool
  description = "Optional: Include the Harness Security Test Orchestration steps"
  default     = true
}

variable "include_supply_chain_security" {
  type        = bool
  description = "Optional: Include the Harness Supply Chain Security steps"
  default     = true
}

variable "default_container_connector" {
  type        = string
  description = "Optional: Docker connector identifier to use for STO and SCS Steps. Must exist before execution."
  default     = "account.harnessImage"
}

# Note: pipeline_name is no longer needed in the main module
# Individual pipelines are created using the register-pipeline module

#####################################
# Pipeline Infrastructure Variables
#####################################

variable "kubernetes_connector" {
  type        = string
  description = "Required: Kubernetes connector identifier. Must exist before execution."
  default     = "skipped"
}

variable "kubernetes_namespace" {
  type        = string
  description = "Optional: Kubernetes namespace for pipeline execution."
  default     = "default"
}

variable "kubernetes_node_selectors" {
  type        = map(any)
  description = "Optional: Kubernetes node selectors for workload scheduling."
  default     = {}
}

variable "kubernetes_override_image_connector" {
  type        = string
  description = "Optional: Container registry connector to override default connector."
  default     = "skipped"
}

#####################################
# Pipeline Security Scan Variables
#####################################
variable "sto_anchore_grype_fail_on" {
  type        = string
  description = "Optional: If the scan finds any vulnerability with the specified severity or higher, the pipeline fails."
  default     = "skipped"
  validation {
    condition     = contains(["skipped", "none", "low", "medium", "high", "critical"], lower(var.sto_anchore_grype_fail_on))
    error_message = <<EOH
      The enabled scanners will be included by default in the templates
      Supported Scanners:
        - None
        - Low
        - Medium
        - High
        - Critical
    EOH
  }
}
