# Harness Solutions Factory Scaffold
_Register a repository to be scanned by Harness Securtity Test Orchestration module_

## Summary

The execution of this template will create a new pipeline in the chosen project.  This pipeline will leverage the Stage Template `sta_STO_SAST_SCA_Primer` deployed as an account template.  This pipeline will connect a source code repository into the Harness Security Test Orchestration module within Harness to begin scans using the configured scanners.

This Template will deploy the following resources:
- New pipeline using account level stage template - sta_STO_SAST_SCA_Primer
- Optional Harness Pipeline trigger


## Providers
This template is designed to be used as a Terraform Module. To leverage this module, an Harness provider configuration must be added to the calling template as defined by the [Harness Provider - Docs](https://registry.terraform.io/providers/harness/harness/latest/docs).

To aid in the setup and use of this module, we have added a file to the root of this repository called `providers.tf.example`. This file can be used as the basis for configuring your own `providers.tf` file for the calling template

_**Note**: If using this as module as a template, be sure to copy the provider sample file from the root of the repository into this directory prior to execution._
- Save a copy of the file as `providers.tf`
- Either configure the variables as defined or use their corresponding variables.

_**Note**: The gitignore file in this repository explicitly ignores any file called `providers.tf` from commits and changes._

### Terraform required providers declaration
_Include details about any provided with which this template will have a dependency_

```
terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
      version = ">= 0.31"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.1"
    }
  }
}

```

## Requirements

The following items must be preconfigured in the target Harness Account
- Requires full deployment and configuration of the Harness Solutions Factory Solution - STO_SAST_PRIMER

## Variables

_Note: When providing `_ref` values, please ensure that these are prefixed with the correct location details depending if the connector is at the Organization (org.) or Account (account.) levels.  For Project Connectors, nothing else is required excluding the reference ID for the connector._

| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| harness_platform_url | | Enter the Harness Platform URL.  Defaults to Harness SaaS URL | string | https://app.harness.io/gateway |
| harness_platform_account | X | Enter the Harness Platform Account Number | string ||
| harness_platform_key | X | Enter the Harness Platform API Key for your account | string ||
| tags | | Provide a Map of Tags to associate with the resources | map(any) |{}|
| organization_id | X | Provide an existing organization reference ID.  Must exist before execution | string | |
| project_id | X | | st Provide an existing project reference ID.  Must exist before executionring | |
| repository_name | X | Provide the repository name. This value will be used to configure the pipeline | string | |
| repository_path | X | Provide the repository path. This value will be used to configure the source code for pipeline | string | |
| repository_connector_ Provide the repository connector. When 'null', the pipeline will be configured to use Harness Code Repository for the pipeline source coderef | X | | string | null |
| branches | | When configured for 'all' or a specific branches, new pipeline triggers will be added to execute the pipeline when updates are made to branches | string | "skipped" |
| webhook_type | X |# Must be one of the following - harness/github/bitbucket | string | |


## Terraform TFVARS
### TODO: Remove this line after reviewing and updating the terraform.tfvars.example file with correct information

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Outputs

| Name | Description | Type |
| --- | --- | --- |
| pipeline_url | Pipeline URL to edit | string |
| pipeline_executions_url | Pipeline URL to execution history | string |
| pipeline_identifier | Pipeline Identifier | string |

## Contributing

A complete [Contributors Guide](../../../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../../../LICENSE) for full details.
