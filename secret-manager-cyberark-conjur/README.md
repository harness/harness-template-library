# Secret Manager: CyberArk Conjur

A custom secret manager template for connecting to CyberArk Conjur.

## Summary

Create a template for accessing secrets from CyberArk Conjur, to be used to access secrets using a custom secret manager connector.

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
  required_providers {
    harness = {
      source  = "harness/harness"
      version = ">= 0.31"
    }
  }
}

```

## Requirements

None.

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| harness\_platform\_account | [Required] Enter the Harness Platform Account Number | `string` | n/a | yes |
| harness\_platform\_url | [Optional] Enter the Harness Platform URL.  Defaults to Harness SaaS URL | `string` | `"https://app.harness.io/gateway"` | no |
| organization\_id | [Optional] The organization where the template will live, leave blank for account level. Provide an existing organization reference ID.  Must exist before execution | `string` | `null` | no |
| project\_id | [Optional] The project where the template will live, leave blank for organization or account level. Provide an existing project reference ID.  Must exist before execution | `string` | `null` | no |
| tags | [Optional] Provide a Map of Tags to associate with the resources | `map(any)` | `{}` | no |
| template\_name | [Required] Name of the secret manager template | `string` | `"CyberArk Conjur"` | no |
| template\_version | [Required] Version strings for the template | `string` | `"1.0"` | no |


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
