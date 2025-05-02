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
| authentication_type_self_hosted | | Choose the authentication type for the Self-Hosted Connectors | string | manual |
| authentication_type_harness_cloud | | Choose the authentication type for the Harness Cloud Connectors | string | manual |
| container_registry_type | | What type of Container Registry Connector type will be used as the default Build Farm Registry. Supported values - docker, aws, gcp, azure | string | docker |
| delegate_selectors | | Delegate selectors | list(string) | [build-farm] |

### Generic Container Registry Connectors
| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| container_registry_provider_type | | Choose a Generic Container Registry Type. Supported Values - DockerHub, Harbor, Quay, Other | string | DockerHub |
| container_registry_url | | Provide the URL to which the Container Registry connector will connect | string | https://index.docker.io/v2/ |

### Source Code Manager Connectors
| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| source_code_manager_type | | What type of Source Code Manager Connector type will be used as the default Build Farm SCM. Supported values - github, bitbucket, gitlab | string | github |
| source_code_manager_url | X | Please provide the default URL for the Connector - e.g. https://github.com | string | |
| source_code_manager_validation_repo | X | Please provide the validation URL for the Connector - e.g. harness/terraform-provider-harness | string | |
| source_code_manager_auth_type | | Choose the authentication type for the SCM Connectors | string | http |

### Artifact Manager Connectors
| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| artifact_manager_type | | What type of Artifact Manager Connector type will be used as the default Build Farm Registry | string | nexus |
| artifact_manager_url | | Please provide the default URL for the Connector - e.g. https://mycompany.jfrog.io/module_name/. | string | skipped |
| artifact_manager_auth_type | | Choose the authentication type for the Artifact Manager Connectors. Allowed values: 'UsernamePassword', 'Anonymous' | string | Anonymous |
| nexus_version | | Choose the Nexus Version for Nexus Connectors. Allowed values: '2.x', '3.x' | string | 2.x |

### AWS Container Registry Connectors
| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| region | | Choose the default AWS Region | string | us-east-1 |
| iam_role_arn | | The IAM Role to assume the credentials from | string | null |
| aws_cross_account_role_arn | | The Amazon Resource Name (ARN) of the role that you want to assume. This is an IAM role in the target AWS account. | string | null |
| aws_cross_account_external_id | | If the administrator of the account to which the role belongs provided you with an external ID, then enter that value. | string | null |


### GCP Container Registry Connectors
| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| gcp_workload_pool_id | | Workload Pool ID for OIDC authentication | string | null |
| gcp_provider_id | | Provider ID for OIDC authentication | string | null |
| gcp_project_id | | GCP Project ID for OIDC authentication | string | null |
| gcp_service_account_email | | Service Account Email for OIDC authentication | string | null |

### Azure Container Registry Connectors
| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| azure_application_id | | Azure application ID for authentication | string | null |
| azure_tenant_id | | Azure tenant ID for authentication | string | null |
| azure_environment_type | | ENV TYPE: AZURE or AZURE_US_GOVERNMENT | string | AZURE |
| azure_user_assigned_client_id | | Client ID for User Assigned Managed Identity | string | null |
| artifact_manager_delegate | | Delegate selectors | list(string) | [build-farm] |


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
| build_farm_artifact_manager | string | The BuildFarm Artifact Manager Connector Id |
| build_farm_artifact_manager_cloud | string | The BuildFarm Artifact Manager Connector Id - Cloud |

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
