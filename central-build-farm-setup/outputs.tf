locals {
  build_farm_id = (
    local.support_self_hosted
    ?
    "account.${harness_platform_connector_kubernetes.buildfarm.0.id}"
    :
    null
  )

  container_registry_id = {
    "docker"      = (local.container_registry_type == "docker" ? module.cr_docker.0.connector : null)
    "artifactory" = (local.container_registry_type == "artifactory" ? module.cr_artifactory.0.connector : null)
    "aws"         = (local.container_registry_type == "aws" ? module.cr_aws.0.connector : null)
  }

  container_registry_cloud_id = {
    "docker"      = (local.container_registry_type == "docker" ? module.cr_docker.0.connector_cloud : null)
    "artifactory" = (local.container_registry_type == "artifactory" ? module.cr_artifactory.0.connector_cloud : null)
    "aws"         = (local.container_registry_type == "aws" ? module.cr_aws.0.connector_cloud : null)
  }

  source_code_manager_id = {
    "github"    = (local.source_code_manager_type == "github" ? module.scm_github.0.connector : null)
    "bitbucket" = (local.source_code_manager_type == "bitbucket" ? module.scm_bitbucket.0.connector : null)
  }
  source_code_manager_cloud_id = {
    "github"    = (local.source_code_manager_type == "github" ? module.scm_github.0.connector_cloud : null)
    "bitbucket" = (local.source_code_manager_type == "bitbucket" ? module.scm_bitbucket.0.connector_cloud : null)
  }

  build_farm_delegate = (
    local.support_self_hosted
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
  value       = local.support_self_hosted ? "account.${local.container_registry_id[local.container_registry_type]}" : null
}

output "build_farm_container_registry_cloud" {
  description = "The BuildFarm Container Registry Connector Id - Cloud"
  value       = local.support_harness_cloud ? "account.${local.container_registry_cloud_id[local.container_registry_type]}" : null
}

output "build_farm_source_code_manager" {
  description = "The BuildFarm Source Code Manager Connector Id"
  value       = local.support_self_hosted ? "account.${local.source_code_manager_id[local.source_code_manager_type]}" : null
}

output "build_farm_source_code_manager_cloud" {
  description = "The BuildFarm Source Code Manager Connector Id - Cloud"
  value       = local.support_harness_cloud ? "account.${local.source_code_manager_cloud_id[local.source_code_manager_type]}" : null
}
