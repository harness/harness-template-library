# CCM Kubernetes Connectors

Create Harness Kubernetes and CCM Kubernetes connectors for a deployed delegate to enable cost and usage metric gathering and autostopping.

## Summary

When enabling CCM on a Kubernetes cluster you first need to deploy a delegate inside the cluster.

After deployment you also need to create two connectors at the Harness account level, a Kubernetes connector and a CCM Kubernetes connector.

This template creates both connectors for you.

This Template will created the following resources:
- harness_platform_connector_kubernetes
- harness_platform_connector_kubernetes_cloud_cost

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
- An in-cluster delegate has been deployed in the target cluster

## Variables

| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| harness_platform_url | | Enter the Harness Platform URL.  Defaults to Harness SaaS URL | `string` | https://app.harness.io/gateway |
| harness_platform_account | X | Enter the Harness Platform Account Number | `string` ||
| harness_platform_key | X | Enter the Harness Platform API Key for your account | `string` ||
| tags | | Provide a Map of Tags to associate with the resources | `map(any)` | `{}` |
| delegate_name | The name of the delegate that has been deployed in your cluster | `string` ||
| cluster_name | The name of the cluster, if different from the delegate name | `string` | `null` |
| description | Description of the cluster to add to the connectors | `string` | `""` |
| enable_optimization | If optimization (autostopping) should be enabled for this cluster (requires additional in-cluster deployment) | `bool` | `false` |

## Terraform TFVARS

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Outputs

| Name | Description |
|------|-------------|
| ccm_k8s_connector_id | The created ccm kubernetes connector id |
| k8s_connector_id | The created kubernetes connector id |

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
