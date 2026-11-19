# STO Executive Security Posture

Executive view of application security risk: active exposure, scan coverage, remediation velocity and the riskiest projects.

**Persona:** Security leadership  
**Modules:** STO  
**Kind:** Persona  
**Tags:** STO, Security, Executive, Security Posture, Custom  
**Published:** 2026-11-17 01:40:26 UTC  
[Back to the examples](../README.md)

## Why this dashboard exists

This is the executive view of application-security risk from Security Testing Orchestration. It shows how much critical and high exposure is open, whether scans are covering targets and succeeding, how fast findings are remediated, and which projects hold the risk.

## Who should open it

CISOs, heads of security, and engineering leaders who own security posture in a business review.

## Questions it answers

- How many critical and high issues are open, across how many targets?
- Are we scanning enough of the estate, and are those scans succeeding?
- Is new risk arriving faster than it is remediated?
- Which projects are the risk hotspots?

## Time range and filters

The dashboard opens on **Last 3 months**. The date picker is on, and every data widget inherits it. Changing the range recalculates every number on the page.

Filters: **Organization**, **Project**, **Target**, **Scanner**, **Severity**.

Each filter is a multi-select. With nothing selected, the widget shows all values. Selecting a value limits the widgets that have that field. A filter is left off a widget that does not have the column, so the widget stays populated.

## What you will see

Active issues are findings still open in the selected window. Mean time open is how long critical and high issues have stayed open. Scan coverage is targets scanned divided by targets known to STO. The risk-score trend weights severity so a shift from low to critical is visible even when the raw count is flat.

### Overview

- **text.** ## Risk at a Glance
- **metric.** Active Critical & High Issues
- **metric.** Unique Active Issues
- **metric.** Vulnerable Targets
- **metric.** Security Scans Run
- **metric.** Mean Time Open (Critical/High)
- **metric.** New Critical & High Detections
- **metric.** Critical & High Share
- **metric.** Scan Success Rate
- **text.** ## Exposure & Coverage
- **gauge.** Scan Coverage
- **donut.** Active Issues by Severity
- **chart.** Active Issues Trend
- **text.** ## Remediation Velocity & Risk Hotspots
- **chart.** New Detections vs Remediated
- **chart.** Risk Score Trend
- **table.** Top Vulnerable Projects
- **donut.** Active Issues by Issue Type

## Data notes

- Default window is the last 3 months.
- Organization, Project, Target, Scanner, and Severity filters apply to every widget.

## Example file

Import [`dashboards.json`](dashboards.json) from Dashboards. It is a Dashboards 3.0 document at schema `1.15.0`

[Back to the examples](../README.md)
