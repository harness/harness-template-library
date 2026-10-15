# Harness Supply Chain Security (SCS) Templates for ECR Artifacts
#
# This module provisions two StepGroup templates used to perform supply chain
# security steps (SBOM, SLSA provenance, signing/verification) against
# container artifacts stored in AWS ECR:
# - CI step group: generates SBOM, SLSA provenance, and signs the artifact
# - CD step group: verifies the SLSA provenance and artifact signature
#
# Both templates can be provisioned at the Account, Organization, or Project
# level depending on whether organization_id / project_id are provided.
# See harness_step_groups_v1.tf for the resource declarations.
