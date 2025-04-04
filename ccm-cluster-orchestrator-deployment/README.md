# CCM Cluster Orchestrator Deployment

A Harness CD service for deploying the CCM Cluster Orchestrator controller

## Summary

This template will provision all suporting Harness resources needed to deploy the service into an EKS cluster. A connector for the Helm repo, a values file, and a service definition

This Template will created the following resources:
- harness_platform_connector_helm
- harness_platform_file_store_file
- harness_platform_service


## Providers
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
  }
}

```

## Requirements

The following items must be preconfigured in the target Harness Account
- Docker Connector

## Variables

_Note: When providing `_ref` values, please ensure that these are prefixed with the correct location details depending if the connector is at the Organization (org.) or Account (account.) levels.  For Project Connectors, nothing else is required excluding the reference ID for the connector._

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| docker\_connector | [Optional] Docker connector ID for pulling orchestrator image | `string` | `"account.harnessImage"` | no |
| harness\_platform\_account | [Required] Enter the Harness Platform Account Number | `string` | n/a | yes |
| harness\_platform\_url | [Optional] Enter the Harness Platform URL.  Defaults to Harness SaaS URL | `string` | `"https://app.harness.io/gateway"` | no |
| image | [Optional] Orchestrator docker image to use. Must follow repo/image format | `string` | `"harness/cluster-orchestrator"` | no |
| organization\_id | [Optional] The organization where the resources will live, leave blank for account level. Provide an existing organization reference ID.  Must exist before execution | `string` | `null` | no |
| project\_id | [Optional] The project where the resources will live, leave blank for organization or account level. Provide an existing project reference ID.  Must exist before execution | `string` | `null` | no |
| service\_name | [Optional] Enter the name of the service | `string` | `"Cluster Orchestrator"` | no |
| tags | [Optional] Provide a Map of Tags to associate with the resources | `map(any)` | `{}` | no |


## Terraform TFVARS

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Outputs

| Name | Description |
|------|-------------|
| harness\_platform\_connector\_helm | Helm connector created for controller Helm chart |
| harness\_platform\_service | CD service created to deploy controllers |

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
