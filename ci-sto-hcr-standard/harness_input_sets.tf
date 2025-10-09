resource "harness_platform_input_set" "defaults" {
  identifier  = "Default_Inputs"
  name        = "Default Inputs"
  pipeline_id = harness_platform_pipeline.pipeline.id
  org_id      = data.harness_platform_organization.selected.id
  project_id  = data.harness_platform_project.selected.id
  description = "Standard input set"
  yaml = templatefile(
    "${path.module}/templates/pipelines/input_sets/default.yaml",
    {
      INPUTSET_IDENTIFIER : "Default_Inputs"
      INPUTSET_NAME : "Default Inputs"
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id
      DESCRIPTION : "Standard input set"
      PIPELINE_IDENTIFIER : harness_platform_pipeline.pipeline.id
      TARGET_BRANCH : "skipped"
      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}

resource "harness_platform_input_set" "pull_requests" {
  identifier  = "PullRequest_Inputs"
  name        = "PullRequest Inputs"
  pipeline_id = harness_platform_pipeline.pipeline.id
  org_id      = data.harness_platform_organization.selected.id
  project_id  = data.harness_platform_project.selected.id
  description = "Standard input set for use with Pull Request Configurations"
  yaml = templatefile(
    "${path.module}/templates/pipelines/input_sets/pull_requests.yaml",
    {
      INPUTSET_IDENTIFIER : "PullRequest_Inputs"
      INPUTSET_NAME : "PullRequest Inputs"
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id
      DESCRIPTION : "Standard input set for use with Pull Request Configurations"
      PIPELINE_IDENTIFIER : harness_platform_pipeline.pipeline.id
      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}

resource "harness_platform_input_set" "deployment" {
  identifier  = "Deployment_Inputs"
  name        = "Deployment Inputs"
  pipeline_id = harness_platform_pipeline.pipeline.id
  org_id      = data.harness_platform_organization.selected.id
  project_id  = data.harness_platform_project.selected.id
  description = "Standard input set for Main Branch execution"
  yaml = templatefile(
    "${path.module}/templates/pipelines/input_sets/default.yaml",
    {
      INPUTSET_IDENTIFIER : "Deployment_Inputs"
      INPUTSET_NAME : "Deployment Inputs"
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id
      DESCRIPTION : "Standard input set for Main Branch execution"
      PIPELINE_IDENTIFIER : harness_platform_pipeline.pipeline.id
      TARGET_BRANCH : harness_platform_repo.hcr.default_branch
      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}
