# Harness Solutions Factory Scaffold

Resources to enable engineers to automatically autostop their Kubernetes applications.

## Summary

Create a step template that can create Kubernetes autostopping rules in CD stages using shared manifests stored in the Harness file store.

Then, provide a Pipeline that can automate adding any missing variables to CD services that are needed to create the autostopping rules.

Once deployed, engineers can add the step template to their pipelines, and run the workflow on their services, to enable the ability to have autostopping rules automatically created when they deploy their services.

This requires that [autostopping has been enabled](https://developer.harness.io/kb/cloud-cost-management/articles/onboarding/k8s#enable-auto-stopping) in the deployment cluster.

This Template will created the following resources:
- harness_platform_file_store_folder
- harness_platform_file_store_file
- harness_platform_file_store_file
- harness_platform_template
- harness_platform_pipeline


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
| docker\_connector | Docker connector ID for pulling plugin image | `string` | `"harnessImage"` | no |
| existing\_harness\_platform\_key\_ref | Existing secret ID for Harness API key that can modify CD services | `string` | n/a | yes |
| harness\_platform\_account | [Required] Enter the Harness Platform Account Number | `string` | n/a | yes |
| harness\_platform\_url | [Optional] Enter the Harness Platform URL.  Defaults to Harness SaaS URL | `string` | `"https://app.harness.io/gateway"` | no |
| image | Plugin docker image to use for modifying services. Must follow repo/image:tag format | `string` | `"harnesscommunity/add-autostopping-variables:576e4f594a80d482f77761f4ca8b715cf25c983d"` | no |
| kubernetes\_connector | [Required] Enter the existing Kubernetes connector if local K8s execution should be used when running the Execution pipeline.  Must exist before execution | `string` | n/a | yes |
| kubernetes\_namespace | [Optional] Enter the existing Kubernetes namespace if local K8s execution should be used when running the Execution pipeline.  Must exist before execution | `string` | `"default"` | no |
| kubernetes\_node\_selectors | [Optional] Optional Kubernetes Node Selectors | `map(any)` | `{}` | no |
| kubernetes\_override\_image\_connector | [Optional] Enter an existing Container Registry connector to use which overrides the default connector.  Must exist before execution | `string` | `"skipped"` | no |
| pipeline\_organization\_id | [Required] The organization where the pipeline will live. Provide an existing organization reference ID.  Must exist before execution | `string` | n/a | yes |
| pipeline\_project\_id | [Required] The project where the pipeline will live. Provide an existing project reference ID.  Must exist before execution | `string` | n/a | yes |
| tags | [Optional] Provide a Map of Tags to associate with the resources | `map(any)` | `{}` | no |
| template\_name | Name of the 'kubectl apply' step template that will create auto stopping rules | `string` | `"Auto-Stop Ingress"` | no |
| template\_organization\_id | [Optional] The organization where the step template will live, leave blank for account level. Provide an existing organization reference ID.  Must exist before execution | `string` | `null` | no |
| template\_project\_id | [Optional] The project where the step template will live, leave blank for organization or account level. Provide an existing project reference ID.  Must exist before execution | `string` | `null` | no |
| template\_version | Version strings for the step template | `string` | `"1.0"` | no |

## Terraform TFVARS

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Outputs

| Name | Description | Type |
|------|-------------| ---- |
| pipeline | Pipeline ID | string |
| template | Kubectl step template ID | string |

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
