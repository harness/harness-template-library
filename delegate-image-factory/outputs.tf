locals {
  outputs = {
    repository = (
      var.git_connector_ref != null
      ?
      {
        repo_url = var.git_repository_name
        branch   = "main"
      }
      :
      {
        repo_url = harness_platform_repo.repository.0.git_url
        branch   = harness_platform_repo.repository.0.default_branch
      }
    )
  }
  pipeline = join(
    "/",
    [
      replace(var.harness_platform_url, "/gateway", "/ng"),
      "account",
      var.harness_platform_account,
      "all/orgs",
      data.harness_platform_organization.selected.id,
      "projects",
      data.harness_platform_project.selected.id,
      "pipelines"
    ]
  )
}

output "repository_url" {
  value = local.outputs.repository.repo_url
}

output "repository_branch" {
  value = local.outputs.repository.branch
}

output "pipeline" {
  value = local.pipeline
}
