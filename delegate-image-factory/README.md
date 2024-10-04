# Harness Delegate Image Factory Automation

A terraform template designed to deploy the Harness Delegate Image Factory pipelilne into a ready Harness account.

## Summary

The Harness Delegate Images Factory is a robust Harness pipeline designed to create and manage the lifecycle of customized Harness Delegate Images. This template will build and deliver the following:

- A new Pipeline used to create and customize Harness Delegate Images with support for:
    - Dynamically determining the latest Harness Delegate version
    - Optional integration with supported Harness Security Test Orchestration (STO) container image scans
    - Optional integration with Harness Software Supply Chain Assurance (SSCA) to generate a Software Bill of Materials (SBOM)
- Optional Harness Code Repository to house the custom Harness Delegate image scripts and Dockerfile
- Optional Pipeline used to synchronize and mirror code repository from Harness into Harness Code Repository

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
      version = ">= 0.24"
    }
  }
}

```

## Requirements

The following items must be preconfigured in the target Harness Account
- Harness Service Account with an API Key stored as a secret
- Organization to which to deploy the solution
- Project to which to deploy the soluttion
- Container Registry Connector and Repository Name
- Kubernetes Connector with a chosen namespace for execution of the pipeline steps

## Variables

_Note: When providing `_ref` values, please ensure that these are prefixed with the correct location details depending if the connector is at the Organization (org.) or Account (account.) levels.  For Project Connectors, nothing else is required excluding the reference ID for the connector._

| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| harness_platform_url | | Enter the Harness Platform URL.  Defaults to Harness SaaS URL | string | https://app.harness.io/gateway |
| harness_platform_account | X | Enter the Harness Platform Account Number | string | null |
| existing_harness_platform_key_ref | X | Provide an existing Harness Platform key secret reference.  Must exist before execution | string | |
| organization_id | X | Provide an existing organization reference ID.  Must exist before execution | string | |
| project_id | X | Provide an existing project reference ID.  Must exist before execution | string | |
| git_repository_name | | The source CodeBase Repository Name | string | harness-delegate-setup |
| git_connector_ref | | When provided, the existing Git connector will be used. When 'null' a custom Harness Code Repository will be added into the project. | string | null |
| kubernetes_connector | X | Enter the existing Kubernetes connector if local K8s execution should be used when running the Execution pipeline.  Must exist before execution | string | |
| kubernetes_namespace | | Enter the existing Kubernetes namespace if local K8s execution should be used when running the Execution pipeline.  Must exist before execution | string | default |
| kubernetes_node_selectors |  | Kubernetes Node Selectors | map(any) | {} |
| kubernetes_override_image_connector | | Enter an existing Container Registry connector to use which overrides the default connector.  Must exist before execution | string | null |
| container_registry_name | X | Docker Registry Name to which the container will be published | string | |
| container_registry_connector_id | X | Existing Docker Registry Connector Id.  Must exist before execution | string | |
| include_image_test_scan | | Include the Image Test Scan | bool | false |
| include_image_sbom | | Include Harness Software Bill of Materials | bool | false |
| container_registry_type | | Container Registry Type | string | docker |
| sto_scanner_type | | Harness STO Scanner Type | string | aqua_trivy |


## Terraform TFVARS

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Outputs

| Name | Description | Type |
| --- | --- | --- |
| repository_url | Code Repository URL to which the Harness Delegate Image Factory repository should be deployed | string |
| repository_branch | Code Repository default branch for the Delegate Image Factory repository | string |

## Contributing

A complete [Contributors Guide](../../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../../LICENSE) for full details.
