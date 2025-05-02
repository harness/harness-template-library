locals {
  build_farm_id = (
    local.support_self_hosted
    ?
    "account.${harness_platform_connector_kubernetes.buildfarm.0.id}"
    :
    null
  )

  output_container_registry_type = (
    contains(local.generic_container_registry_types, local.container_registry_type)
    ?
    "docker"
    :
    local.container_registry_type
  )

  container_registry_id = {
    "docker" = (local.output_container_registry_type == "docker" ? module.cr_docker.0.connector : null)
    "aws"    = (local.output_container_registry_type == "aws" ? module.cr_aws.0.connector : null)
    "gcp"    = (local.output_container_registry_type == "gcp" ? module.cr_gcp.0.connector : null)
    "azure"  = (local.output_container_registry_type == "azure" ? module.cr_azure.0.connector : null)
  }

  container_registry_cloud_id = {
    "docker" = (local.output_container_registry_type == "docker" ? module.cr_docker.0.connector_cloud : null)
    "aws"    = (local.output_container_registry_type == "aws" ? module.cr_aws.0.connector_cloud : null)
    "gcp"    = (local.output_container_registry_type == "gcp" ? module.cr_gcp.0.connector_cloud : null)
    "azure"  = (local.output_container_registry_type == "azure" ? module.cr_azure.0.connector_cloud : null)
  }

  source_code_manager_id = {
    "github"    = (local.source_code_manager_type == "github" ? module.scm_github.0.connector : null)
    "bitbucket" = (local.source_code_manager_type == "bitbucket" ? module.scm_bitbucket.0.connector : null)
    "gitlab"    = (local.source_code_manager_type == "gitlab" ? module.scm_gitlab.0.connector : null)
  }
  source_code_manager_cloud_id = {
    "github"    = (local.source_code_manager_type == "github" ? module.scm_github.0.connector_cloud : null)
    "bitbucket" = (local.source_code_manager_type == "bitbucket" ? module.scm_bitbucket.0.connector_cloud : null)
    "gitlab"    = (local.source_code_manager_type == "gitlab" ? module.scm_gitlab.0.connector_cloud : null)
  }

  artifact_manager_id = {
    "nexus"       = (local.artifact_manager_type == "nexus" ? module.ar_nexus.0.connector : null)
    "artifactory" = (local.artifact_manager_type == "artifactory" ? module.ar_artifactory.0.connector : null)
    "oci_helm"    = (local.artifact_manager_type == "oci_helm" ? module.ar_oci_helm.0.connector : null)
    "http_helm"   = (local.artifact_manager_type == "http_helm" ? module.ar_http_helm.0.connector : null)
  }
  artifact_manager_cloud_id = {
    "artifactory" = (local.artifact_manager_type == "artifactory" ? module.ar_artifactory.0.connector_cloud : null)
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
output "build_farm_artifact_manager" {
  description = "The BuildFarm Artifact Manager Connector Id"
  value       = local.support_self_hosted && local.artifact_manager_type != null ? "account.${local.artifact_manager_id[local.artifact_manager_type]}" : null
}
output "build_farm_artifact_manager_cloud" {
  description = "The BuildFarm Artifact Manager Connector Id - Cloud"
  value       = local.support_harness_cloud && local.artifact_manager_type != null ? lookup(local.artifact_manager_cloud_id, local.artifact_manager_type, null) != null ? "account.${local.artifact_manager_cloud_id[local.artifact_manager_type]}" : null : null
}
