resource "harness_platform_triggers" "push_trigger" {
  identifier  = "Push_Trigger"
  name        = "Push Trigger"
  target_id   = harness_platform_pipeline.pipeline.id
  org_id      = data.harness_platform_organization.selected.id
  project_id  = data.harness_platform_project.selected.id
  description = "This trigger will fire when a push event is received."
  yaml = templatefile(
    "${path.module}/templates/pipelines/triggers/trigger_Repo.yaml",
    {
      # Trigger Setup Details
      TRIGGER_IDENTIFIER : "Push_Trigger"
      TRIGGER_NAME : "Push Trigger"
      PIPELINE_IDENTIFIER : harness_platform_pipeline.pipeline.id
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id
      DESCRIPTION : "This trigger will fire when a push event is received."

      WEBHOOK_TEMPLATE = templatefile(
        "${path.module}/templates/pipelines/triggers/snippets/snp_harness_webhook_push.yaml",
        {
          REPOSITORY_PATH : harness_platform_repo.hcr.id
          TARGET_BRANCH : "all"
          MAIN_BRANCH : harness_platform_repo.hcr.default_branch
        }
      )

      INPUT_SET : harness_platform_input_set.defaults.id

      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}

resource "harness_platform_triggers" "pr_trigger" {
  identifier  = "PullRequest_Trigger"
  name        = "PullRequest Trigger"
  target_id   = harness_platform_pipeline.pipeline.id
  org_id      = data.harness_platform_organization.selected.id
  project_id  = data.harness_platform_project.selected.id
  description = "This trigger will fire when a PullRequest event is received."
  yaml = templatefile(
    "${path.module}/templates/pipelines/triggers/trigger_Repo.yaml",
    {
      # Trigger Setup Details
      TRIGGER_IDENTIFIER : "PullRequest_Trigger"
      TRIGGER_NAME : "PullRequest Trigger"
      PIPELINE_IDENTIFIER : harness_platform_pipeline.pipeline.id
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id
      DESCRIPTION : "This trigger will fire when a PullRequest event is received."

      WEBHOOK_TEMPLATE = templatefile(
        "${path.module}/templates/pipelines/triggers/snippets/snp_harness_webhook_pr.yaml",
        {
          REPOSITORY_PATH : harness_platform_repo.hcr.id
        }
      )

      INPUT_SET : harness_platform_input_set.pull_requests.id

      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}

resource "harness_platform_triggers" "deploy_trigger" {
  identifier  = "Deploy_Trigger"
  name        = "Deploy Trigger"
  target_id   = harness_platform_pipeline.pipeline.id
  org_id      = data.harness_platform_organization.selected.id
  project_id  = data.harness_platform_project.selected.id
  description = "This trigger will fire when a push event is received for Default Branch - ${harness_platform_repo.hcr.default_branch}."
  yaml = templatefile(
    "${path.module}/templates/pipelines/triggers/trigger_Repo.yaml",
    {
      # Trigger Setup Details
      TRIGGER_IDENTIFIER : "Deploy_Trigger"
      TRIGGER_NAME : "Deploy Trigger"
      PIPELINE_IDENTIFIER : harness_platform_pipeline.pipeline.id
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id
      DESCRIPTION : "This trigger will fire when a push event is received for Default Branch - ${harness_platform_repo.hcr.default_branch}."

      WEBHOOK_TEMPLATE = templatefile(
        "${path.module}/templates/pipelines/triggers/snippets/snp_harness_webhook_push.yaml",
        {
          REPOSITORY_PATH : harness_platform_repo.hcr.id
          TARGET_BRANCH : harness_platform_repo.hcr.default_branch
          MAIN_BRANCH : harness_platform_repo.hcr.default_branch
        }
      )

      INPUT_SET : harness_platform_input_set.deployment.id

      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}
