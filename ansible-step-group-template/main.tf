resource "harness_platform_template" "ansible" {
  for_each   = toset(var.template_types)
  identifier = "${each.key}_${local.fmt_template_name}"
  name       = "${each.key} ${var.template_name}"
  comments   = "Run ansible playbook"
  tags       = local.common_tags_tuple
  version    = var.template_version
  is_stable  = true
  template_yaml = templatefile(
    "${path.module}/templates/step_groups/ansible.yaml",
    {
      TEMPLATE_IDENTIFIER : "${each.key}_${local.fmt_template_name}"
      TEMPLATE_NAME : "${each.key} ${var.template_name}"
      TEMPLATE_DESCRIPTION : "Run ansible playbook"
      TEMPLATE_VERSION : var.template_version
      TAGS : yamlencode(local.common_tags)

      TEMPLATE_STAGE_TYPE : each.key

      HARNESS_CODE : var.harness_code

      GROUP_INFRASTRUCTURE : templatefile(
        "${path.module}/templates/step_groups/snippets/step_group_infra.yaml",
        {
          KUBERNETES_CONNECTOR : var.kubernetes_connector == "skipped" ? "<+input>" : var.kubernetes_connector
          KUBERNETES_NAMESPACE : var.kubernetes_namespace == "skipped" ? "<+input>" : var.kubernetes_namespace
          KUBERNETES_NODESELECTORS : length(var.kubernetes_node_selectors) > 0 ? yamlencode(var.kubernetes_node_selectors) : "skipped"
          KUBERNETES_IMAGE_CONNECTOR : var.kubernetes_override_image_connector
        }
      )

      DOCKER_CONNECTOR : var.docker_connector
      IMAGE : var.image
    }
  )
}