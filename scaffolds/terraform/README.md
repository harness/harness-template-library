# Harness Solutions Factory Scaffold

_Enter a brief at a glance description of the purpose for this set of templates_

## Summary
### TODO: Remove this line after reviewing and updating the summary
_Document the overall use case and scenario for which this template would be used, including a bullet list of resources created_

This Template will created the following resources:
- _Provide a list_


## Providers
### TODO: Remove this line after reviewing and updating the providers detail
This template is designed to be used as a Terraform Module. To leverage this module, an Harness provider configuration must be added to the calling template as defined by the [Harness Provider - Docs](https://registry.terraform.io/providers/harness/harness/latest/docs).

To aid in the setup and use of this module, we have added a file to the root of this repository called `providers.tf.example`. This file can be used as the basis for configuring your own `providers.tf` file for the calling template

_**Note**: If using this as module as a template, be sure to copy the provider sample file from the root of the repository into this directory prior to execution._
- Save a copy of the file as `providers.tf`
- Either configure the variables as defined or use their corresponding variables.

_**Note**: The gitignore file in this repository explicitly ignores any file called `providers.tf` from commits and changes._

### Terraform required providers declaration
#### TODO: Remove this line after reviewing and updating the providers version detail
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
### TODO: Remove this line after reviewing and updating any pre-requisites or requirements

The following items must be preconfigured in the target Harness Account
- _Provide a list_

## Variables
### TODO: Remove this line after reviewing and updating all terraform variable details

_Note: When providing `_ref` values, please ensure that these are prefixed with the correct location details depending if the connector is at the Organization (org.) or Account (account.) levels.  For Project Connectors, nothing else is required excluding the reference ID for the connector._

| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| harness_platform_url | | Enter the Harness Platform URL.  Defaults to Harness SaaS URL | string | https://app.harness.io/gateway |
| harness_platform_account | X | Enter the Harness Platform Account Number | string ||
| harness_platform_key | X | Enter the Harness Platform API Key for your account | string ||
| tags | | Provide a Map of Tags to associate with the resources | map(any) |{}|


## Terraform TFVARS
### TODO: Remove this line after reviewing and updating the terraform.tfvars.example file with correct information

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Outputs
### TODO: Remove this line after reviewing and updating any output variable information

| Name | Description | Type |
| --- | --- | --- |

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
