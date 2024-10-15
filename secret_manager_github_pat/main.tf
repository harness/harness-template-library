resource "harness_platform_template" "this" {
  org_id     = var.organization_id
  project_id = var.project_id
  identifier = "github_app_pat_dispenser"
  name       = "GitHub App PAT Dispenser"
  comments   = "https://developer.harness.io/kb/continuous-integration/articles/github-app-pat-dispenser"
  version    = var.template_version
  is_stable  = true
  template_yaml = templatefile(
    "${path.module}/templates/secret_managers/github_app_pat_dispenser.yaml",
    {
      # Template Setup Details
      TEMPLATE_IDENTIFIER : "github_app_pat_dispenser"
      TEMPLATE_NAME : "GitHub App PAT Dispenser"
      ORGANIZATION_ID : var.organization_id
      PROJECT_ID : var.project_id

      TEMPLATE_COMMENTS : "https://developer.harness.io/kb/continuous-integration/articles/github-app-pat-dispenser"
      TEMPLATE_VERSION : var.template_version

      GITHUB_API_URL : var.github_api_url

      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}
