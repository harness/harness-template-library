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
      harness_platform_pipeline.pipeline.id
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
  value = harness_platform_pipeline.pipeline.id
}

output "pipeline_input_set" {
  value = join(
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
      harness_platform_pipeline.pipeline.id,
      "input-sets",
      harness_platform_input_set.defaults.id
    ]
  )
}
