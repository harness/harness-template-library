# Harness Project Onboarding

A terraform template designed to create and manage a Harness projects

## Summary

The Harness Project Onboarding template is designed to create and manage Harness Projects. This template will build and deliver the following:

- New Harness Project
- New standard RBAC configurations:
    - Harness Groups with optional SSO mapping
    - Harness RBAC Roles and Resource Group
    - Harness RBAC Bindings
- New Harness Environments
    - Dev
    - Test
    - Prod


## Providers
This template is designed to be used as a Terraform Module. To leverage this module, an Harness provider configuration must be added to the calling template as defined by the [Harness Provider - Docs](https://registry.terraform.io/providers/harness/harness/latest/docs).

To aid in the setup and use of this module, we have added a file to the root of this repository called `providers.tf.example`. This file can be used as the basis for configuring your own `providers.tf` file for the calling template

_**Note**: If using this as module as a template, be sure to copy the provider sample file from the root of the repository into this directory prior to execution._
- Save a copy of the file as `providers.tf`
- Either configure the variables as defined or use their corresponding variables.

_**Note**: The gitignore file in this repository explicitly ignores any file called `providers.tf` from commits and changes._

### Terraform required providers declaration

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
- Organization to which to deploy the solution

## Variables

_Note: When providing `_ref` values, please ensure that these are prefixed with the correct location details depending if the connector is at the Organization (org.) or Account (account.) levels.  For Project Connectors, nothing else is required excluding the reference ID for the connector._

| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| harness_platform_url | | Enter the Harness Platform URL.  Defaults to Harness SaaS URL | string | null # If Not passed, then the ENV HARNESS_ENDPOINT will be used or the default value of https://app.harness.io/gateway |
| harness_platform_account | X | Enter the Harness Platform Account Number | string ||
| organization_id | X | Provide an organization reference ID.  Must exist before execution | string | |
| project_id || New Project Identifier. If not provided, then the project_name will be formatted to replace spaces and dashes with underscores | string |null|
| project_name | X | New Project Name | string ||
| project_description | | New Project Description | string | Harness Project managed by Solutions Factory |
| tags | | Provide a Map of Tags to associate with the resources | map(any) |{}|


## Terraform TFVARS

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Outputs

| Name | Description | Type |
| --- | --- | --- |
| organization_identifier | Hosting Organization Identifier | string |
| project_identifier | Newly Created Project Identifier | string |
| project_url | Harness Project URL | string |

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
