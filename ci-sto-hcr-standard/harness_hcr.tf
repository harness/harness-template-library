resource "harness_platform_repo" "hcr" {
  identifier     = var.repository_name
  org_id         = data.harness_platform_organization.selected.id
  project_id     = data.harness_platform_project.selected.id
  default_branch = "main"
  description    = var.repository_description
}

resource "harness_platform_repo_rule_branch" "code_owners" {
  lifecycle {
    ignore_changes = [
      bypass
    ]
  }
  identifier      = "codeowners"
  org_id          = data.harness_platform_organization.selected.id
  project_id      = data.harness_platform_project.selected.id
  description     = <<EOF
This rule enabled to prevent unintended changes to this repository which will cause issues with
  the retrieving of updates for this repository.
  EOF
  repo_identifier = harness_platform_repo.hcr.identifier
  state           = var.repository_rule_is_active

  bypass {
    repo_owners = true
    user_ids    = []
  }

  policies {
    allow_merge_strategies         = var.repository_merge_strategies
    block_branch_creation          = true
    block_branch_deletion          = true
    delete_branch_on_merge         = true
    require_code_owners            = true
    require_latest_commit_approval = true
    require_minimum_approval_count = 1
    require_no_change_request      = true
    require_pull_request           = true
    require_resolve_all_comments   = true
    require_status_checks          = []
  }

  pattern {
    default_branch = true
  }
}
