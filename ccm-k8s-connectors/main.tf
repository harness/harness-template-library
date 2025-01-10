resource "harness_platform_connector_kubernetes" "this" {
  identifier  = local.identifier
  name        = local.name
  description = var.description
  tags        = local.common_tags_tuple

  inherit_from_delegate {
    delegate_selectors = [var.delegate_name]
  }
}

resource "harness_platform_connector_kubernetes_cloud_cost" "this" {
  identifier  = "${local.identifier}_ccm"
  name        = "${local.name}_ccm"
  description = var.description
  tags        = local.common_tags_tuple

  features_enabled = compact(["VISIBILITY", (var.enable_optimization ? "OPTIMIZATION" : null)])
  connector_ref    = harness_platform_connector_kubernetes.this.id
}