########################
# Governance Policy for Harness Templates
#
# This policy will enforce that all Harness Templates created will adhere to a
# strict naming convention for template versions.
#
# The policy requires that all Harness Templates have a version starting with a 'v' followed by
# a whole number.
#
########################

package template

#### BEGIN - Policy Controls ####
version_format = "^v[0-9]*$"

error_msg = [
    "The version (%s) of this template does not match the supported version format.",
    "The policy requires that all Harness Templates have a version starting with a",
    "lowercase letter 'v' and followed by a whole number. Semantic versions should",
    "be used."
]
#### END   - Policy Controls ####

#### BEGIN - Policy Evaluation ####
deny[msg] {
  template_version = input.template.versionLabel
  not regex.match(version_format, template_version)

  msg := sprintf(concat(" ", error_msg),[template_version])
}
#### END   - Policy Evaluation ####
