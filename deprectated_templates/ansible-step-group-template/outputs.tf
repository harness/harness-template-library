locals {
  template_urls = [for template in harness_platform_template.ansible : join(
    "/",
    [
      replace(var.harness_platform_url, "/gateway", "/ng"),
      "account",
      var.harness_platform_account,
      "all/settings/templates",
      template.id,
      "template-studio/StepGroup/?versionLabel=${template.version}",
    ]
  )]
}

output "template_urls" {
  value       = local.template_urls
  description = "Links to all created templates"
}