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

variable "organization_id" {
  type        = string
  description = "The Organization ID where the pipeline will be created"
}

variable "project_id" {
  type        = string
  description = "The Project ID where the pipeline will be created"
}

variable "repository_name" {
  type        = string
  description = "Provide the name of the Repository to create"

  validation {
    condition     = can(regex("^[a-zA-Z_][a-zA-Z0-9-_.]{0,127}$", var.repository_name))
    error_message = "Name must start with a letter or _ and only contain [a-zA-Z0-9-_.]"
  }
}

variable "repository_description" {
  type        = string
  description = "Provide the Description for the Repository"
  default     = ""
}

variable "repository_rule_is_active" {
  type        = string
  description = "When 'active' will enforce repository rules preventing changes except by CODEOWNERS"
  default     = "active"

  validation {
    condition = (
      contains(["active", "disabled", "monitor"], var.repository_rule_is_active)
    )
    error_message = <<EOF
        Validation of an object failed.
            * When 'active' will enforce repository rules preventing changes except by CODEOWNERS
            Valid Options:
              - active
              - disabled
              - monitor
        EOF
  }
}

variable "repository_merge_strategies" {
  type        = list(string)
  description = "Limit which merge strategies are available to merge a pull request"
  default     = []

  validation {
    condition = (
      length(var.repository_merge_strategies) > 0
      ?
      length([
        for strategy in var.repository_merge_strategies : true
        if contains(["fast-forward", "merge", "rebase", "squash"], strategy)
      ]) == length(var.repository_merge_strategies)
      :
      true
    )
    error_message = <<EOF
        Validation of an object failed.
            * Limit which merge strategies are available to merge a pull request
            Valid Options:
              - fast-forward
              - merge
              - rebase
              - squash
        EOF
  }
}
