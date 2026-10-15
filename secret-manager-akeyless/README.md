# Secret Manager: Akeyless

A custom secret manager template for connecting to Akeyless (akeyless.io).

## Summary

Create a template for accessing secrets from Akeyless, to be used to access secrets using a custom secret manager connector.

This Template will created the following resources:
- harness_platform_template

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
  required_version = ">= 1.10.0, < 2.0.0"
  required_providers {
    // Harness provider for platform resource management
    harness = {
      source  = "harness/harness"
      version = ">= 0.45"
    }
  }
}


```

## Requirements

None.

## Secret Manager Configuration

When creating a Secret in Harness that uses this Custom Secret Manager, you will be prompted for the following fields (declared in the template as `environmentVariables`):

| Field | Description |
|-------|-------------|
| AKEYLESS_API_URL | The Akeyless REST API endpoint. Defaults to `https://api.akeyless.io` |
| ACCESS_ID | The Akeyless Access ID (e.g. `p-xxxxxxxxxxxx`) used to authenticate |
| ACCESS_KEY_SECRET_ID | Reference to an existing Harness secret holding the Akeyless Access Key |
| IDENTIFIER | The full path of the secret in Akeyless (e.g. `/MyFirstSecret`) |

The underlying script authenticates to Akeyless via `/auth` using the Access ID/Key, then resolves the secret value via `/get-secret-value` using the returned session token.

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| harness\_platform\_account | [Required] Enter the Harness Platform Account Number | `string` | n/a | yes |
| harness\_platform\_url | [Optional] Enter the Harness Platform URL.  Defaults to Harness SaaS URL | `string` | `"https://app.harness.io/gateway"` | no |
| organization\_id | [Optional] The organization where the template will live, leave blank for account level. Provide an existing organization reference ID.  Must exist before execution | `string` | `null` | no |
| project\_id | [Optional] The project where the template will live, leave blank for organization or account level. Provide an existing project reference ID.  Must exist before execution | `string` | `null` | no |
| tags | [Optional] Provide a Map of Tags to associate with the resources | `map(any)` | `{}` | no |
| template\_name | [Required] Name of the secret manager template | `string` | `"Akeyless"` | no |
| template\_version | [Required] Version strings for the template | `string` | `"v1"` | no |


## Terraform TFVARS

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Outputs

| Name | Description |
|------|-------------|
| template\_id | Template ID |

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
