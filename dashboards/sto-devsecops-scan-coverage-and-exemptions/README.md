# STO DevSecOps Scan Coverage & Exemptions

Operational and compliance view for DevSecOps: scan volume and reliability, scanner and pipeline coverage, stale targets, exemptions in effect and STO usage.

**Persona:** DevSecOps and compliance  
**Modules:** STO  
**Kind:** Persona  
**Tags:** STO, Security, DevSecOps, Compliance, Custom  
**Published:** 2026-11-17 01:43:43 UTC  
[Back to the examples](../README.md)

## Why this dashboard exists

This is the operational and compliance view of security scanning. It covers whether scans are running and succeeding, which pipelines and scanners do the work, which targets have gone stale, which findings are exempted, and how much STO usage that generates.

## Who should open it

DevSecOps engineers, security operations, and compliance reviewers who need evidence of scan coverage.

## Questions it answers

- Are scans succeeding, and which scanners and target types produce the volume?
- Which pipelines run security scans, and which targets have not been scanned recently?
- Which exemptions are in effect, and what severity do they cover?
- How many people use STO, and how many billable scan events does that create?

## Time range and filters

The dashboard opens on **Last 3 months**. The date picker is on, and every data widget inherits it. Changing the range recalculates every number on the page.

Filters: **Organization**, **Project**, **Target**, **Scanner**, **Pipeline**, **Severity**.

Each filter is a multi-select. With nothing selected, the widget shows all values. Selecting a value limits the widgets that have that field. A filter is left off a widget that does not have the column, so the widget stays populated.

## What you will see

Scan success rate is successful scans divided by scans run. A target is stale when it exists in the inventory and has no scan in the selected window. Exemptions in effect are exemptions whose window overlaps the selected dates. Usage counts active users and billable scan events.

### Overview

- **text.** ## Scan Operations
- **metric.** Scans Run
- **metric.** Scan Success Rate
- **metric.** Pipelines Running Scans
- **metric.** Targets Scanned
- **chart.** Scan Volume Trend
- **donut.** Scan Outcomes
- **chart.** Scans by Scanner
- **donut.** Scans by Target Type
- **donut.** Baseline vs Branch Scans
- **text.** ## Pipeline & Target Coverage
- **table.** Pipelines Running Security Scans
- **table.** Targets Without Recent Scans
- **text.** ## Exemptions & STO Usage
- **metric.** Exemptions In Effect
- **metric.** Active STO Users
- **metric.** Billable Scan Events
- **donut.** Exemptions by Status
- **chart.** Exempted Issues by Severity
- **chart.** STO Usage Trend
- **table.** Exemption Register

## Data notes

- Default window is the last 3 months.
- Organization, Project, Target, Scanner, Pipeline, and Severity filters apply to every widget.

## Example file

Import [`dashboards.json`](dashboards.json) from Dashboards. It is a Dashboards 3.0 document at schema `1.15.0`

[Back to the examples](../README.md)
