locals {
  required_tags = {
    created_by : "Terraform"
    harnessSolutionsFactory : "true"
    purpose : "buildfarm"
  }

  common_tags = local.required_tags

  # Harness Tags are read into Terraform as a standard Map entry but needs to be
  # converted into a list of key:value entries
  common_tags_tuple = [for k, v in local.common_tags : "${k}:${v}"]

  container_registry_type  = lower(var.container_registry_type)
  source_code_manager_type = lower(var.source_code_manager_type)

  delegate_selectors = (
    var.use_self_hosted
    ?
    ["build-farm"]
    :
    null
  )

}
