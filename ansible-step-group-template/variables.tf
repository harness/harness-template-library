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
  description = "Name of the Ansible step group template"
  default     = "Execute Ansible"
}

variable "template_version" {
  type        = string
  description = "Version strings for the step group template"
  default     = "1.0"
}

variable "template_types" {
  type        = list(string)
  description = "[Optional] A seperate template will be created for each stage type specified"
  default     = ["Deployment", "CI", "IACM"]

  validation {
    condition     = alltrue([for s in var.template_types : s == "Deployment" || s == "CI" || s == "IACM"])
    error_message = "The only allowed template types are 'Deployment', 'CI', and 'IACM'."
  }
}

variable "harness_code" {
  type        = bool
  description = "[Optional] If you are using Harness code to store your ansible playbooks"
  default     = false
}

variable "docker_connector" {
  type        = string
  description = "Docker connector ID for pulling ansible image"
  default     = "account.harnessImage"
}

variable "image" {
  type        = string
  description = "Docker image to use for running ansible. Must follow repo/image format"
  default     = "alpine/ansible"
}

## Pipeline Infrastructure Variables
variable "kubernetes_connector" {
  type        = string
  description = "[Optional] Enter the existing Kubernetes connector to use for Execution.  Must exist before execution. Set to 'skipped' to use <+input>"
  default     = "skipped"
}

variable "kubernetes_namespace" {
  type        = string
  description = "[Optional] Enter the existing Kubernetes namespace to use for Execution.  Must exist before execution. Set to 'skipped' to use <+input>"
  default     = "skipped"
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