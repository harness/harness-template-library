output "connector" {
  value = var.support_self_hosted ? harness_platform_connector_helm.container_registry[0].id : null
}