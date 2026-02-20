output "harness_platform_pipeline_id" {
  value       = harness_platform_pipeline.this.id
  description = "The ID of the created pipeline."
}

output "harness_platform_trigger_id" {
  value       = harness_platform_triggers.this.id
  description = "The ID of the created trigger."
}

