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
  # This example helper constructs an automatic identifier based on the provided variable
  # name. This variable can be referenced as `local.fmt_identifier` and automate identifiers
  # to match Harness standards.
  ####################
  # fmt_identifier = (
  #   var.project_id == null
  #   ?
  #   replace(
  #     replace(
  #       var.project_name,
  #       " ",
  #       "_"
  #     ),
  #     "-",
  #     "_"
  #   )
  #   :
  #   var.project_id
  # )

  ##

  ####################
  # This example helper constructs an automatic identifier prefix based on the hierarchy of
  # resource. This variable can be referenced as `local.tier_handler` along with the resource_id
  # to provide the full reference.
  ####################
  # tier_handler = (
  #   var.project_id != null
  #   ?
  #   ""
  #   :
  #   var.organization_id != null
  #   ?
  #   "org."
  #   :
  #   "account."
  # )

}
