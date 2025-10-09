# Harness Day-Zero Pipeline and Repository

_Enter a brief at a glance description of the purpose for this set of templates_

## Summary

The execution of this template will create a new pipeline in the chosen project.  This pipeline will leverage the Stage Templates `sta_STO_SAST_SCA_Primer` and `CI_GoldenStandard_Container_Template`.  In addition to the creation of the pipeline, the code will add InputSets and Triggers as well as to create a new Harness Code Repository.

This Template will deploy the following resources:
- New Harness code repository annd default branch security rules
- New pipeline using account level stage templates - sta_STO_SAST_SCA_Primer and CI_GoldenStandard_Container_Template
- Three Harness Pipeline triggers to support - Push, Pull-Request and Main Branch
- Three Harness Pipeline input_sets to support - Push, Pull-Request and Main Branch

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
- Harness Service Account with an API Key stored as a secret
- Organization and Project into which to deploy the solution
- Harness Template Library Solution - `Deploy Harness SAST & SCA Templates`
- Harness Template Library Solution - `Deploy Harness CI Golden Standard Templates`

## Variables

_Note: When providing `_ref` values, please ensure that these are prefixed with the correct location details depending if the connector is at the Organization (org.) or Account (account.) levels.  For Project Connectors, nothing else is required excluding the reference ID for the connector._

| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| harness_platform_url | | Enter the Harness Platform URL.  Defaults to Harness SaaS URL | string | https://app.harness.io/gateway |
| harness_platform_account | X | Enter the Harness Platform Account Number | string ||
| harness_platform_key | X | Enter the Harness Platform API Key for your account | string ||
| tags | | Provide a Map of Tags to associate with the resources | map(any) |{}|
| organization_id | X | # The Organization ID where the pipeline will be created | string | |
| project_id | X | # The Project ID where the pipeline will be created | string | |
| repository_name | X | # Provide the name of the Repository to create. Validation: Name must start with a letter or _ and only contain [a-zA-Z0-9-_.] | string | |
| repository_description |  | # Provide the Description for the Repository | string | |
| repository_rule_is_active |  | # When 'active' will enforce repository rules preventing changes except by CODEOWNERS. Valid Options: active, disabled, monitor | string | active |
| repository_merge_strategies |  | # Limit which merge strategies are available to merge a pull request. Valid Options: fast-forward, merge, rebase, squash | list(string) | [] |

## Terraform TFVARS

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

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
