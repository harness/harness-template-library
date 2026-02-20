data "harness_platform_organization" "cluster_orchestrator" {
  count      = var.organization_id == null ? 0 : 1
  identifier = var.organization_id
}

data "harness_platform_project" "cluster_orchestrator" {
  count      = var.project_id == null ? 0 : 1
  identifier = var.project_id
  org_id     = data.harness_platform_organization.cluster_orchestrator[0].id
}

resource "harness_platform_connector_helm" "cluster_orchestrator" {
  org_id      = local.organization_id
  project_id  = local.project_id
  identifier  = "harness_cluster_orchestrator"
  name        = "Harness Cluster Orchestrator"
  description = "Harness helm chart for the cluster orchestrator"
  tags        = local.common_tags_tuple

  url = "https://lightwing-downloads.s3.ap-southeast-1.amazonaws.com/cluster-orchestrator-helm-chart"
}

resource "harness_platform_file_store_folder" "root" {
  org_id            = local.organization_id
  project_id        = local.project_id
  identifier        = local.fmt_service_name
  name              = var.service_name
  parent_identifier = "Root"
  tags              = local.common_tags_tuple
}

resource "harness_platform_file_store_file" "values" {
  org_id            = local.organization_id
  project_id        = local.project_id
  identifier        = "${local.fmt_service_name}_valuesyaml"
  name              = "values.yaml"
  parent_identifier = harness_platform_file_store_folder.root.id
  file_content_path = "templates/files/values.yaml"
  mime_type         = "application/x-yaml"
  file_usage        = "MANIFEST_FILE"
  tags              = local.common_tags_tuple
}

resource "harness_platform_service" "cluster_orchestrator" {
  org_id      = local.organization_id
  project_id  = local.project_id
  identifier  = local.fmt_service_name
  name        = var.service_name
  description = "Deploy the cluster orchestrator controller into a Kubernetes cluster"
  tags        = local.common_tags_tuple

  yaml = templatefile(
    "${path.module}/templates/services/cluster_orchestrator.yaml",
    {
      SERVICE_IDENTIFIER : local.fmt_service_name
      SERVICE_NAME : var.service_name
      SERVICE_DESCRIPTION : "Deploy the cluster orchestrator controller into a Kubernetes cluster"
      TAGS : yamlencode(local.common_tags)
      ORGANIZATION_ID : local.organization_id == null ? "" : local.organization_id
      PROJECT_ID : local.project_id == null ? "" : local.project_id

      VALUES_PATH : "${harness_platform_file_store_folder.root.name}/${harness_platform_file_store_file.values.name}"

      HELM_CONNECTOR : "${local.tier_handler}${harness_platform_connector_helm.cluster_orchestrator.id}"
      DOCKER_CONNECTOR : var.docker_connector
      IMAGE : var.image
    }
  )
}
