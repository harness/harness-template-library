locals {
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

output "pipeline_url" {
  value = local.pipeline
}
