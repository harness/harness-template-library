resource "harness_platform_secret_text" "scm_username" {
  identifier  = "buildfarm_scm_username"
  name        = "BuildFarm SourceCode Manager Username"
  description = "Username used by BuildFarm SourceCode Manager Connector"
  tags = flatten([
    ["required_for:buildfarm_scm"],
    local.common_tags_tuple
  ])

  secret_manager_identifier = "harnessSecretManager"
  value_type                = "Inline"
  value                     = "changeme"
}

resource "harness_platform_secret_text" "scm_password" {
  identifier  = "buildfarm_scm_password"
  name        = "BuildFarm SourceCode Manager Password"
  description = "Password used by BuildFarm SourceCode Manager Connector"
  tags = flatten([
    ["required_for:buildfarm_scm"],
    local.common_tags_tuple
  ])

  secret_manager_identifier = "harnessSecretManager"
  value_type                = "Inline"
  value                     = "changeme"
}

resource "harness_platform_connector_github" "source_code_manager" {
  count       = local.source_code_manager_type == "github" ? 1 : 0
  identifier  = "buildfarm_source_code_manager"
  name        = "BuildFarm Source Code Manager"
  description = "BuildFarm Source Code Manager Connector"
  tags = flatten([
    ["required_for:buildfarm_scm"],
    local.common_tags_tuple
  ])

  url                 = var.source_code_manager_url
  connection_type     = "Account"
  validation_repo     = var.source_code_manager_validation_repo
  delegate_selectors  = local.delegate_selectors
  execute_on_delegate = var.use_self_hosted
  credentials {
    http {
      username_ref = "account.${harness_platform_secret_text.scm_username.id}"
      token_ref    = "account.${harness_platform_secret_text.scm_password.id}"
    }
  }
}

resource "harness_platform_connector_bitbucket" "source_code_manager" {
  count       = local.source_code_manager_type == "bitbucket" ? 1 : 0
  identifier  = "buildfarm_source_code_manager"
  name        = "BuildFarm Source Code Manager"
  description = "BuildFarm Source Code Manager Connector"
  tags = flatten([
    ["required_for:buildfarm_scm"],
    local.common_tags_tuple
  ])

  url                = var.source_code_manager_url
  connection_type    = "Account"
  validation_repo    = var.source_code_manager_validation_repo
  delegate_selectors = local.delegate_selectors
  credentials {
    http {
      username_ref = "account.${harness_platform_secret_text.scm_username.id}"
      password_ref = "account.${harness_platform_secret_text.scm_password.id}"
    }
  }
}
