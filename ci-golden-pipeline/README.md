# Register Pipeline Module

This module creates individual CI pipelines using the Golden Standard templates. It is designed to be used through the Harness IDP catalog workflow system.

## Usage via IDP Catalog

This module is primarily used through the Harness Internal Developer Portal (IDP) catalog workflow:

1. **Deploy Golden Standards**: First run the main `ci-golden-standards` catalog template to deploy all templates
2. **Create Pipeline**: Use the `ci-golden-standards-register-pipeline` catalog template to create individual pipelines

### IDP Workflow Process

1. Navigate to Harness IDP Catalog
2. Find "Create CI Pipeline using Golden Standards" template
3. Fill in pipeline configuration:
   - Organization and Project
   - Pipeline name
   - Repository details
4. Execute workflow through IACM

## Direct Terraform Usage (Advanced)

For advanced users who want to use Terraform directly:

```hcl
module "my_pipeline" {
  source = "./ci-golden-pipeline"

  organization_id          = "your_org_id"
  project_id               = "your_project_id"
  pipeline_name            = "My Application Pipeline"
  repository_connector_ref = "account.my_git_connector"
  repository_path          = "my-org/my-app"
  branches                 = "all"
  webhook_type             = "github"

  tags = {
    environment = "production"
    team        = "platform"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| harness_platform_url | Enter the Harness Platform URL.  Defaults to Harness SaaS URL | string | https://app.harness.io/gateway | no |
| harness_platform_account | Enter the Harness Platform Account Number | string || yes |
| organization_id | The Organization ID where the pipeline will be created | string || yes |
| project_id | The Project ID where the pipeline will be created | string || yes |
| template_organization_id | The Organization ID where the Template exists | string | null | no |
| template_project_id | The Project ID where the Template exists | string | null | no |
| tags | Tags to apply to resources | map(string) | {} | no |
| pipeline_name | The name of the pipeline to create | string || yes |
| repository_connector_ref | Provide the repository connector. When 'skipped', the pipeline will be configured to use Harness Code Repository for the pipeline source code | string | skipped | no |
| repository_path | Provide the repository path. This value will be used to configure the source code for pipeline | string || yes |
| branches | When configured for 'all' or a specific branch, a new pipeline trigger will be added to execute the pipeline when updates are made to branches | string | skipped | no |
| webhook_type | Provide a supported webhook type. Provide a supported webhook type. Must be one of the following: harness, github, or bitbucket | string || yes |

## Outputs

| Name | Description |
|------|-------------|
| pipeline_identifier | The ID of the created pipeline |
| pipeline_url | Url to the pipeline studio |
| pipeline_executions_url | Url to the pipeline execution screen |
| pipeline_input_set | Url to the pipeline input set |

## Features

- **Template-Based Pipeline**: Uses Golden Standard templates for consistency
- **Default Input Set**: An initial Trigger is included and more can be managed separately through Harness UI or other workflows
- **Optional Triggers**: An Initial Trigger is included and more can be managed separately through Harness UI or other workflows
- **IDP Integration**: Designed for use with Harness Internal Developer Portal
- **IACM Compatible**: Works with Harness Infrastructure as Code Management
