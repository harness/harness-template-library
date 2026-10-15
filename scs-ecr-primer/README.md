# SCS ECR Supply Chain Security Templates

## Summary

This module creates two reusable Harness StepGroup templates that implement Software Supply Chain Assurance (SSCA) steps for container artifacts stored in AWS ECR:

- **CI StepGroup** (`SCS_ECR_CI`): Generates an SBOM (Syft/SPDX), creates a SLSA provenance attestation, and signs the built image using keyless (OIDC) signing.
- **CD StepGroup** (`SCS_ECR_CD`): Verifies the SLSA provenance attestation and artifact signature of the deployed image using keyless (OIDC) verification.

This Template will create the following resources:
- `harness_platform_template.stg_scs_ecr_ci_v1`
- `harness_platform_template.stg_scs_ecr_cd_v1`

Both templates can be provisioned at the Account, Organization, or Project level by setting `organization_id` / `project_id`.

_Note: In the IDP workflow (`.harness/catalog_template.yaml`), picking "Organization" scope shows a plain Organization picker. Picking "Project" scope ignores that field and instead derives the Organization automatically from the selected Project (via a hidden auto-org field), so org/project can never be mismatched. All fields are always visible in the form; only the ones relevant to the chosen scope are sent to Terraform._

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
- An AWS/ECR connector available at the scope the templates are deployed into (supplied at runtime via the `ECR_Connector` StepGroup variable)
- The Harness Software Supply Chain Assurance (SSCA) module enabled
- For the CD StepGroup, a Kubernetes connector/namespace/service account available to run the verification step group infrastructure (supplied at runtime)

## Variables

| Name | Mandatory | Description | Type | Default |
| --- | --- | --- | --- | --- |
| harness_platform_url | | Enter the Harness Platform URL.  Defaults to Harness SaaS URL | string | https://app.harness.io/gateway |
| harness_platform_account | X | Enter the Harness Platform Account Number | string ||
| tags | | Provide a Map of Tags to associate with the resources | map(any) |{}|
| organization_id | | Existing Organization ID to scope the templates to. Leave null for Account-level templates. | string | null |
| project_id | | Existing Project ID to scope the templates to. Requires `organization_id`. | string | null |

## Terraform TFVARS

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Step Groups

### `stg_scs_ecr_ci.yaml` — CI StepGroup
Runs against the `CI` stage type. Steps: `SBOM Orchestration` (SscaOrchestration/Syft), `Artifact Signing` (SscaArtifactSigning, keyless), `SLSA Generation` (provenance, keyless).

StepGroup variables (all runtime `<+input>`):
| Variable | Description |
| --- | --- |
| `ECR_Connector` | AWS connector reference used to authenticate against the ECR registry |
| `ECR_Account` | AWS account ID that owns the ECR registry |
| `ECR_Region` | AWS region where the ECR registry resides |
| `ECR_Image` | Repository/image path of the artifact in ECR |

### `stg_scs_ecr_cd.yaml` — CD StepGroup
Runs against the `Deployment` stage type with a `KubernetesDirect` StepGroup infrastructure (connector/namespace/service account supplied at runtime). Steps run in parallel: `SLSA Verification` (SlsaVerification, keyless) and `Artifact Verification` (SscaArtifactVerification, keyless), both resolving the artifact details from the deploying service's `<+artifact>` context.

## Outputs

| Name | Description | Type |
| --- | --- | --- |
| step_group_templates | ID and version of the CI/CD StepGroup templates | object |
| template_organization_info | Organization the templates were scoped to, if provided | object |
| template_project_info | Project the templates were scoped to, if provided | object |

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
