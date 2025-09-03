locals {
  required_tags = {
    created_by : "Terraform"
    harnessSolutionsFactory : "true"
    managedResource : "true"
  }

  ####################
  # When declaring tags on a resource parameter and including YAML, the
  # same tags need to be included in the yaml.  This can be done by refering
  # to this local variable - yamlencode(local.common_tags)
  #
  # Note: your yaml will need to include this if it is an inline yaml or
  # replace the `yamlencode(local.common_tags)` with $TAGS if this is a
  # template_file
  # tags:
  #     ${indent(4, yamlencode(local.common_tags))}
  ####################
  common_tags = merge(
    var.tags,
    local.required_tags
  )

  ####################
  # Harness Tags are read into Terraform as a standard Map entry but needs to be
  # converted into a list of key:value entries when declared as a parameter for
  # the resource.
  ####################
  common_tags_tuple = [for k, v in local.common_tags : "${k}:${v}"]

  tier_handler = (
    var.project_id != null
    ?
    ""
    :
    var.organization_id != null
    ?
    "org."
    :
    "account."
  )

  # Common template variables
  common_template_vars = {
    ORGANIZATION_ID = var.organization_id != null ? data.harness_platform_organization.this[0].id : null
    PROJECT_ID      = var.project_id != null ? data.harness_platform_project.this[0].id : null
  }

  # Infrastructure configuration
  infrastructure_config = {
    KUBERNETES_CONNECTOR       = var.kubernetes_connector
    KUBERNETES_NAMESPACE       = var.kubernetes_namespace
    KUBERNETES_NODESELECTORS   = var.kubernetes_node_selectors != {} ? yamlencode(var.kubernetes_node_selectors) : "skipped"
    KUBERNETES_IMAGE_CONNECTOR = var.kubernetes_override_image_connector
  }

  build_farm_SCM_connector = (
    var.kubernetes_connector != "skipped"
    ?
    "account.buildfarm_source_code_manager"
    :
    "account.buildfarm_source_code_manager_cloud"
  )

  build_farm_CR_connector = (
    var.kubernetes_connector != "skipped"
    ?
    "account.buildfarm_container_registry"
    :
    "account.buildfarm_container_registry_cloud"
  )
}


