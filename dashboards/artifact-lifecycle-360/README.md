# Artifact Lifecycle 360: Build, Store, Scan, Attest, Deploy

End-to-end artifact story across CI, Artifact Registry, Supply Chain Security, STO, Policy as Code and CD: how many artifacts were built, stored, scanned, attested and deployed, the conversion between stages, and the gaps (never scanned, never deployed, deployed without SBOM/signature, policy errors).

**Persona:** Executive and supply chain  
**Modules:** CI, CD, STO, SCS, Artifact Registry, policy  
**Kind:** Cross-module  
**Tags:** Artifact Lifecycle, CI, CD, STO, SCS, AR, Correlation, Deep Dive, 360, Executive, Custom  
**Published:** 2026-11-17 19:44:22 UTC  
[Back to the examples](../README.md)

## Why this dashboard exists

This is the one dashboard that follows an artifact across the platform. It counts what was built, what was stored in the registry, what was scanned, what was attested or policy-checked, and what was deployed, then lists the gaps: builds never scanned, artifacts never deployed, deployments with no SBOM, and policy errors. The joins were checked against live data. CI, STO, policy, CD, and supply-chain records share the pipeline execution id. Registry versions match supply-chain digests. Supply-chain name and tag match the artifact name on the deployment.

## Who should open it

Executives and security leads who want a single funnel from commit to production, and the engineers who have to close the gaps that funnel exposes.

## Questions it answers

- Of the builds we ran, how many were scanned, policy-checked, and deployed in the same run?
- Of the artifacts we registered, how many have an SBOM, a signature, a registry copy, and a deployment?
- Which builds were never scanned, which artifacts were never deployed, and which deployments shipped an image with no SBOM?
- For one artifact, who built it, what is in it, and where did it go?

## Time range and filters

The dashboard opens on **Last 6 months**. The date picker is on, and every data widget inherits it. Changing the range recalculates every number on the page.

Filters: **Organization**, **Project**, **Pipeline**, **Service**, **Environment**, **Artifact Type**, **Registry**.

Each filter is a multi-select. With nothing selected, the widget shows all values. Selecting a value limits the widgets that have that field. A filter is left off a widget that does not have the column, so the widget stays populated.

## What you will see

Two funnels are shown on purpose. The build funnel counts CI builds and asks whether that same pipeline run also scanned, evaluated policy, or deployed. The artifact funnel counts supply-chain artifacts and asks whether each artifact has an SBOM, a vulnerability scan, a registry version, a signature, and a deployment. A build can be scanned without the resulting artifact being tracked, so the two funnels do not have to match. Upload-to-first-pull is the time from a registry upload to the first download of that version.

### Overview

- **text.** # Artifact Lifecycle 360: Build → Store → Scan → Attest → Deploy
- **metric.** Builds (CI)
- **metric.** Artifacts Registered (SCS)
- **metric.** Uploads (AR)
- **metric.** Security Scans (STO)
- **metric.** SBOMs Generated (SCS)
- **metric.** Policy Evaluations (OPA)
- **metric.** Deployments (CD)
- **metric.** Signed / Verified Artifacts
- **gauge.** Builds Scanned by STO
- **gauge.** Builds Deployed (same run)
- **gauge.** Artifacts with SBOM
- **gauge.** AR Versions Tracked in SCS

### Lifecycle Funnel

- **text.** ### Stage volumes and conversion — how many artifacts move from build to production
- **chart.** Lifecycle Stage Volumes
- **chart.** Same-Execution Build Funnel
- **chart.** Weekly Lifecycle Activity by Stage
- **donut.** Pipeline Run Composition
- **table.** Lifecycle Funnel by Project
- **table.** Stage Executions by Weekday
- **chart.** Artifact-Level Funnel (SCS)

### Build → Scan

- **text.** ### CI builds joined to STO scans by plan execution id
- **donut.** Scanners Used on CI Builds
- **chart.** Weekly Builds vs Scanned Builds
- **table.** Repos & Branches Never Scanned
- **table.** Scanner Coverage by Repository
- **table.** Scanned Builds — Drill-Through

### Store

- **text.** ### Artifact Registry: uploads, pulls, consumption latency and links to SCS/CD
- **metric.** Versions Uploaded
- **metric.** Avg Upload → First Pull
- **chart.** Daily Uploads vs Pulls
- **table.** Package Consumption & Latency
- **table.** AR Versions ↔ SCS Artifacts ↔ CD Deployments

### Scan & SBOM

- **text.** ### SBOM depth, vulnerability load per artifact and STO scans matched to artifacts by digest
- **chart.** SBOM Components per Artifact
- **donut.** STO Scanner Mix
- **table.** Vulnerability Load per Artifact
- **table.** STO Scans in the Same Run as SCS Artifacts
- **chart.** Weekly SCS Activity by Type
- **table.** Latest Baseline Severity by Scanner

### Attest & Govern

- **text.** ### Policy-as-code evaluations on build/deploy runs, plus SCS signing & attestation coverage
- **metric.** Executions Evaluated
- **gauge.** Policy Pass Rate
- **chart.** Weekly Policy Evaluations by Outcome
- **chart.** Evaluations on Build vs Deploy Runs
- **table.** Policy Evaluations on Pipelines that Built or Deployed
- **donut.** SCS Signing Status (active artifacts)
- **table.** SCS Attestation Adoption by Project
- **chart.** Governed Entities: Evaluations vs Error Rate

### Deploy

- **text.** ### CD deployments by artifact, service and environment
- **metric.** Deployments
- **metric.** Deploy Success Rate
- **table.** Service × Environment
- **chart.** Weekly Deployments by Environment Type
- **table.** Artifact Versions Deployed
- **chart.** Services: Volume vs Failure Rate

### Risk Gaps

- **text.** ### Risk gaps — artifacts and runs that skipped a lifecycle control. Each table is an action list; click execution IDs or URLs to remediate.
- **metric.** Deploys w/o SCS SBOM
- **metric.** Artifacts Never Deployed
- **metric.** Builds Never Scanned
- **table.** Deployed Artifacts — Vulnerability Exposure
- **table.** Deployed Without SBOM or Signature
- **panel.** Shelfware — built or stored but never deployed
- **table.** Built but Never Scanned (by pipeline)
- **table.** Policy Errors on Pipeline Runs

### Risk Gaps — Shelfware — built or stored but never deployed

- **table.** Built / Registered but Never Deployed
- **table.** Uploaded to AR but Never Deployed

### Traceability

- **text.** ### Per-artifact chain of custody: who built it, what's in it, was it scanned/signed, stored and deployed
- **table.** Artifact Traceability Matrix
- **table.** Artifact Activity Timeline
- **table.** Lifecycle Coverage per Pipeline
- **table.** Commit → Build → Artifact

## Data notes

- Default window is the last 6 months.
- In that window: 345 CI builds, of which 51 were scanned (14.8%), 59 were policy-checked (17.1%), and 34 were deployed in the same run (9.9%). On the artifact side: 13 registered, 12 with an SBOM, 7 vulnerability-scanned, 9 stored in the registry, 1 deployed, 0 signed. 294 builds were never scanned. 12 deployments used an image with no SBOM.
- Supply-chain signing, provenance, and compliance have no rows in the last 6 months, so the attested stage is carried by policy evaluations and the signed count is zero. The supply-chain deep dive uses a 2-year window and does show historical signing and compliance.
- Most CD deployments do not record an artifact name, so artifact-level deploy matching is limited to the deployments that do.
- Filters: Organization, Project, and Pipeline apply to every module. Service and Environment apply to CD. Artifact Type applies to supply chain. Registry applies to Artifact Registry.

## Example file

Import [`dashboards.json`](dashboards.json) from Dashboards. It is a Dashboards 3.0 document at schema `1.15.0`

[Back to the examples](../README.md)
