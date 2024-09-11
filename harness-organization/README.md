# Harness Project Onboarding

A terraform template designed to create and manage a Harness projects

## Summary

The Harness Project Onboarding template is designed to create and manage Harness Projects. This template will build and deliver the following:

- New Harness Organization
- [Optional] New standard RBAC configurations:
    - Harness Groups with optional SSO mapping
    - Harness RBAC Roles and Resource Group
    - Harness RBAC Bindings
- [Optional] New Harness Environments


## Providers

This template requires that the calling template has defined the [Harness Provider - Docs](https://registry.terraform.io/providers/harness/harness/latest/docs) authentication.

### Example setup of the Harness Provider

```
# Provider Setup Details
variable "harness_platform_url" {
  type        = string
  description = "Enter the Harness Platform URL.  Defaults to Harness SaaS URL"
  default     = "https://app.harness.io/gateway"
}

variable "harness_platform_account" {
  type        = string
  description = "Enter the Harness Platform Account Number"
}

variable "harness_platform_key" {
  type        = string
  description = "Enter the Harness Platform API Key for your account"
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
| harness_platform_key | X | Enter the Harness Platform API Key for your account | string ||
| organization_id || New Organization Identifier. If not provided, then the organization_name will be formatted to replace spaces and dashes with underscores | string | null |
| organization_name | X | New Organization Name | string ||
| organization_description || New Organnization Description | string | "Harness Organnization managed by Solutions Factory" |
| tags | | Provide a Map of Tags to associate with the resources | map(any) |{}|


## Terraform TFVARS

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Outputs

| Name | Description | Type |
| --- | --- | --- |
| organization_identifier | Hosting Organization Identifier | string |
| organizationt_url | Harness Organization URL | string |

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
