# Harness CI Golden Standard Templates
# This module creates a complete set of CI templates and pipelines
# following Harness best practices for continuous integration.

# The main.tf file now serves as the entry point and documents the module's purpose.
# All resources have been logically separated into dedicated files:
# - data.tf: Data sources for organization and project lookup
# - locals.tf: Local values and computed configurations
# - harness_stages_v1.tf: Stage Templates
# - harness_step_groups_v1.tf: StepGroup Templates
# - outputs.tf: Module outputs for integration with other modules
# - versions.tf: Terraform and provider version constraints

# This structure provides better maintainability, readability, and follows
# Terraform best practices for module organization.

resource "harness_platform_variables" "primer_buildfarm_scm" {
  identifier = "CI_Default_Build_Farm_SCM_Connector"
  name       = "CI_Default_Build_Farm_SCM_Connector"
  type       = "String"
  spec {
    value_type  = "FIXED"
    fixed_value = local.build_farm_SCM_connector
  }
}

resource "harness_platform_variables" "primer_buildfarm_registry" {
  identifier = "CI_Default_Build_Farm_Registry_Connector"
  name       = "CI_Default_Build_Farm_Registry_Connector"
  type       = "String"
  spec {
    value_type  = "FIXED"
    fixed_value = local.build_farm_CR_connector
  }
}
