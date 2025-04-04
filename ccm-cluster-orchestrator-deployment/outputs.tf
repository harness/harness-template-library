output "harness_platform_connector_helm" {
  value       = harness_platform_connector_helm.cluster_orchestrator.id
  description = "Helm connector created for controller Helm chart"
}

output "harness_platform_service" {
  value       = harness_platform_service.cluster_orchestrator.id
  description = "CD service created to deploy controllers"
}