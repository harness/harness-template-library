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

## Pipeline Setup Variables
variable "organization_id" {
  type        = string
  description = "[Required] The organization where the pipeline will live. Provide an existing organization reference ID.  Must exist before execution"
}

variable "project_id" {
  type        = string
  description = "[Required] The project where the pipeline will live. Provide an existing project reference ID.  Must exist before execution"
}

variable "harness_endpoint" {
  type        = string
  description = "Harness endpoint for API calls"
  default     = "app.harness.io"
}

variable "existing_harness_platform_key_ref" {
  type        = string
  description = "Existing secret ID for Harness API key that can modify CD services"
}

variable "connector_prefix" {
  type        = string
  description = "Prefix to add to all create Kubernetes and CCM Kubernetes connectors"
  default     = "ccm"
}

variable "docker_connector" {
  type        = string
  description = "Docker connector ID for pulling plugin image"
}

variable "image" {
  type        = string
  description = "Plugin docker image to use for creating connectors. Must follow repo/image:tag format"
  default     = "harnesscommunity/harness-ccm-k8s-auto:4a32f7c"
}

variable "cron" {
  type        = string
  description = "The cron schedule to trigger the pipeline on a scheduled"
  default     = "0 1 * * *"
}

## Pipeline Infrastructure Variables
variable "kubernetes_connector" {
  type        = string
  description = "[Required] Enter the existing Kubernetes connector if local K8s execution should be used when running the Execution pipeline.  Must exist before execution"
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