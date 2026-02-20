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

variable "template_name" {
  type        = string
  description = "Name of the 'kubectl apply' step template that will create auto stopping rules"
  default     = "Auto-Stop Ingress"
}

variable "template_version" {
  type        = string
  description = "Version strings for the step template"
  default     = "1.0"
}

## Harness Hiearchy Setup Details
variable "template_organization_id" {
  type        = string
  description = "[Optional] The organization where the step template will live, leave blank for account level. Provide an existing organization reference ID.  Must exist before execution"
  default     = null
}

variable "template_project_id" {
  type        = string
  description = "[Optional] The project where the step template will live, leave blank for organization or account level. Provide an existing project reference ID.  Must exist before execution"
  default     = null
}

## Pipeline Setup Variables

variable "pipeline_organization_id" {
  type        = string
  description = "[Required] The organization where the pipeline will live. Provide an existing organization reference ID.  Must exist before execution"
}

variable "pipeline_project_id" {
  type        = string
  description = "[Required] The project where the pipeline will live. Provide an existing project reference ID.  Must exist before execution"
}

variable "existing_harness_platform_key_ref" {
  type        = string
  description = "Existing secret ID for Harness API key that can modify CD services"
}

variable "docker_connector" {
  type        = string
  description = "Docker connector ID for pulling plugin image"
  default     = "harnessImage"
}

variable "image" {
  type        = string
  description = "Plugin docker image to use for modifying services. Must follow repo/image:tag format"
  default     = "harnesscommunity/add-autostopping-variables:576e4f594a80d482f77761f4ca8b715cf25c983d"
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