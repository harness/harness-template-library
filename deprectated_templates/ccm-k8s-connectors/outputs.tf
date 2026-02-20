output "k8s_connector_id" {
  value       = harness_platform_connector_kubernetes.this.id
  description = "The created kubernetes connector id"
}

output "ccm_k8s_connector_id" {
  value       = harness_platform_connector_kubernetes_cloud_cost.this.id
  description = "The created ccm kubernetes connector id"
}