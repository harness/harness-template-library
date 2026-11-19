# SCS Deep Dive: Software Supply Chain Intelligence 360

Everything Software Supply Chain Security in one place: artifact inventory, SBOM quality and component risk (EOL, deprecated, vulnerable, licences), STO vulnerability exposure per artifact, CI/CD pipeline compliance (OWASP), signing and SLSA provenance attestation, OPA policy-as-code outcomes and SCS adoption, with cross-entity correlations and drill-through to Harness SCS.

**Persona:** All supply-chain personas  
**Modules:** SCS, with STO, compliance, and policy correlation  
**Kind:** Deep dive  
**Tags:** SCS, SSCA, Supply Chain, Deep Dive, 360, Correlation, All Personas, Custom  
**Published:** 2026-11-17 19:35:04 UTC  
[Back to the examples](../README.md)

## Why this dashboard exists

This is the full software supply chain workspace. It follows an artifact from registration through its SBOM, the components inside that SBOM, the vulnerabilities attached to the artifact, the CI/CD compliance rules, the signature and SLSA provenance, the policy-as-code decision, and the adoption of those controls by project.

## Who should open it

Supply-chain security, compliance, and platform engineers who need one view of artifact posture.

## Questions it answers

- What share of artifacts have an SBOM, a signature, and provenance?
- Which components are end-of-life, deprecated, vulnerable, or widely reached?
- Which artifacts carry critical and high findings, and which STO scan produced them?
- Which compliance rules fail, and which policies deny?
- Which projects have adopted supply-chain steps, and how often those steps succeed?

## Time range and filters

The dashboard opens on **Last 2 years**. The date picker is on, and every data widget inherits it. Changing the range recalculates every number on the page.

Filters: **Organization**, **Project**, **Artifact Type**, **Artifact Name**, **Severity**, **Compliance Category**, **Scan Type**, **Activity Type**.

Each filter is a multi-select. With nothing selected, the widget shows all values. Selecting a value limits the widgets that have that field. A filter is left off a widget that does not have the column, so the widget stays populated.

## What you will see

SBOM components are joined to the component catalogue, which is where end-of-life, deprecation, licence, and known-vulnerable flags come from. The SBOM licence field itself is NA in this account. Vulnerability counts are joined from STO scans of the same artifact. Compliance results are joined to the pipeline run that produced them. Policy denial rate is plotted against that pipeline's failure rate.

### Overview

- **text.** # SCS Deep Dive: Software Supply Chain Intelligence 360
- **metric.** Artifacts Tracked
- **metric.** SBOM Coverage
- **metric.** Signed Containers
- **metric.** Provenance Coverage
- **metric.** Critical Vulnerabilities
- **metric.** Risky Components
- **gauge.** Compliance Pass Rate
- **gauge.** OPA Policy Pass Rate
- **metric.** Failed Compliance Checks
- **metric.** Distinct Packages in SBOMs
- **metric.** SCS Activity Events

### Executive Posture

- **text.** ### Coverage funnel and posture by project
- **chart.** Supply Chain Control Coverage by Artifact Type
- **table.** Project Supply Chain Scorecard
- **chart.** Artifact Onboarding: Monthly New vs Cumulative
- **donut.** Artifact Type Mix
- **donut.** SBOM Format Mix
- **chart.** Vulnerability Exposure by Project
- **panel.** Control Coverage Gauges

### Executive Posture — Control Coverage Gauges

- **gauge.** SBOM Coverage (non-workflow)
- **gauge.** Verified Signatures (containers)

### Artifacts

- **text.** ### Artifact inventory, SBOM quality and lineage
- **chart.** Artifacts by Project and Type
- **chart.** SBOM Quality Score Distribution
- **donut.** SBOM Generation Tool
- **table.** Artifact Inventory (drill-through)
- **chart.** Correlation: SBOM Size vs Vulnerabilities
- **table.** Artifact Sources (registries & repos)
- **table.** Artifact Lineage: Repo, Branch, Commit and Pipelines

### SBOM & Components

- **text.** ### SBOM components joined to the component intelligence catalogue (EOL, deprecated, vulnerable, licences)
- **metric.** Avg Components per SBOM
- **metric.** EOL Packages
- **metric.** Outdated Component Share
- **chart.** Top Packages by Artifact Reach
- **donut.** Package Manager Mix
- **donut.** Language Mix
- **chart.** Top Licence Sets
- **chart.** Component Risk by Ecosystem
- **table.** EOL, Deprecated & Outdated Components
- **table.** Vulnerable Components Leaderboard
- **table.** Pivot: Package Manager x Artifact Type
- **table.** Components per Artifact (risk density)

### Vulnerabilities

- **text.** ### STO vulnerability exposure attached to supply-chain artifacts
- **metric.** Critical Findings
- **metric.** High Findings
- **metric.** Medium Findings
- **metric.** Low Findings
- **donut.** Severity Mix
- **chart.** Top 15 Most Vulnerable Artifacts
- **table.** Vulnerability Heat by Artifact (weighted risk & share)
- **chart.** Correlation: SBOM Quality vs Critical Findings
- **chart.** Exposure Trend by Last Update Month
- **table.** Correlation: Artifact to STO Scan Execution
- **table.** Outliers: Artifacts Above 2x Average Risk

### Compliance

- **text.** ### OWASP CI/CD compliance: rules, pipelines, trend and remediation
- **metric.** Rule Evaluations
- **metric.** Pipelines Evaluated
- **metric.** High-Severity Failures
- **chart.** Compliance Trend: Rules Passed vs Failed (weekly) and Fail Rate
- **donut.** Evaluation Outcome
- **table.** Failing Rules Leaderboard
- **table.** Pivot: Category x Severity (failed rules)
- **chart.** Compliance Outcome by Project
- **table.** Non-Compliant Pipelines (latest result per rule)
- **table.** Non-Compliant Artifacts (SCS view)

### Attestation & Provenance

- **text.** ### Signing, verification and SLSA provenance
- **metric.** Signed Artifacts
- **metric.** Verified Signatures
- **metric.** Provenance Attestations
- **donut.** Signature Verification Status
- **donut.** Provenance Status
- **gauge.** Provenance Verification Pass Rate
- **table.** Attestation Matrix & Derived SLSA Posture
- **chart.** Provenance Events by Month
- **table.** Provenance by Pipeline
- **chart.** Attestation Coverage by Project

### Policy as Code

- **text.** ### OPA policy-as-code evaluations: outcomes, denying policies and deny messages
- **metric.** Policy Evaluations
- **metric.** Errors (Deny)
- **metric.** Warnings
- **gauge.** Policy Pass Rate
- **chart.** Daily Evaluations by Outcome
- **donut.** Evaluations by Entity Type
- **table.** Top Denying Policies
- **table.** Pivot: Entity Type x Outcome
- **table.** Deny Messages (latest)
- **chart.** Correlation: Policy Denial Rate vs Pipeline Failure Rate
- **table.** Policy Set Outcomes (latest per entity)
- **table.** Pivot: Weekday x Hour (UTC) of Evaluations

### Activity & Adoption

- **text.** ### SCS activity, pipeline correlation and project adoption
- **metric.** Activity Steps
- **metric.** Pipelines Running SCS Steps
- **metric.** Projects Adopting SCS
- **chart.** Activity Over Time by Type
- **donut.** Execution Platform
- **table.** Project Adoption Summary
- **table.** SCS Activity Feed x Pipeline Executions
- **chart.** SCS Pipelines: Runs vs Success Rate
- **table.** Entity-Level Adoption Funnel by Project

## Data notes

- Default window is the last 2 years. Compliance results stop in October 2025 and provenance in May 2025, so a shorter default would leave those tabs empty.
- In the published window: 219 artifacts, 75.7% SBOM coverage, 23% of containers signed (10.7% verified), 389 critical and 592 high findings, 66.5% compliance pass, 94.1% policy pass. The most-failed compliance rule is authorization not enforced for custom triggers.
- Four filters (Artifact Type, Artifact Name, Severity, Compliance Category) take their dropdown values from supply-chain records. Whether those dropdowns populate in the product UI is unconfirmed.
- AI-BOM records are all zero, so there is no AI-BOM tab. Environment prod and non-prod counts are zero.
- Filters: Organization, Project, Artifact Type, Artifact Name, Severity, Compliance Category, Scan Type, Activity Type.

## Example file

Import [`dashboards.json`](dashboards.json) from Dashboards. It is a Dashboards 3.0 document at schema `1.15.0`

[Back to the examples](../README.md)
