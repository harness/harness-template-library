# Harness Business Value Realization (BVR)

Executive QBR view of the value Harness delivers across CI, CD and STO: adoption, velocity, delivery performance, security posture and estimated ROI.

**Persona:** Executive and QBR  
**Modules:** CI, CD, STO  
**Kind:** Cross-module  
**Tags:** BVR, Executive, CI, CD, STO, Business Value, QBR, Custom  
**Published:** 2026-11-17 01:43:48 UTC  
[Back to the examples](../README.md)

## Why this dashboard exists

This is the business-value dashboard for a quarterly business review. It puts adoption, CI velocity, CD delivery, and STO security on one page, then turns that activity into an estimated return: engineering hours automated, security-review hours avoided, failed deployments caught before production, and a dollar figure computed from those hours.

## Who should open it

Executives, customer-success leaders, and anyone presenting Harness value in a QBR.

## Questions it answers

- How widely is Harness used, across how many projects, pipelines, and modules?
- Is CI fast and green, and is CD deploying often with an acceptable failure rate?
- How much critical and high risk did scanning catch, and what share of pipelines are scanned?
- What is the estimated engineering and security time saved, in hours and in dollars?

## Time range and filters

The dashboard opens on **Last 6 months**. The date picker is on, and every data widget inherits it. Changing the range recalculates every number on the page.

Filters: **Organization**, **Project**, **Environment Type**.

Each filter is a multi-select. With nothing selected, the widget shows all values. Selecting a value limits the widgets that have that field. A filter is left off a widget that does not have the column, so the widget stays populated.

## What you will see

Adoption counts pipeline executions and splits them by module. CI and CD numbers use the same definitions as the executive dashboards for those modules. Security scan coverage is CI builds that had an STO scan divided by all CI builds, joined on the pipeline execution id. The ROI block is labeled as an estimate: it values automated engineering time at a fixed hourly rate, credits security-review time for findings caught in the pipeline, and counts failed deployments that happened outside production. The monthly value chart and the annualized savings figure both come from that model, so they move when the date range changes.

### Overview

- **text.** ## Harness Business Value Realization Value delivered across **CI, CD and STO** for the selected period. ROI figures are **estimates**: 2h manual effort saved per deployment, 0.25h
- **text.** ### Platform Adoption & Scale
- **metric.** Total Pipeline Executions
- **metric.** Active Projects
- **metric.** Active Pipelines
- **donut.** Executions by Module
- **chart.** Monthly Executions by Module
- **text.** ### Velocity — Continuous Integration
- **metric.** Builds
- **metric.** Build Success Rate
- **metric.** Median Build Time
- **chart.** Builds per Day by Outcome
- **text.** ### Delivery — Continuous Delivery & DORA
- **metric.** Deployments
- **metric.** Services Deployed
- **metric.** Deployment Frequency / Week
- **metric.** Median Deployment Duration
- **gauge.** Change Failure Rate
- **chart.** Weekly Deployments by Environment Type
- **text.** ### Security — Security Testing Orchestration
- **metric.** Security Scans Run
- **metric.** Active Critical / High Issues
- **metric.** Targets Scanned
- **gauge.** Pipeline Security Scan Coverage
- **chart.** Vulnerabilities Caught in Pipeline by Severity
- **text.** ### Value & ROI (Estimates)
- **metric.** Engineering Hours Automated
- **metric.** Estimated Savings ($)
- **metric.** Security Review Hours Saved
- **metric.** Failed Deployments Caught Pre-Prod
- **chart.** Monthly Value Delivered (Estimated)
- **metric.** Annualized Savings ($)
- **metric.** Critical / High Vulns Caught Pre-Release
- **text.** ### Project Scorecard & Top Services
- **table.** Project Scorecard — CI, CD & STO
- **table.** Top Services by Deployments
- **table.** Top Vulnerable Projects

## Data notes

- Default window is the last 6 months, which covers two quarters.
- Organization, Project, and Environment Type filters apply across the modules that have those fields.
- Dollar figures are a model, not an invoice. The assumptions are stated on the dashboard itself.
- This dashboard was republished as version 3. The file in this folder is that published version.

## Example file

Import [`dashboards.json`](dashboards.json) from Dashboards. It is a Dashboards 3.0 document at schema `1.15.0`

[Back to the examples](../README.md)
