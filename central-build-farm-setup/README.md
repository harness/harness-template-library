# Harness Central Build Farm Setup

A terraform template designed to configure a standard set of Build Farm connectors and secrets

## Summary

The Harness Central Build Farm Setup will create the following connectors:

- BuildFarm Container Registry Secrets
    - buildfarm_container_registry_username
    - buildfarm_container_registry_password
- Self-Hosted BuildFarm Infrastructure Connectors: _**Note**: Only valid when `build_infrastructure_type != cloud`_
    - buildfarm_infrastructure: Kubernetes Connector leveraging Delegate Authentication (Delegate must include `build-farm` tag)
    - buildfarm_source_code_manager: SCM connector configuration based on the chosen SCM type `source_code_manager_type`
    - buildfarm_container_registry: Container Registry connector configuration based on the chosen registry type `container_registry_type`
- Harness CI BuildFarm Infrastructure Connectors: _**Note**: Only valid when `build_infrastructure_type != internal`_
    - buildfarm_source_code_manager_cloud: SCM connector configuration based on the chosen SCM type `source_code_manager_type`
    - buildfarm_container_registry_cloud: Container Registry connector configuration based on the chosen registry type `container_registry_type`

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
- N/A

## Variables

_Note: When providing `_ref` values, please ensure that these are prefixed with the correct location details depending if the connector is at the Organization (org.) or Account (account.) levels.  For Project Connectors, nothing else is required excluding the reference ID for the connector._

| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| build_infrastructure_type | | Select the Build infrastructure types to support - internal, cloud, or both | string | internal |
| container_registry_type | | What type of Container Registry Connector type will be used as the default Build Farm Registry. Supported Values - docker, artifactory | string | docker |
| container_registry_url | | What type of Container Registry Connector type will be used as the default Build Farm Registry | string | https://registry.hub.docker.com/v2/ |
| source_code_manager_type | | type of Source Code Manager Connector type will be used as the default Build Farm SCM. Supported Values - github, bitbucket | string | github |
| source_code_manager_url | X | Please provide the default URL for the Connector - e.g. https://github.com | string | |
| source_code_manager_validation_repo | X | provide the validation URL for the Connector - e.g. harness/terraform-provider-harness | string | |


## Terraform TFVARS

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Outputs
| Name | Type | Description |
| --- | --- | --- |
| build_farm_connector | string | If using self-hosted build farm, this output contains the details of the BuildFarm Infrastructure connector |
| build_farm_container_registry | string | The BuildFarm Container Registry Connector Id |
| build_farm_container_registry_cloud | string | The BuildFarm Container Registry Connector Id - Cloud |
| build_farm_source_code_manager | string | The BuildFarm Source Code Manager Connector Id |
| build_farm_source_code_manager_cloud | string | The BuildFarm Source Code Manager Connector Id - Cloud |

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
