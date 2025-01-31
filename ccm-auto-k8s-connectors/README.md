# CCM Auto K8s Connectors

Automatically create Kubernetes and CCM Kubernetes connectors for delegates created at the account level.

## Summary

If you have distributed teams deploying delegates in clusters, this plugin + pipeline can help automatically create the connectors nessesary to enable CCM on said clusters.

This Template will created the following resources:
- harness_platform_pipeline
- harness_platform_triggers


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

The following items must be preconfigured in the target Harness Account
- Kubernetes connector
- Docker connector
- Harness secret holding a Harness API Key that can modify services
- An org/project where the pipeline can be placed

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| connector\_prefix | Prefix to add to all create Kubernetes and CCM Kubernetes connectors | `string` | `"ccm"` | no |
| cron | The cron schedule to trigger the pipeline on a scheduled | `string` | `"0 1 * * *"` | no |
| docker\_connector | Docker connector ID for pulling plugin image | `string` | n/a | yes |
| existing\_harness\_platform\_key\_ref | Existing secret ID for Harness API key that can modify CD services | `string` | n/a | yes |
| harness\_endpoint | Harness endpoint for API calls | `string` | `"app.harness.io"` | no |
| harness\_platform\_account | [Required] Enter the Harness Platform Account Number | `string` | n/a | yes |
| harness\_platform\_url | [Optional] Enter the Harness Platform URL.  Defaults to Harness SaaS URL | `string` | `"https://app.harness.io/gateway"` | no |
| image | Plugin docker image to use for creating connectors. Must follow repo/image:tag format | `string` | `"harnesscommunity/harness-ccm-k8s-auto:4a32f7c"` | no |
| kubernetes\_connector | [Required] Enter the existing Kubernetes connector if local K8s execution should be used when running the Execution pipeline.  Must exist before execution | `string` | n/a | yes |
| kubernetes\_namespace | [Optional] Enter the existing Kubernetes namespace if local K8s execution should be used when running the Execution pipeline.  Must exist before execution | `string` | `"default"` | no |
| kubernetes\_node\_selectors | [Optional] Optional Kubernetes Node Selectors | `map(any)` | `{}` | no |
| kubernetes\_override\_image\_connector | [Optional] Enter an existing Container Registry connector to use which overrides the default connector.  Must exist before execution | `string` | `"skipped"` | no |
| organization\_id | [Required] The organization where the pipeline will live. Provide an existing organization reference ID.  Must exist before execution | `string` | n/a | yes |
| project\_id | [Required] The project where the pipeline will live. Provide an existing project reference ID.  Must exist before execution | `string` | n/a | yes |
| tags | [Optional] Provide a Map of Tags to associate with the resources | `map(any)` | `{}` | no |

## Terraform TFVARS

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Outputs

| Name | Description |
|------|-------------|
| harness\_platform\_pipeline\_id | The ID of the created pipeline. |
| harness\_platform\_trigger\_id | The ID of the created trigger. |

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
