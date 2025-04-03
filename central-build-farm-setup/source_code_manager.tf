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

resource "harness_platform_secret_sshkey" "scm_ssh_key" {
  count       = var.source_code_manager_auth_type == "ssh" ? 1 : 0
  identifier  = "buildfarm_scm_ssh_key"
  name        = "BuildFarm SourceCode Manager SSH Key"
  description = "SSH credentials used by BuildFarm SourceCode Manager Connector"
  tags = flatten([
    ["required_for:buildfarm_scm"],
    local.common_tags_tuple
  ])
  port = 22
  ssh {
    sshkey_reference_credential {
      user_name = "buildfarm_scm_username"
      key       = "account.buildfarm_scm_password"
    }
    credential_type = "KeyReference"
  }
}

module "scm_github" {
  count  = local.source_code_manager_type == "github" ? 1 : 0
  source = "./modules/scm/github"

  source_code_manager_url             = var.source_code_manager_url
  source_code_manager_validation_repo = var.source_code_manager_validation_repo
  scm_username                        = "account.${harness_platform_secret_text.scm_username.id}"
  scm_password                        = "account.${harness_platform_secret_text.scm_password.id}"
  support_self_hosted                 = local.support_self_hosted
  support_harness_cloud               = local.support_harness_cloud
  tags                                = local.common_tags
}

module "scm_bitbucket" {
  count  = local.source_code_manager_type == "bitbucket" ? 1 : 0
  source = "./modules/scm/bitbucket"

  source_code_manager_url             = var.source_code_manager_url
  source_code_manager_validation_repo = var.source_code_manager_validation_repo
  scm_username                        = "account.${harness_platform_secret_text.scm_username.id}"
  scm_password                        = "account.${harness_platform_secret_text.scm_password.id}"
  support_self_hosted                 = local.support_self_hosted
  support_harness_cloud               = local.support_harness_cloud
  tags                                = local.common_tags
}

module "scm_gitlab" {
  count  = local.source_code_manager_type == "gitlab" ? 1 : 0
  source = "./modules/scm/gitlab"

  source_code_manager_url             = var.source_code_manager_url
  source_code_manager_validation_repo = var.source_code_manager_validation_repo
  source_code_manager_auth_type       = var.source_code_manager_auth_type
  scm_username                        = "account.${harness_platform_secret_text.scm_username.id}"
  scm_password                        = "account.${harness_platform_secret_text.scm_password.id}"
  scm_ssh_key                         = var.source_code_manager_auth_type == "ssh" ? "account.${harness_platform_secret_sshkey.scm_ssh_key[0].id}" : null
  support_self_hosted                 = local.support_self_hosted
  support_harness_cloud               = local.support_harness_cloud
  tags                                = local.common_tags

}
