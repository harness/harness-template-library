output "connector" {
  value = var.support_self_hosted ? harness_platform_connector_rancher.container_registry[0].id : null
}