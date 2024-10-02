
resource "harness_platform_connector_kubernetes" "buildfarm" {
  count       = local.support_self_hosted ? 1 : 0
  identifier  = "buildfarm_infrastructure"
  name        = "BuildFarm Infrastructure"
  description = "Centralized Build Farm Connector for CI Builds"
  tags = flatten([
    ["required_for:buildfarm_infrastructure"],
    local.common_tags_tuple
  ])

  inherit_from_delegate {
    delegate_selectors = ["build-farm"]
  }
}
