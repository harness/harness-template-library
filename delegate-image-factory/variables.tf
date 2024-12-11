# Variable Management Details

## Harness Account Provider Connection Details
variable "harness_platform_url" {
  type        = string
  description = "[Optional] Enter the Harness Platform URL.  Defaults to Harness SaaS URL"
  default     = "https://app.harness.io/gateway"
}

variable "harness_platform_account" {
  type        = string
  description = "[Required] Enter the Harness Platform Account Number"
}

variable "existing_harness_platform_key_ref" {
  type        = string
  description = "[Required] Provide an existing Harness Platform key secret reference.  Must exist before execution"
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

## CI CodeBase Configuration
variable "git_repository_name" {
  type        = string
  description = "[Optional] The source CodeBase Repository Name"
  default     = "harness-delegate-setup"
}

variable "git_connector_ref" {
  type        = string
  description = "[Optional] When provided, the existing Git connector will be used. When 'null' a custom Harness Code Repository will be added into the project."
  default     = "skipped"
}


## CI Infrastructure Variables
variable "kubernetes_connector" {
  type        = string
  description = "[Required] Enter the existing Kubernetes connector if local K8s execution should be used when running the Execution pipeline.  Must exist before execution"
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
  description = "[Optional] Enter an existing Container Registry connector to use which overrides the default connector.  Must exist before execution"
  default     = "skipped"
}

## Docker Image Regisry Details
variable "container_registry_name" {
  type        = string
  description = "[Required] Docker Registry Name to which the container will be published"
}

variable "container_registry_connector_id" {
  type        = string
  description = "[Required] Existing Docker Registry Connector Id.  Must exist before execution"
}

## Pipeline Control Mechanisms
variable "include_image_test_scan" {
  type        = bool
  description = "[Optional] Include the Image Test Scan"
  default     = false
}

variable "include_image_sbom" {
  type        = bool
  description = "[Optional] Include Harness Software Bill of Materials"
  default     = false
}

## Pipeline Step Type Controls
variable "container_registry_type" {
  type        = string
  description = "[Optional] Container Registry Type"
  default     = "docker"
}

variable "sto_scanner_type" {
  type        = string
  description = "[Optional] Harness STO Scanner Type"
  default     = "aqua_trivy"
}
