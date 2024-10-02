output "connector" {
  value = var.support_self_hosted ? harness_platform_connector_docker.container_registry[0].id : null
}
output "connector_cloud" {
  value = var.support_harness_cloud ? harness_platform_connector_docker.container_registry_cloud[0].id : null
}
