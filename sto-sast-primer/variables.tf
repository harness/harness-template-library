################################################
# Harness Hierarchy Setup Details
# -----------
# Determines placement of resources. When both organization_id and project_id are null,
# the resources will be placed at the account level
################################################
variable "organization_id" {
  type        = string
  description = "[Optional] Harness Organization ID into which resource should be built.  Must exist before execution."
  default     = null
}

variable "project_id" {
  type        = string
  description = "[Optional] Harness Project ID into which resource should be built.  Must exist before execution. Requires `organization_id`"
  default     = null
}

variable "tags" {
  type        = map(any)
  description = "[Optional] Provide a Map of Tags to associate with all resources"
  default     = {}
}

variable "should_support_hcr" {
  type        = bool
  description = "[Optional] Should a pipeline template be included which support Harness Code Repository sources"
  default     = true
}

################################################


################################################
# Self-Hosted Build Farm Configuration
# -----------
# When the kubernetes_connector value equals "skipped", then the resources
# will be deployed configured to support Harness CI Cloud provisioning.
################################################
variable "kubernetes_connector" {
  type        = string
  description = "[Optional] Enter the existing Kubernetes connector if local K8s execution should be used when running the Execution pipeline.  Must exist before execution"
  default     = "skipped"
}

variable "kubernetes_namespace" {
  type        = string
  description = "[Optional] Enter the existing Kubernetes namespace if local K8s execution should be used when running the Execution pipeline.  Must exist before execution"
  default     = "default"
}

variable "kubernetes_node_selectors" {
  type        = map(any)
  description = "[Optional] Optional Kubernetes Node Selectors"
  default     = {}
}

variable "kubernetes_override_image_connector" {
  type        = string
  description = "[Optional] Enter an existing Container Registry connector to use which overrides the default connector"
  default     = "skipped"
}

################################################


################################################
# Harness STO Scanner Configuration
# -----------
# Override which Scanners to configure and their individual image overrides
################################################
variable "enabled_scanners" {
  type        = list(string)
  description = "The enabled scanners will be included by default in the templates"
  default     = ["gitleaks", "osv", "owasp", "semgrep"]

  validation {
    condition = length([
      for item in var.enabled_scanners : true if contains(["gitleaks", "osv", "owasp", "semgrep"], item)
    ]) == length(var.enabled_scanners)
    error_message = <<EOH
      The enabled scanners will be included by default in the templates
      Supported Scanners:
        - gitleaks
        - osv
        - owasp
        - semgrep
    EOH
  }
}

variable "scanner_override_image_connector" {
  type        = string
  description = "[Optional] Provide existing Container Registry connector_id to be used to pull all scanner images."
  default     = "skipped"
}

variable "gitleaks_override_image_name" {
  type        = string
  description = "[Optional] Provide an override image reference to pull"
  default     = "skipped"
}

variable "gitleaks_override_cpu" {
  type        = string
  description = "[Optional] Provide an override step CPU value - You can specify a fraction as well. 0.1 is equivalent to 100m, or 100 millicpu."
  default     = "0.4"
}

variable "gitleaks_override_mem" {
  type        = string
  description = "[Optional] Provide an override step MEM value - You can specify an integer or fixed-point value with the suffix G, M, Gi, or Mi."
  default     = "600Mi"
}

variable "osv_override_image_name" {
  type        = string
  description = "[Optional] Enter an existing Container image which to use for OSV scans"
  default     = "skipped"
}

variable "osv_override_cpu" {
  type        = string
  description = "[Optional] Provide an override step CPU value - You can specify a fraction as well. 0.1 is equivalent to 100m, or 100 millicpu."
  default     = "1"
}

variable "osv_override_mem" {
  type        = string
  description = "[Optional] Provide an override step MEM value - You can specify an integer or fixed-point value with the suffix G, M, Gi, or Mi."
  default     = "2Gi"
}

variable "owasp_override_image_name" {
  type        = string
  description = "[Optional] Enter an existing Container image which to use for OWASP scans"
  default     = "skipped"
}

variable "owasp_override_cpu" {
  type        = string
  description = "[Optional] Provide an override step CPU value - You can specify a fraction as well. 0.1 is equivalent to 100m, or 100 millicpu."
  default     = "2"
}

variable "owasp_override_mem" {
  type        = string
  description = "[Optional] Provide an override step MEM value - You can specify an integer or fixed-point value with the suffix G, M, Gi, or Mi."
  default     = "6Gi"
}

variable "semgrep_override_image_name" {
  type        = string
  description = "[Optional] Enter an existing Container image which to use for Semgrep scans"
  default     = "skipped"
}

variable "semgrep_override_cpu" {
  type        = string
  description = "[Optional] Provide an override step CPU value - You can specify a fraction as well. 0.1 is equivalent to 100m, or 100 millicpu."
  default     = "2"
}

variable "semgrep_override_mem" {
  type        = string
  description = "[Optional] Provide an override step MEM value - You can specify an integer or fixed-point value with the suffix G, M, Gi, or Mi."
  default     = "4Gi"
}

# -> Tools connector for copying binaries for dependency checks
variable "tools_image_connector" {
  type        = string
  description = "[Optional] Enter an existing Container Registry connector_id which contains build tools image for OWASP scans"
  default     = "account.harnessImage"
}

# -> Tools image for copying binaries for dependency checks
variable "tools_image_name" {
  type        = string
  description = "[Optional] Enter an existing Container image which contains build tools for OWASP scans"
  default     = "node:20.11.0-alpine"
}

################################################


################################################
# Harness STO Global Configuration Manager image
# -----------
# Configures the source repository for the Harness STO Global Exclusions manager source code
################################################
variable "sto_config_mgr_connector_ref" {
  type        = string
  description = "[Optional] When provided, the existing Git connector will be used. When 'skipped' a custom Harness Code Repository will be added into the scope."
  default     = "skipped"
}

variable "sto_config_mgr_repo" {
  type        = string
  description = "[Required] The source CodeBase Repository Name. If `sto_config_mgr_connector_ref` is set, then provide the full repo details based on the connector type."
  default     = "harness-sto-global-exclusions"
}

variable "sto_config_mgr_connector" {
  type        = string
  description = "[Required] Provide Container Registry connector from which the STO Configuration Manager image will be retrieved. Defaults to account.harnessImage"
  default     = "account.harnessImage"
}

variable "sto_config_mgr_image" {
  type        = string
  description = "[Required] Provide the Container Registry image name and tag for the STO Configuration Manager image"
  default     = "harnesssolutionfactory/harness-sto-config-manager:latest"
}

################################################
