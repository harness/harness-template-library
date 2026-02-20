# Create and push new catalog YAMLs

This solution provides a system to enable self-serve application onboarding for Harness IDP service catalog.

An IDP template is created that will prompt users to fill out information on their component:

- The system it is a part of
- Name
- Description
- Type

When the template is executed, it triggers a Harness pipeline which creates the catalog YAML and commits it to a central repository.

This should be used as a baseline and should be customize to add specific fields and annotations you want to have on your catalog entries.

_Note: This template was deprecated on 2026-02-01_

## Summary

A template and pipeline will be created to create new catalogs based on user input.

This Template will created the following resources:
- IDP Template: Register New Service Catalog Component
- Harness Pipeline: Create and Push New Catalog YAML

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

The following items must be preconfigured in the target Harness Account:

- One of the following:
  - A git connector in the Solutions Factory project
  - A repo in the Solutions Factory project, or Organization, or Account

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| git\_branch\_name | [Required] Git branch to commit catalogs to | `string` | n/a | yes |
| git\_connector\_ref | [Optional] Git connector for pushing catalog entries | `string` | `""` | no |
| git\_connector\_type | [Required] The type of git connector used, must be one of HarnessAccount, HarnessOrganization, HarnessProject, Github, Gitlab, Bitbucket or AzureRepo | `string` | n/a | yes |
| git\_grouppath\_name | [Optional] Git group path name, used for Gitlab types | `string` | `""` | no |
| git\_organization\_name | [Optional] Git organization name, used for Github and AzureRepo types | `string` | `""` | no |
| git\_project\_name | [Optional] Git project name, used for Gitlab, Bitbucket and Azure types | `string` | `""` | no |
| git\_repository\_name | [Required] Git repository name to push catalogs to | `string` | n/a | yes |
| git\_workspace\_name | [Optional] Git workspace name, used for BitBucket types | `string` | `""` | no |
| harness\_create\_repo | [Optional] Create the Harness code repo to be used | `bool` | `false` | no |
| harness\_platform\_account | [Required] Enter the Harness Platform Account Number | `string` | n/a | yes |
| harness\_platform\_key | [Required] Enter the Harness Platform API Key for your account | `string` | `null` | no |
| harness\_platform\_url | [Optional] Enter the Harness Platform URL.  Defaults to Harness SaaS URL | `string` | `"https://app.harness.io/gateway"` | no |
| kubernetes\_connector | [Required] Enter the existing Kubernetes connector if local K8s execution should be used when running the Execution pipeline.  Must exist before execution | `string` | `"skipped"` | no |
| kubernetes\_namespace | [Optional] Enter the existing Kubernetes namespace if local K8s execution should be used when running the Execution pipeline.  Must exist before execution | `string` | `"default"` | no |
| kubernetes\_node\_selectors | [Optional] Optional Kubernetes Node Selectors | `map(any)` | `{}` | no |
| kubernetes\_override\_image\_connector | [Optional] Enter an existing Container Registry connector to use which overrides the default connector.  Must exist before execution | `string` | `"skipped"` | no |
| organization\_id | [Required] Provide an existing organization reference ID.  Must exist before execution | `string` | n/a | yes |
| project\_id | [Required] Provide an existing project reference ID.  Must exist before execution | `string` | n/a | yes |
| tags | [Optional] Provide a Map of Tags to associate with the resources | `map(any)` | `{}` | no |

## Terraform TFVARS

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Outputs

| Name | Description |
|------|-------------|
| harness_platform_pipeline | Pipeline identifier |

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
