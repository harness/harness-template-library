output "template" {
  value       = harness_platform_template.create_autostopping_resource.id
  description = "Kubectl step template ID"
}

output "pipeline" {
  value       = harness_platform_pipeline.add_autostopping_variables.id
  description = "Pipeline ID"
}
