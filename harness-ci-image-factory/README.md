# Harness Solutions Factory - Harness CI Image Factory

Mirror and Replicate official Harness images into a private container registry

## Summary
_Document the overall use case and scenario for which this template would be used, including a bullet list of resources created_

This Template will created the following resources:
- A pipeline to Mirror and Replication Harness CI Images into a private container repository
- An optional cron-based pipeline trigger


## Providers
This template is designed to be used as a Terraform Module. To leverage this module, an Harness provider configuration must be added to the calling template as defined by the [Harness Provider - Docs](https://registry.terraform.io/providers/harness/harness/latest/docs).

To aid in the setup and use of this module, we have added a file to the root of this repository called `providers.tf.example`. This file can be used as the basis for configuring your own `providers.tf` file for the calling template

_**Note**: If using this as module as a template, be sure to copy the provider sample file from the root of the repository into this directory prior to execution._
- Save a copy of the file as `providers.tf`
- Either configure the variables as defined or use their corresponding variables.

_**Note**: The gitignore file in this repository explicitly ignores any file called `providers.tf` from commits and changes._

### Terraform required providers declaration
_Include details about any provided with which this template will have a dependency_

```
terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
      version = ">= 0.31"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.1"
    }
  }
}

```

## Requirements

The following items must be preconfigured in the target Harness Account
- Container Registry Username as a Harness Secret
- Container Registry Password as a Harness Secret

## Variables
### TODO: Remove this line after reviewing and updating all terraform variable details

_Note: When providing `_ref` values, please ensure that these are prefixed with the correct location details depending if the connector is at the Organization (org.) or Account (account.) levels.  For Project Connectors, nothing else is required excluding the reference ID for the connector._

| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| harness_platform_url | | Enter the Harness Platform URL.  Defaults to Harness SaaS URL | string | https://app.harness.io/gateway |
| harness_platform_account | X | Enter the Harness Platform Account Number | string ||
| tags | | Provide a Map of Tags to associate with the resources | map(any) |{}|
| organization_id | X | Provide an existing organization reference ID.  Must exist before execution | string | |
| project_id | X | Provide an existing project reference ID.  Must exist before execution | string | |
| kubernetes_connector | | Enter the existing Kubernetes connector if local K8s execution should be used when running the Execution pipeline.  Must exist before execution | string | skipped |
| kubernetes_namespace | | Enter the existing Kubernetes namespace if local K8s execution should be used when running the Execution pipeline.  Must exist before execution | string | default |
| kubernetes_node_selectors | | [Optional] Optional Kubernetes Node Selectors | map | {} |
| kubernetes_override_image_connector | | Enter an existing Container Registry connector to use which overrides the default connector | string | skipped |
| harness_ci_image_source_repository | |maintained container registry from which images will be sourced | string | us-docker.pkg.dev/gar-prod-setup/harness-public/ |
| customer_image_target_repository | X | Customer provided Container Registry Path | string | |
| container_registry_username_ref | |to Harness Secret containing the Container Registry Username. Defaults to Central Build Farm Container Registry Credentials | string | account.buildfarm_container_registry_username |
| container_registry_password_ref | |to Harness Secret containing the Container Registry Password. Defaults to Central Build Farm Container Registry Credentials | string | account.buildfarm_container_registry_password |
| should_update_harness_mgr | | If 'true' the Harness CI Manager will be updated immediately to change the default behaviour of Harness CI to only pull images from those stored in the target container registry. | bool | true |
| pipeline_step_connector_ref | | Configures the connector from which the Pipeline Step images will be pulled. Defaults to account.harnessImage | string | account.harnessImage |
| hsf_script_mgr_image | |Solutions Factory Script Manager Image. Path should be relative to the connector `pipeline_step_connector_ref` | string | harnesssolutionfactory/harness-python-api-sdk:latest |
| harness_image_migration_image | |Container Image Migration tool. Path should be relative to the connector `pipeline_step_connector_ref` | string | plugins/image-migration |
| max_concurrency | |the maximum number of concurrent images that should be migrated in parallel | number | 5 |
| should_trigger_pipeline_on_schedule | | Should we enable the execution of this pipeline to run on a schedule? | bool | true |
| scheduled_pipeline_execution_frequency | | Cron Format schedule for when and how frequently to schedule this pipeline. Default is daily at 2am | string | 0 2 * * * |



## Terraform TFVARS

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Outputs

| Name | Description | Type |
| --- | --- | --- |
| pipeline_url | Pipeline URL to edit | string |
| pipeline_executions_url | Pipeline URL to execution history | string |
| pipeline_identifier | Pipeline Identifier | string |

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
