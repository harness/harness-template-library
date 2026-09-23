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

  ####################
  # Currently configured default images per module, minus any excluded fields.
  # Used to seed each pipeline's variables with the live defaults.
  ####################
  default_images = { for module in var.modules : module => {
    for k, v in data.harness_platform_default_images.default[module].images : k => v
    if !contains(var.exclude_images, k)
  } }
}
