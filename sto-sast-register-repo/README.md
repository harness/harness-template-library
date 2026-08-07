# Register Repository for STO Module

This module creates pipelines to register repositories for scanning using the Harness Security Test Orchestration (STO) module. It is designed to be used through the Harness IDP catalog workflow system.

## Usage via IDP Catalog

This module is primarily used through the Harness Internal Developer Portal (IDP) catalog workflow:

1. **Deploy STO Templates**: First run the main `sto-sast-primer` catalog template to deploy STO scanning templates
2. **Register Repository**: Use the `sto-sast-register-repo` catalog template to register individual repositories for scanning

### IDP Workflow Process

1. Navigate to Harness IDP Catalog
2. Find "Register Repository for STO Scanning" template
3. Fill in repository configuration:
   - Organization and Project
   - Repository name and path
   - Repository connector details
   - Branch configuration
4. Execute workflow through IACM

## Direct Terraform Usage (Advanced)

For advanced users who want to use Terraform directly:

```hcl
module "repository_scanning" {
  source = "./sto-sast-register-repo"

  organization_id          = "your_org_id"
  project_id               = "your_project_id"
  repository_name          = "my-application"
  repository_path          = "my-org/my-app"
  repository_connector_ref = "account.my_git_connector"
  branches                 = "all"
  webhook_type             = "github"

  tags = {
    environment = "production"
    team        = "security"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| harness_platform_url | Enter the Harness Platform URL. Defaults to Harness SaaS URL | string | https://app.harness.io/gateway | no |
| harness_platform_account | Enter the Harness Platform Account Number | string || yes |
| organization_id | The Organization ID where the pipeline will be created | string || yes |
| project_id | The Project ID where the pipeline will be created | string || yes |
| repository_name | The name of the repository to scan | string || yes |
| repository_path | Provide the repository path. This value will be used to configure the source code for pipeline | string || yes |
| repository_connector_ref | Provide the repository connector. When 'skipped', the pipeline will be configured to use Harness Code Repository | string | skipped | no |
| branches | When configured for 'all' or a specific branch, a new pipeline trigger will be added to execute scanning when updates are made to branches | string | skipped | no |
| webhook_type | Provide a supported webhook type. Must be one of the following: harness, github, or bitbucket | string || yes |
| tags | Tags to apply to resources | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| pipeline_identifier | The ID of the created pipeline |
| pipeline_url | URL to the pipeline studio |
| pipeline_executions_url | URL to the pipeline execution screen |

## Features

- **STO Integration**: Uses Harness Security Test Orchestration for automated scanning
- **Stage Template-Based**: Leverages account-level stage template for consistency
- **Optional Triggers**: Initial trigger is included and more can be managed separately through Harness UI
- **IDP Integration**: Designed for use with Harness Internal Developer Portal
- **IACM Compatible**: Works with Harness Infrastructure as Code Management

## Prerequisites

The following items must be preconfigured in the target Harness Account:
- Harness Solutions Factory STO SAST/SCA Primer solution deployed and configured
- Security scanners configured in your Harness instance

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
