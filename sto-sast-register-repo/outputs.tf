locals {
  harness_platform_url = (
    endswith(var.harness_platform_url, "/ng")
    ?
    var.harness_platform_url
    :
    endswith(var.harness_platform_url, "/gateway")
    ?
    replace(var.harness_platform_url, "/gateway", "/ng")
    :
    "${var.harness_platform_url}/ng"
  )

  pipeline = join(
    "/",
    [
      local.harness_platform_url,
      "account",
      var.harness_platform_account,
      "all/orgs",
      data.harness_platform_organization.selected.id,
      "projects",
      data.harness_platform_project.selected.id,
      "pipelines",
      harness_platform_pipeline.scanner.id
    ]
  )
}

output "pipeline_url" {
  value = join(
    "/",
    [
      local.pipeline,
      "pipeline-studio?storeType=INLINE"
    ]
  )
}

output "pipeline_executions_url" {
  value = join(
    "/",
    [
      local.pipeline,
      "executions"
    ]
  )
}

output "pipeline_identifier" {
  value = harness_platform_pipeline.scanner.id
}
