# CD Deep Dive: Delivery Intelligence 360

Everything continuous delivery in one place: DORA, velocity, services, environments and infrastructure, reliability and rollbacks, approvals and OPA policy gates, change calendar and inventory hygiene, with cross-view correlations and drill-through to every execution.

**Persona:** All CD personas  
**Modules:** CD, with policy and approval correlation  
**Kind:** Deep dive  
**Tags:** CD, Deep Dive, 360, Correlation, DORA, All Personas, Custom  
**Published:** 2026-11-17 19:37:59 UTC  
[Back to the examples](../README.md)

## Why this dashboard exists

This is the full continuous-delivery workspace. DORA, velocity, services, environments, reliability, governance, the change calendar, and inventory hygiene share one date range and one set of filters. Policy evaluations are joined to the deployment on execution id, and the artifact each service shipped is taken from the infrastructure record of that same deployment.

## Who should open it

Release managers, SREs, and engineering leaders who want one delivery workspace instead of three separate dashboards.

## Questions it answers

- What are deployment frequency, change failure rate, lead time, and time to restore, by project and by week?
- Which services deploy where, with which artifact version, and which services have never deployed?
- Where do rollbacks and slow or failed steps concentrate?
- Did policy gates and approval gates pass, and how long did approvals wait?
- Which changes happened on weekends or outside working hours?

## Time range and filters

The dashboard opens on **Last 6 months**. The date picker is on, and every data widget inherits it. Changing the range recalculates every number on the page.

Filters: **Organization**, **Project**, **Service**, **Environment**, **Environment Type**, **Deployment Type**, **Pipeline**, **Status**.

Each filter is a multi-select. With nothing selected, the widget shows all values. Selecting a value limits the widgets that have that field. A filter is left off a widget that does not have the column, so the widget stays populated.

## What you will see

Change failure rate and time to restore use the same definitions as the CD executive dashboard. The service scatter plots change failure rate against deploy frequency so a busy, unstable service separates from a busy, stable one. Duration outliers are runs longer than twice the mean. Inventory tables list services, environments, and infrastructures that were not deployed to in the window, plus services quiet for 30 days or more.

### Overview

- **text.** # CD Deep Dive: Delivery Intelligence 360
- **metric.** Service Deployments
- **metric.** Services Deployed
- **metric.** Change Failure Rate
- **metric.** Median Lead Time
- **metric.** Mean Time to Restore
- **metric.** Rollbacks
- **gauge.** Deployment Success Rate
- **gauge.** OPA Policy Pass Rate

### Executive & DORA

- **text.** ### DORA at a glance — frequency, stability and speed
- **chart.** Weekly Deployments vs Change Failure Rate
- **donut.** Deployment Outcomes
- **table.** DORA Scorecard by Project
- **chart.** Monthly DORA Trend

### Velocity & Trends

- **chart.** Daily Deployments by Environment Type
- **chart.** Weekly Median vs P90 Deployment Duration
- **table.** Pipeline Velocity Leaderboard
- **chart.** Pipeline Duration vs Failure Rate

### Services

- **metric.** Artifact Versions Shipped
- **table.** Service Leaderboard
- **table.** Service x Environment Deployment Matrix
- **table.** Artifacts & Versions Deployed per Service
- **chart.** Top Services by Outcome
- **chart.** Deployment Types per Service

### Environments & Infrastructure

- **donut.** Environment Type
- **donut.** Deployment Type
- **chart.** Infrastructure Load vs Failure Rate
- **table.** Environment & Infrastructure Matrix
- **table.** Active Instances by Service
- **chart.** Helm Charts Deployed by Service
- **table.** Environment Tags on Targeted Environments

### Reliability & Rollbacks

- **chart.** Change Failure Rate vs Deploy Frequency per Service
- **chart.** Weekly Failures vs Rollback Rate
- **table.** Time to Restore per Service
- **chart.** Step Failures by Step Type & Failure Type
- **table.** Top Failure Messages
- **table.** Failed & Rolled-back Deployments (drill-through)
- **table.** Duration Outliers (> 2x mean)

### Governance

- **panel.** OPA Policy Gates on CD Deployments
- **panel.** Approval Gates & Runtime Inputs

### Governance — OPA Policy Gates on CD Deployments

- **chart.** Policy Results by Policy
- **table.** Policy Gates on Deployments (drill-through)

### Governance — Approval Gates & Runtime Inputs

- **donut.** Approval Outcomes
- **chart.** Weekly Approvals & Median Wait
- **table.** Approval Log (drill-through)
- **chart.** Most-Used Runtime Inputs

### Change Calendar

- **metric.** Weekend Deployments
- **metric.** Out-of-Hours Deployments
- **table.** Deployment Heatmap: Weekday x Hour (UTC)
- **chart.** Weekday Volume & Failure Rate
- **table.** Weekend & Out-of-Hours Changes (drill-through)

### Inventory

- **table.** Services Never Deployed in Period
- **table.** Stale Services (no deploy in last 30 days of period)
- **table.** Environments Never Deployed To
- **table.** Infrastructures Never Deployed To
- **donut.** Templates by Entity Type
- **table.** CD Pipeline Inventory & Activity

## Data notes

- Default window is the last 6 months. A 90-day window hides the Helm deployments, which are older than that.
- This account has had one Production deployment, so DORA here describes pre-production health.
- Time to restore is computed. The product column is always zero in this account.
- Artifact image and tag are recorded on 13 deployments, so the artifact-per-service table is sparse.
- Filters: Organization, Project, Service, Environment, Environment Type, Deployment Type, Pipeline, Status. Approval and runtime-input widgets honor Organization, Project, Pipeline, and Status.

## Example file

Import [`dashboards.json`](dashboards.json) from Dashboards. It is a Dashboards 3.0 document at schema `1.15.0`

[Back to the examples](../README.md)
