output "connector" {
  value = var.support_self_hosted ? harness_platform_connector_github.source_code_manager[0].id : null
}
output "connector_cloud" {
  value = var.support_harness_cloud ? harness_platform_connector_github.source_code_manager_cloud[0].id : null
}
