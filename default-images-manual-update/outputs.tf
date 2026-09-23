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

  pipeline_base_urls = {
    for module, pipeline in harness_platform_pipeline.default_images_manual_update :
    module => join(
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
        pipeline.id
      ]
    )
  }
}

output "pipeline_identifiers" {
  description = "Map of module to the created pipeline identifier"
  value       = { for module, pipeline in harness_platform_pipeline.default_images_manual_update : module => pipeline.id }
}

output "pipeline_urls" {
  description = "Map of module to the Pipeline Studio URL"
  value       = { for module, url in local.pipeline_base_urls : module => "${url}/pipeline-studio?storeType=INLINE" }
}
