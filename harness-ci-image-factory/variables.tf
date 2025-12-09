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

## Harness Hierarchy Setup Details
variable "organization_id" {
  type        = string
  description = "[Required] Provide an existing organization reference ID.  Must exist before execution"
}

variable "project_id" {
  type        = string
  description = "[Required] Provide an existing project reference ID.  Must exist before execution"
}



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
# Pipeline Input Variables Controls
# -----------
# Configures the Defaults for both the pipeline as well as the Trigger
################################################
variable "harness_ci_image_source_repository" {
  type        = string
  description = "Harness maintained container registry from which images will be sourced"
  default     = "us-docker.pkg.dev/gar-prod-setup/harness-public/"
}

variable "customer_image_target_repository" {
  type        = string
  description = "[Required] Customer provided Container Registry Path"
}

variable "container_registry_username_ref" {
  type        = string
  description = "Reference to Harness Secret containing the Container Registry Username. Defaults to Central Build Farm Container Registry Credentials"
  default     = "account.buildfarm_container_registry_username"
}

variable "container_registry_password_ref" {
  type        = string
  description = "Reference to Harness Secret containing the Container Registry Password. Defaults to Central Build Farm Container Registry Credentials"
  default     = "account.buildfarm_container_registry_password"
}

variable "should_update_harness_mgr" {
  type        = bool
  description = "If 'true' the Harness CI Manager will be updated immediately to change the default behaviour of Harness CI to only pull images from those stored in the target container registry."
  default     = true
}

variable "modules" {
  type        = list(string)
  description = "List of modules to migrate images for"
  default     = ["ci"]
  validation {
    condition     = can([for module in var.modules : contains(["ci", "idp", "iacm-manager"], module)])
    error_message = "Invalid module specified.  Must be one of: ci, idp, iacm-manager"
  }
}
################################################



################################################
# Pipeline Image and Connector Controls
# -----------
# Configures the connectors and images used for the steps
################################################
variable "pipeline_step_connector_ref" {
  type        = string
  description = "[Optional] Configures the connector from which the Pipeline Step images will be pulled. Defaults to account.harnessImage"
  default     = "account.harnessImage"
}

variable "hsf_script_mgr_image" {
  type        = string
  description = "Harness Solutions Factory Script Manager Image. Path should be relative to the connector `pipeline_step_connector_ref`"
  default     = "harnesssolutionfactory/harness-python-api-sdk:latest"
}

variable "harness_image_migration_image" {
  type        = string
  description = "Harness Container Image Migration tool. Path should be relative to the connector `pipeline_step_connector_ref`"
  default     = "plugins/image-migration"
}

variable "max_concurrency" {
  type        = number
  description = "Determines the maximum number of concurrent images that should be migrated in parallel"
  default     = 5
}
################################################



################################################
# Scheduled Execution Management
# -----------
# When enabled, a new trigger will be scheduled to execution and update the pipeline
# at a regular frequency
################################################
variable "should_trigger_pipeline_on_schedule" {
  type        = bool
  description = "[Optional] Should we enable the execution of this pipeline to run on a schedule?"
  default     = true
}

variable "scheduled_pipeline_execution_frequency" {
  type        = string
  description = "[Optional] Cron Format schedule for when and how frequently to schedule this pipeline. Default is daily at 2am"
  default     = "0 2 * * *"
}

################################################
