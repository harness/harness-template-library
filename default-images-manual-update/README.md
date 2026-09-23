# Harness Solutions Factory - Default Images Manual Update

Manually manage the default execution images used by Harness pipeline steps

## Summary

This Template will created the following resources:
- One pipeline per selected module (`ci`, `idp`, `iacm`) seeded with the current default execution images for that module
- Each pipeline lets a user override any default image (e.g. to point at an internal mirror or pin a tag) via pipeline inputs, or reset all images back to the Harness defaults

Adapted from the community reference implementation - [harness-default-images-manual-update](https://github.com/harness-community/harness-default-images-manual-update)

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

The following items must be preconfigured in the target Harness Account
- A Harness Secret containing a Harness Platform API Key with permission to update default execution images

## Variables

_Note: When providing `_ref` values, please ensure that these are prefixed with the correct location details depending if the connector is at the Organization (org.) or Account (account.) levels.  For Project Connectors, nothing else is required excluding the reference ID for the connector._

| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| harness_platform_url | | Enter the Harness Platform URL.  Defaults to Harness SaaS URL | string | https://app.harness.io/gateway |
| harness_platform_account | X | Enter the Harness Platform Account Number | string | |
| tags | | Provide a Map of Tags to associate with the resources | map(any) | {} |
| organization_id | X | Provide an existing organization reference ID.  Must exist before execution | string | |
| project_id | X | Provide an existing project reference ID.  Must exist before execution | string | |
| harness_api_key_secret_ref | X | Reference to a Harness Secret containing a Harness Platform API Key with permission to update default execution images | string | |
| modules | | Modules to create a manual default image update pipeline for | list(string) | ["ci", "idp", "iacm"] |
| exclude_images | | Default image fields to exclude from the pipeline variables | list(string) | ["iacmAnsible", "iacmAwsCdk", "iacmCheckov", "iacmModuleTest", "iacmOpenTofu", "iacmTFCompliance", "iacmTFLint", "iacmTFSec", "iacmTerraform", "iacmTerragrunt"] |

## Terraform TFVARS

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Usage

Once applied, open the created pipeline (`pipeline_urls` output) and hit **Run**:
- To override images, choose the target `infra` (`K8`/`VM`), set `reset` to `false`, and edit any of the per-image variables (e.g. point them at an internal registry mirror)
- To restore Harness defaults, set `reset` to `true`
- Use Input Sets to save a given set of overrides for reuse

## Outputs

| Name | Description | Type |
| --- | --- | --- |
| pipeline_identifiers | Map of module to the created pipeline identifier | map(string) |
| pipeline_urls | Map of module to the Pipeline Studio URL | map(string) |

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
