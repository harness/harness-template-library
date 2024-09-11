locals {
  build_farm_id = (
    var.use_self_hosted
    ?
    "account.${harness_platform_connector_kubernetes.buildfarm.0.id}"
    :
    null
  )

  container_registry_id = {
    "docker"      = (local.container_registry_type == "docker" ? harness_platform_connector_docker.container_registry.0.id : null)
    "artifactory" = (local.container_registry_type == "artifactory" ? harness_platform_connector_artifactory.container_registry.0.id : null)
  }

  source_code_manager_id = {
    "github"    = (local.source_code_manager_type == "github" ? harness_platform_connector_github.source_code_manager.0.id : null)
    "bitbucket" = (local.source_code_manager_type == "bitbucket" ? harness_platform_connector_bitbucket.source_code_manager.0.id : null)
  }

  build_farm_delegate = (
    var.use_self_hosted
    ?
    "Deploy an Account Level delegate. Be sure to include the following tag(s) in the configuration: - build-farm"
    :
    "skipped"
  )
}

output "build_farm_connector" {
  description = "If using self-hosted build farm, this output contains the details of the BuildFarm Infrastructure connector"
  value       = local.build_farm_id
}

output "build_farm_container_registry" {
  description = "The BuildFarm Container Registry Connector Id"
  value       = "account.${local.container_registry_id[local.container_registry_type]}"
}

output "build_farm_source_code_manager" {
  description = "The BuildFarm Source Code Manager Connector Id"
  value       = "account.${local.source_code_manager_id[local.source_code_manager_type]}"
}
