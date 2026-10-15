# SCS ECR - Step Groups

Reusable StepGroup templates implementing Software Supply Chain Assurance (SSCA) for container artifacts stored in AWS ECR.

## `stg_scs_ecr_ci.yaml` — CI StepGroup

**Stage type**: `CI`

**Steps**:
1. SBOM Orchestration (`SscaOrchestration`, Syft, SPDX-JSON)
2. Artifact Signing (`SscaArtifactSigning`, keyless/OIDC)
3. SLSA Generation (`provenance`, keyless/OIDC)

**Variables** (runtime `<+input>`): `ECR_Connector`, `ECR_Account`, `ECR_Region`, `ECR_Image`

## `stg_scs_ecr_cd.yaml` — CD StepGroup

**Stage type**: `Deployment`

**Steps** (run in parallel, resolved from `<+artifact>`):
1. SLSA Verification (`SlsaVerification`, keyless/OIDC)
2. Artifact Verification (`SscaArtifactVerification`, keyless/OIDC)

**StepGroup infrastructure**: `KubernetesDirect` — connector, namespace, and service account are supplied at runtime (`<+input>`).

See the module [README](../../README.md) for how these templates are provisioned via Terraform.
