output "connector" {
  value = var.support_self_hosted ? harness_platform_connector_nexus.artifact_manager[0].id : null
}