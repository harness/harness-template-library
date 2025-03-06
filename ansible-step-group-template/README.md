# Ansible Step Group Template

A step group template to run Ansible in a custom stage.

## Summary

This provides a standard for running ansible in a custom stage. Useful for configuring machines or performing maintenance.

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

There are no requirements for this template. If you wish to have all ansible runs performed on a central build-farm, you will need an account level Kubernetes connector.

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| docker\_connector | Docker connector ID for pulling ansible image | `string` | `"account.harnessImage"` | no |
| harness\_code | n/a | `bool` | `true` | no |
| harness\_platform\_account | [Required] Enter the Harness Platform Account Number | `string` | n/a | yes |
| harness\_platform\_url | [Optional] Enter the Harness Platform URL.  Defaults to Harness SaaS URL | `string` | `"https://app.harness.io/gateway"` | no |
| image | Docker image to use for running ansible. Must follow repo/image format | `string` | `"alpine/ansible"` | no |
| kubernetes\_connector | [Optional] Enter the existing Kubernetes connector to use for Execution.  Must exist before execution. Set to 'skipped' to use <+input> | `string` | `"skipped"` | no |
| kubernetes\_namespace | [Optional] Enter the existing Kubernetes namespace to use for Execution.  Must exist before execution. Set to 'skipped' to use <+input> | `string` | `"skipped"` | no |
| kubernetes\_node\_selectors | [Optional] Optional Kubernetes Node Selectors | `map(any)` | `{}` | no |
| kubernetes\_override\_image\_connector | [Optional] Enter an existing Container Registry connector to use which overrides the default connector.  Must exist before execution | `string` | `"skipped"` | no |
| tags | [Optional] Provide a Map of Tags to associate with the resources | `map(any)` | `{}` | no |
| template\_name | Name of the Ansible step group template | `string` | `"Execute Ansible"` | no |
| template\_types | A seperate template will be created for each stage type specified | `list(string)` | <pre>[<br/>  "Deployment",<br/>  "CI",<br/>  "IACM"<br/>]</pre> | no |
| template\_version | Version strings for the step group template | `string` | `"1.0"` | no |


## Terraform TFVARS

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Outputs

| Name | Description |
|------|-------------|
| template\_urls | Links to all created templates |

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
