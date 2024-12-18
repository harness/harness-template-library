resource "harness_platform_connector_bitbucket" "source_code_manager" {
  count              = var.support_self_hosted ? 1 : 0
  identifier         = "buildfarm_source_code_manager"
  name               = "BuildFarm Source Code Manager"
  description        = "BuildFarm Source Code Manager Connector"
  tags               = local.common_tags_tuple
  url                = var.source_code_manager_url
  connection_type    = "Account"
  validation_repo    = var.source_code_manager_validation_repo
  delegate_selectors = var.delegate_selectors
  # execute_on_delegate = true
  credentials {
    http {
      username_ref = var.scm_username
      password_ref = var.scm_password
    }
  }
  api_authentication {
    username_ref = var.scm_username
    token_ref    = var.scm_password
  }
}

resource "harness_platform_connector_bitbucket" "source_code_manager_cloud" {
  count           = var.support_harness_cloud ? 1 : 0
  identifier      = "buildfarm_source_code_manager_cloud"
  name            = "BuildFarm Source Code Manager - Cloud"
  description     = "BuildFarm Source Code Manager Connector for Harness CI Cloud builds"
  tags            = local.common_tags_tuple
  url             = var.source_code_manager_url
  connection_type = "Account"
  validation_repo = var.source_code_manager_validation_repo
  # execute_on_delegate = false
  credentials {
    http {
      username_ref = var.scm_username
      password_ref = var.scm_password
    }
  }
  api_authentication {
    username_ref = var.scm_username
    token_ref    = var.scm_password
  }
}
