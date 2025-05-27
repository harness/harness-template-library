# Harness STO Global Configuration Manager with Scanner templates

A terraform template designed to deploy the Harness STO Global Configuration Management repository into a ready Harness account.

## Summary
The STO SAST & SCA Primer Factory will deploy a fully configured set of templates into a Harness account which will provide a streamlined mechanism to rapidly onboard new source code repositories into Harness to begin static code analysis (SCA) and static application security testing (SAST) monitoring of the source code.

This Template will created the following resources:
- Step Template(s):
    - STO ConfigManager Repo _(Clones the Harness STO Global Exclusions and Configuration management repository)_

- StepGroup Template(s):
    - Gitleaks Scans _(Integrates Harness STO Configuration Manager overrides with scanner)_
    - OSV SCA _(Integrates Harness STO Configuration Manager overrides with scanner)_
    - OWASP Dependency Check _(Integrates Harness STO Configuration Manager overrides with scanner)_
    - Semgrep SAST _(Integrates Harness STO Configuration Manager overrides with scanner)_

- Stage Template(s):
    - STO SAST SCA Primer _(Comprehensive SAST/SCA scanner template - supports Self-Hosted and Harness Cloud builds)_

- Pipeline Template(s):
    - STO SAST SCA Pipeline _(End-to-End SAST/SCA pipeline template leveraging Stage Template)_
    - STO SAST SCA Pipeline - HCR _(Supports Harness Code Repositories)_


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
- Requires Harness Security Test Orchestration module

## Variables

_Note: When providing `_ref` values, please ensure that these are prefixed with the correct location details depending if the connector is at the Organization (org.) or Account (account.) levels.  For Project Connectors, nothing else is required excluding the reference ID for the connector._

### Harness Hierarchy Setup Details
| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| organization_id | | Harness Organization ID into which resource should be built.  Must exist before execution. | string | null |
| project_id | | Harness Project ID into which resource should be built.  Must exist before execution. Requires `organization_id` | string | null |
| tags | | Provide a Map of Tags to associate with all resources | map(any) | {} |
| should_support_hcr | | Should a pipeline template be included which support Harness Code Repository sources | bool | true |

### Self-Hosted Build Farm Configuration
| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| kubernetes_connector | | Enter the existing Kubernetes connector if local K8s execution should be used when running the Execution pipeline.  Must exist before execution | string | skipped |
| kubernetes_namespace | | Enter the existing Kubernetes namespace if local K8s execution should be used when running the Execution pipeline.  Must exist before execution | string | default |
| kubernetes_node_selectors | | Optional Kubernetes Node Selectors | map(any) | {} |
| kubernetes_override_image_connector | | Enter an existing Container Registry connector to use which overrides the default connector | string | skipped |

### Harness STO Scanner Configuration
| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| enabled_scanners | | The enabled scanners will be included by default in the templates | list(string) | [gitleaks, osv, owasp, semgrep] |
| scanner_override_image_connector | | Provide existing Container Registry connector_id to be used to pull all scanner images. | string | skipped |
| gitleaks_override_image_name | | Provide an override image reference to pull | string | skipped |
| gitleaks_override_cpu | | Provide an override step CPU value - You can specify a fraction as well. 0.1 is equivalent to 100m, or 100 millicpu. | string | 0.4 |
| gitleaks_override_mem | | Provide an override step MEM value - You can specify an integer or fixed-point value with the suffix G, M, Gi, or Mi. | string | 600Mi |
| osv_override_image_name | | Enter an existing Container image which to use for OSV scans | string | skipped |
| osv_override_cpu | | Provide an override step CPU value - You can specify a fraction as well. 0.1 is equivalent to 100m, or 100 millicpu. | string | 1 |
| osv_override_mem | | Provide an override step MEM value - You can specify an integer or fixed-point value with the suffix G, M, Gi, or Mi. | string | 2Gi |
| owasp_override_image_name |  Enter an existing Container image which to use for OWASP scans | string | skipped |
| owasp_override_cpu | | Provide an override step CPU value - You can specify a fraction as well. 0.1 is equivalent to 100m, or 100 millicpu. | string | 2 |
| owasp_override_mem | | Provide an override step MEM value - You can specify an integer or fixed-point value with the suffix G, M, Gi, or Mi. | string | 6Gi |
| semgrep_override_image_name  Enter an existing Container image which to use for Semgrep scans | string | skipped |
| semgrep_override_cpu | | Provide an override step CPU value - You can specify a fraction as well. 0.1 is equivalent to 100m, or 100 millicpu. | string | 2 |
| semgrep_override_mem | | Provide an override step MEM value - You can specify an integer or fixed-point value with the suffix G, M, Gi, or Mi. | string | 4Gi |
| tools_image_connector | | Enter an existing Container Registry connector_id which contains build tools image for OWASP scans | string | account.harnessImage |
| tools_image_name | | Enter an existing Container image which contains build tools for OWASP scans | string | node:20.11.0-alpine |

### Harness STO Global Configuration Manager image
| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| sto_config_mgr_connector_ref | | When provided, the existing Git connector will be used. When 'skipped' a custom Harness Code Repository will be added into the scope. | string | skipped |
| sto_config_mgr_repo | X | The source CodeBase Repository Name. If `sto_config_mgr_connector_ref` is set, then provide the full repo details based on the connector type. | string | harness-sto-global-exclusions |
| sto_config_mgr_connector | X | Provide Container Registry connector from which the STO Configuration Manager image will be retrieved. Defaults to account.harnessImage | string | account.harnessImage |
| sto_config_mgr_image | X | Provide the Container Registry image name and tag for the STO Configuration Manager image | string | harnesssolutionfactory/harness-sto-config-manager:latest |

## Terraform TFVARS

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Outputs

| Name | Description | Type |
| --- | --- | --- |
| resource_placement | Displays location of resources deployed as part of this execution | String |
| pipeline_template_id | Hierarchy aware resource id for the pipeline template created. | String |
| pipeline_template_hcr_id | Hierarchy aware resource id for the pipeline template created. Supports Harness Code Repository configurations | String |
| harness_sto_global_exclusions_repo | Repository Location and URL for new Harness STO Global Configuration Manager Repository | String |

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
