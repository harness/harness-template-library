# Harness Central Build Farm Setup

A terraform template designed to configure a standard set of Build Farm connectors and secrets

## Summary

The Harness Central Build Farm Setup will create the following connector:

- BuildFarm Infrastructure - Delagate Auth based Kubernetes Connector - Only valid when `use_self_hosted == true`
- BuildFarm Container Registry - Standard container registry configuration based on the chosen registry type `container_registry_type`
- BuildFarm Source Code Manager - Stabdard SCM connector configuration based on the chosen SCM type `source_code_manager_type`

## Providers

This template requires that the calling template has defined the [Harness Provider - Docs](https://registry.terraform.io/providers/harness/harness/latest/docs) authentication.

### Example setup of the Harness Provider Authentication with environment variables

You can also set up authentication with Harness through environment variables. To do this set the following items in your environment:
- HARNESS_ACCOUNT_ID: Harness Platform Account Number
- HARNESS_PLATFORM_API_KEY: Harness Platform API Key for your account

_Note: The use of the HARNESS_ENDPOINT environment variable is not used as the variable `harness_platform_url` is a required input for some of the resource creation steps and cannot be read within the execution except by explicit declaration of the variables value_

### Example setup of the Harness Provider

```
# Provider Setup Details
variable "harness_platform_url" {
  type        = string
  description = "[Optional] Enter the Harness Platform URL.  Defaults to Harness SaaS URL"
  default     = "https://app.harness.io/gateway"
}

variable "harness_platform_account" {
  type        = string
  description = "[Required] Enter the Harness Platform Account Number"
  default     = null # If Not passed, then the ENV HARNESS_ACCOUNT_ID will be used
  sensitive   = true
}

variable "harness_platform_key" {
  type        = string
  description = "[Required] Enter the Harness Platform API Key for your account"
  default     = null # If Not passed, then the ENV HARNESS_PLATFORM_API_KEY will be used
  sensitive   = true
}

provider "harness" {
  endpoint         = var.harness_platform_url
  account_id       = var.harness_platform_account
  platform_api_key = var.harness_platform_key
}

```

### Terraform required providers declaration

```
terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
      version = ">= 0.24"
    }
  }
}

```

## Requirements

The following items must be preconfigured in the target Harness Account
- Harness Service Account with an API Key stored as a secret

## Variables

_Note: When providing `_ref` values, please ensure that these are prefixed with the correct location details depending if the connector is at the Organization (org.) or Account (account.) levels.  For Project Connectors, nothing else is required excluding the reference ID for the connector._

| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| harness_platform_url | | Enter the Harness Platform URL.  Defaults to Harness SaaS URL | string | https://app.harness.io/gateway |
| harness_platform_account | | Enter the Harness Platform Account Number | string | null # If Not passed, then the ENV HARNESS_ACCOUNT_ID will be used ||
| harness_platform_key | | Enter the Harness Platform API Key for your account | string | null # If Not passed, then the ENV HARNESS_PLATFORM_API_KEY will be used | |
| use_self_hosted | | Configure a Kubernetes Connector for use as a Centralized Build Farm | bool | true |
| container_registry_type | | What type of Container Registry Connector type will be used as the default Build Farm Registry. Supported Values - docker, artifactory | string | docker |
| container_registry_url | | What type of Container Registry Connector type will be used as the default Build Farm Registry | string | https://registry.hub.docker.com/v2/ |
| source_code_manager_type | | type of Source Code Manager Connector type will be used as the default Build Farm SCM. Supported Values - github, bitbucket | string | github |
| source_code_manager_url | X | Please provide the default URL for the Connector - e.g. https://github.com | string | |
| source_code_manager_validation_repo | X | provide the validation URL for the Connector - e.g. harness/terraform-provider-harness | string | |


## Terraform TFVARS

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Outputs
| Name | Type | Description |
| --- | --- | --- |
| build_farm_connector | string | If using self-hosted build farm, this output contains the details of the BuildFarm Infrastructure connector |
| build_farm_container_registry | string | The BuildFarm Container Registry Connector Id |
| build_farm_source_code_manager | string | The BuildFarm Source Code Manager Connector Id |
| Next-Steps | multiline | Details the Next Steps to take after deployment |

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
