
resource "harness_platform_repo" "repository" {
  count          = contains([null, "skipped"], var.sto_config_mgr_connector_ref) ? 1 : 0
  identifier     = var.sto_config_mgr_repo
  description    = "Repository to store and manage Harness STO Global Excemptions"
  default_branch = "main"

  source {
    repo = "goodrum-harness/harness-sto-global-exclusions"
    type = "github"
  }
}

resource "harness_platform_variables" "primer_build_type" {
  identifier = "STO_SAST_SCA_Build_Farm_Connector"
  name       = "STO_SAST_SCA_Build_Farm_Connector"
  type       = "String"
  spec {
    value_type  = "FIXED"
    fixed_value = local.build_farm_connector
  }
}
