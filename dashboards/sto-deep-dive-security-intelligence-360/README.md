# STO Deep Dive: Security Intelligence 360

360-degree Security Testing Orchestration deep dive: posture, issues and severity, target coverage, scanner operations, exposure aging, exemptions, CI/CD pipeline correlation (scanned builds, security gates in deploy pipelines, vulnerable images deployed, SCS artifacts) and STO usage.

**Persona:** All security personas  
**Modules:** STO, with CI, CD, and SCS correlation  
**Kind:** Deep dive  
**Tags:** STO, Security, Deep Dive, 360, Correlation, All Personas, Custom  
**Published:** 2026-11-17 19:35:08 UTC  
[Back to the examples](../README.md)

## Why this dashboard exists

This is the full security-testing workspace. Posture, issue detail, target coverage, scanner operations, aging, exemptions, pipeline integration, and license usage share one filter set. CI builds, CD deployments, and supply-chain artifacts are joined to scans on the pipeline execution id, so the dashboard can say which builds were scanned and which deployed images have a scan.

## Who should open it

Security leadership, AppSec, and DevSecOps working from one filtered workspace.

## Questions it answers

- Is open risk growing, and which projects hold it?
- Which CVEs, CWEs, scanners, and targets should be worked first, and which targets have never been scanned?
- How old is the backlog, and which critical findings are older than average?
- Which exemptions are in effect, and which scans do they suppress?
- Which CI builds were scanned, which deploy pipelines have a security gate, and which deployed images lack a scan?

## Time range and filters

The dashboard opens on **Last 6 months**. The date picker is on, and every data widget inherits it. Changing the range recalculates every number on the page.

Filters: **Organization**, **Project**, **Target**, **Target Type**, **Scanner**, **Pipeline**, **Severity**, **Exempted**.

Each filter is a multi-select. With nothing selected, the widget shows all values. Selecting a value limits the widgets that have that field. A filter is left off a widget that does not have the column, so the widget stays populated.

## What you will see

The executive tab tracks open findings against a weighted risk score. Coverage is scanned targets over known targets. Aging cohorts bucket open issues by how long they have been open, split by severity. The pipeline tab joins STO to CI on plan execution id and compares scanned and unscanned builds. Deployed-image coverage uses the image name recorded on the deployment.

### Overview

- **text.** # STO Deep Dive: Security Intelligence 360
- **metric.** Active Critical & High Issues
- **metric.** Vulnerable Targets
- **metric.** Security Scans Run
- **metric.** Mean Time Open (Critical/High)
- **gauge.** Scan Coverage
- **gauge.** Scan Success Rate
- **gauge.** Critical & High Share
- **gauge.** CI Builds with Security Scans

### Executive Posture

- **text.** ### Executive Posture: how exposed are we, and is it getting better?
- **chart.** Open Findings vs Risk Score (Daily)
- **donut.** Active Issues by Severity
- **chart.** Weekly Scans vs New Detections
- **table.** Riskiest Projects

### Issues & Severity

- **text.** ### Issues & Severity: what is wrong, where it comes from, and what keeps coming back
- **table.** Severity x Scanner Pivot
- **chart.** Open Findings by Issue Type
- **chart.** Blast Radius: Targets vs Occurrences
- **table.** CVE Leaderboard
- **table.** CWE Leaderboard
- **table.** Recurring Issues Across Scans

### Targets & Coverage

- **text.** ### Targets & Coverage: what we scan, what we miss, and which targets carry the risk
- **gauge.** Coverage %
- **donut.** Target Inventory by Type
- **chart.** Coverage by Target Type
- **table.** Target Risk Leaderboard
- **table.** Variants & Branches Scanned
- **table.** Unscanned Targets
- **table.** Open Findings: Project x Target Type

### Scanners & Scans

- **text.** ### Scanners & Scans: volume, reliability, speed and the scanner mix
- **chart.** Weekly Scans by Outcome
- **donut.** Scan Mode
- **donut.** Baseline vs Branch Scans
- **chart.** Scan Duration vs Volume by Scanner
- **table.** Scanner x Month Heatmap
- **table.** Recent Scans (drill into executions)

### Exposure Aging & Remediation

- **text.** ### Exposure Aging & Remediation: how long risk stays open
- **metric.** Mean Time Open (All)
- **chart.** Age Cohorts by Severity
- **chart.** Detection Trend with Cumulative Exposure
- **donut.** Remediation Status of New Detections
- **table.** Mean Time Open by Scanner & Target Type
- **table.** Aging Outliers: Critical/High Older Than Average

### Exemptions & Governance

- **text.** ### Exemptions & Governance: accepted risk in effect during the period
- **metric.** Exemptions In Effect
- **gauge.** Active Issues Under Exemption
- **donut.** Exemptions by Status
- **table.** Exemption Register
- **table.** Scans Governed by Exemptions

### Pipeline Integration

- **text.** ### Pipeline Integration: STO correlated with CI builds, CD deployments and SCS artifacts (joined on plan_execution_id / image)
- **metric.** Scanned CI Builds
- **metric.** Scan Share of Pipeline Time
- **table.** Scanned Builds by Repository & Branch
- **chart.** CI Build Outcome: Scanned vs Unscanned
- **chart.** Weekly Scanned Builds vs Build Failure Rate
- **table.** Security Gates in Deploy Pipelines
- **panel.** CD Correlation: Images Deployed vs STO
- **table.** SCS Artifacts Scanned by STO

### Pipeline Integration — CD Correlation: Images Deployed vs STO

- **table.** Vulnerable Images Deployed
- **table.** Deployed Images: STO Scan Coverage

### Usage

- **text.** ### Usage: STO licensing consumption and scanner catalog
- **metric.** Active STO Users
- **metric.** Billable Scan Events
- **chart.** Usage Trend by Type
- **table.** Scanner Catalog & Activity

## Data notes

- Default window is the last 6 months.
- Filters: Organization, Project, Target, Target Type, Scanner, Pipeline, Severity, Exempted.
- STO issues in this account have no image digest, so image correlation uses the image name on the CD deployment and the scan's pipeline execution.

## Example file

Import [`dashboards.json`](dashboards.json) from Dashboards. It is a Dashboards 3.0 document at schema `1.15.0`

[Back to the examples](../README.md)
