# AR Deep Dive: Artifact Registry Intelligence 360

360-degree deep dive into Harness Artifact Registry activity: push/pull traffic, registries, packages and versions, principals and client IPs, dependency-firewall posture, registry change audit, and supply-chain correlation of AR-hosted digests with SCS SBOM/vulnerability data and CD deployments.

**Persona:** All registry personas  
**Modules:** Artifact Registry, with SCS and CD correlation  
**Kind:** Deep dive  
**Tags:** AR, Artifact Registry, Deep Dive, 360, Correlation, All Personas, Custom  
**Published:** 2026-11-17 19:36:14 UTC  
[Back to the examples](../README.md)

## Why this dashboard exists

This is the full Artifact Registry workspace: who pushed and pulled, which registries and packages, which versions were overwritten, which clients and IPs called the registry, whether the dependency firewall blocked anything, what changed in registry configuration, and whether a stored digest also has an SBOM and a deployment.

## Who should open it

Registry administrators, platform engineers, and supply-chain reviewers.

## Questions it answers

- What is the push and pull volume, and when does it happen?
- Which registries, packages, and versions are active, and which versions were uploaded more than once?
- Who is calling the registry, from which IPs, and who is deleting?
- Are pulls covered by a firewall policy set?
- Which stored digests have an SBOM, and which packages were actually deployed?

## Time range and filters

The dashboard opens on **Last 12 months**. The date picker is on, and every data widget inherits it. Changing the range recalculates every number on the page.

Filters: **Organization**, **Project**, **Registry**, **Package Type**, **Action**, **User**, **Registry Type**.

Each filter is a multi-select. With nothing selected, the widget shows all values. Selecting a value limits the widgets that have that field. A filter is left off a widget that does not have the column, so the widget stays populated.

## What you will see

Registry version names are the characters 01 followed by the image digest. That matches the digest stored on the supply-chain artifact, so SBOM size, vulnerability counts, and signing status can be attached to a registry version. Package names are matched to the image name on CD deployments. The lifecycle table shows, per package, whether it was pushed, whether it has an SBOM, and whether CD deployed it. Anomaly rows flag principals with more deletes than average or more than twice the average spread of client IPs.

### Overview

- **text.** # AR Deep Dive: Artifact Registry Intelligence 360
- **metric.** Total AR Events
- **metric.** Uploads (Pushes)
- **metric.** Downloads (Pulls)
- **metric.** Unique Packages
- **metric.** Unique Versions
- **metric.** Registries Touched
- **metric.** Active Principals
- **metric.** Firewall Blocks
- **metric.** Deletes
- **metric.** Pull : Push Ratio
- **metric.** Automation Share
- **metric.** Client IPs

### Executive Summary

- **text.** ### Health at a glance
- **gauge.** Firewall Pass Rate
- **gauge.** Human-Initiated Share
- **gauge.** SBOM Coverage of AR Digests
- **chart.** Weekly Activity by Action
- **donut.** Action Mix
- **table.** Registry Scorecard
- **donut.** Package Type Mix

### Traffic & Trends

- **metric.** Active Days
- **chart.** Push vs Pull Volume with Pull:Push Ratio (dual axis)
- **chart.** Daily Events by Action (grouped)
- **chart.** Cumulative Pushes & Pulls
- **table.** When Does AR Get Used? Weekday x Hour (UTC) Heatmap
- **chart.** Weekly Events by Principal Type (stacked area)
- **chart.** Hour-of-Day Profile (UTC)
- **table.** Month-over-Month Comparison

### Registries

- **chart.** Top Registries by Activity (stacked by action)
- **donut.** Registry Type Mix
- **table.** Registry Leaderboard
- **table.** Registry x Action Pivot
- **chart.** Registry Footprint: Packages vs Events (scatter)
- **table.** Registry Lifecycle (created / updated / deleted)

### Packages & Versions

- **metric.** Packages
- **metric.** Versions (digests)
- **metric.** Versions per Package
- **metric.** Re-uploaded Versions
- **chart.** Top Packages: Downloads vs Uploads
- **table.** Version Sprawl by Package
- **table.** Newest Version per Package
- **table.** Re-upload / Overwrite Candidates
- **table.** Destructive Operations (deletes)
- **table.** Package x Month Activity Pivot

### Users, Clients & Access

- **donut.** Events by Principal Type
- **donut.** HTTP Request Methods
- **chart.** Actions by Principal (stacked)
- **table.** Principal Leaderboard
- **table.** Client IP Intelligence
- **table.** Access Anomalies: Principals vs Average
- **table.** Principal Type x Request Method

### Dependency Firewall & Policy

- **metric.** Blocked Requests
- **metric.** Pulls with Policy Set
- **metric.** Block Rate
- **gauge.** Policy Coverage of Pulls
- **chart.** Allowed vs Blocked Pulls with Block Rate (dual axis)
- **table.** Block Reasons x Policy Sets
- **donut.** Request Outcome
- **table.** Ungoverned Pulls: Packages Downloaded Without a Policy Set
- **table.** Registry Type x Outcome Pivot

### Change Audit

- **metric.** Creates
- **metric.** Updates
- **metric.** Deletes
- **chart.** Weekly Configuration Changes
- **table.** Change Log with Old / New Values
- **table.** Actor x Change Type
- **table.** Change Timeline by Project

### Supply Chain Correlation

- **metric.** Digests with SBOM
- **metric.** CD Deploys of AR Images
- **metric.** Vulnerabilities on AR Digests
- **gauge.** Deployed Package Share
- **gauge.** Vulnerability-Free SBOM Digests
- **table.** Digest-Level Correlation: AR Activity x SBOM x Vulnerabilities
- **chart.** Package Consumption vs Vulnerabilities (dual axis)
- **chart.** SBOM Size vs Vulnerabilities per Digest (scatter)
- **table.** Artifact Lifecycle Chain: Uploaded -> SBOM -> Deployed
- **table.** CD-Deployed Images: AR-Hosted or External?
- **table.** SCS Inventory of AR-Hosted Artifacts (pkg.harness.io)
- **chart.** Uploaded vs Deployed per Week (side by side)

## Data notes

- Default window is the last 12 months. Registry activity in this account runs from March 2026 to November 2026, 209 events.
- There are no firewall blocks and no policy sets yet. The firewall tab shows that pulls are ungoverned, and it will populate when blocks exist.
- Null firewall fields are labeled Untyped, No policy set, or Not blocked.
- STO issues have no image fields here, so vulnerability counts come from the supply-chain artifact rather than from STO directly.
- Filters: Organization, Project, Registry, Package Type, Action, User, Registry Type.
- In the published window: 80 uploads, 110 downloads, 7 packages, 66 versions, 33 registries, 4 principals, 63 client IPs. 11 of 66 digests have an SBOM. 1 of 7 packages was deployed (cosmos-finance-backend).

## Example file

Import [`dashboards.json`](dashboards.json) from Dashboards. It is a Dashboards 3.0 document at schema `1.15.0`

[Back to the examples](../README.md)
