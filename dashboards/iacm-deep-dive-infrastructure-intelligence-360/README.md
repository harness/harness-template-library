# IaCM Deep Dive: Infrastructure Intelligence 360

Everything Infrastructure-as-Code Management in one place: workspaces, resources, providers, modules, IaC executions (init/plan/apply/destroy/drift), Git sources, tags, policy-as-code and cross-view correlations.

**Persona:** All infrastructure personas  
**Modules:** IaCM, with policy correlation  
**Kind:** Deep dive  
**Tags:** IaCM, Deep Dive, 360, Correlation, All Personas, Custom  
**Published:** 2026-11-17 19:43:09 UTC  
[Back to the examples](../README.md)

## Why this dashboard exists

This is the full Infrastructure as Code workspace. It covers the estate (workspaces, resources, providers, modules), the operations against that estate (plan, apply, destroy, drift, approvals), the Git sources, tag and policy governance, and the correlations between inventory and executions.

## Who should open it

Platform and infrastructure engineers, and anyone reviewing IaC health for an account.

## Questions it answers

- How many workspaces and resources exist, and which workspaces are drifted, failed, or stale?
- What is the mix of provisioners, resource types, and modules, and where has module version sprawl started?
- Do applies, destroys, and drift checks succeed, and how long do stages take?
- Which workspaces are tagged, have cost estimation on, and pass policy?
- Do projects with more infrastructure also run more, and fail more?

## Time range and filters

The dashboard opens on **Last 6 months**. The date picker is on, and every data widget inherits it. Changing the range recalculates every number on the page.

Filters: **Organization**, **Project**, **Workspace**, **Provisioner**, **Provider**, **Status**, **Repository**.

Each filter is a multi-select. With nothing selected, the widget shows all values. Selecting a value limits the widgets that have that field. A filter is left off a widget that does not have the column, so the widget stays populated.

## What you will see

Workspace counts are workspaces alive at the end of the window. A stale workspace was not updated during the window. Resource timestamps for created and synced are empty in this account, so resource freshness uses last-seen. Execution records do not name the workspace, so execution correlations are by project and pipeline, and the provisioner-version failure table attributes failures at the project level. Policy evaluations join on the pipeline run.

### Overview

- **text.** # IaCM Deep Dive: Infrastructure Intelligence 360
- **metric.** Workspaces (as of window end)
- **metric.** New Workspaces
- **metric.** Resources Tracked
- **metric.** IaCM Pipeline Executions
- **metric.** Failed IaCM Stages
- **metric.** p90 IaCM Stage Duration
- **metric.** Apply Operations
- **metric.** Destroy Operations
- **metric.** Drift Detections
- **metric.** Policy Evaluations
- **gauge.** IaCM Stage Success Rate
- **gauge.** Apply Step Success Rate
- **gauge.** Cost Estimation Adoption
- **gauge.** Workspace Convergence

### Executive Summary

- **text.** ### Infrastructure estate at a glance
- **donut.** Workspaces by Status
- **donut.** IaC Command Mix
- **chart.** Weekly IaCM Executions by Status
- **chart.** Workspace Growth: New per Week vs Cumulative
- **table.** Project 360 Scorecard
- **table.** Needs Attention: Drifted / Apply-Needed / Failed Workspaces

### Workspaces

- **panel.** Inventory Mix
- **table.** Project x Status Pivot
- **chart.** New Workspaces per Week by Provisioner
- **chart.** Feature Adoption by Provisioner
- **table.** Stale Workspaces (no update during the window)
- **table.** Workspace Inventory (full detail)

### Workspaces — Inventory Mix

- **donut.** Workspaces by Project (Top 15)
- **chart.** Provisioner Version Mix

### Resources & Providers

- **metric.** Resources
- **donut.** Resources by Mode
- **chart.** Top Resource Types
- **table.** Resources per Workspace Leaderboard
- **chart.** Sync Freshness: Days Since Last Seen
- **table.** Resource Type x Mode Pivot
- **table.** Resource Inventory (detail)

### Modules & Registry

- **metric.** Modules with Version Sprawl
- **table.** Module Usage Report
- **donut.** Module Sources
- **table.** Version Sprawl Pivot: Module x Version
- **table.** Modules per Workspace
- **table.** Version Sprawl Detail

### Executions & Operations

- **metric.** Approvals Rejected / Expired
- **chart.** Weekly IaC Steps by Command
- **table.** Command Scorecard
- **chart.** IACM Stage Duration p50 vs p90 (weekly)
- **chart.** Step Type Breakdown by Status
- **table.** IaCM Pipeline Leaderboard
- **table.** Failure Log: IaC Step Failures
- **table.** When IaC Runs: Day-of-Week x Hour Pivot
- **table.** Duration Outliers (> p90)

### Repositories & Git

- **metric.** Repositories
- **metric.** Workspaces without Provider Connector
- **chart.** Workspaces per Repository
- **chart.** Connector x Provisioner
- **table.** Repository Detail

### Tags & Governance

- **gauge.** Tag Coverage
- **gauge.** Policy Pass Rate (IaCM runs)
- **table.** Tag Key x Value Pivot
- **panel.** Policy-as-Code on IaCM Pipelines

### Tags & Governance — Policy-as-Code on IaCM Pipelines

- **donut.** Policy Results by Status
- **chart.** Policy Evaluations over Time by Policy
- **table.** Policy Evaluation Detail

### Correlations

- **text.** ### Cross-view correlations — inventory x operations x governance (joined on org/project, pipeline, plan_execution_id)
- **chart.** Workspaces vs Executions per Project
- **chart.** p90 Duration vs Failure Rate per Pipeline
- **chart.** Weekly Executions vs Failure Rate
- **chart.** Execution Volume vs Resources per Project
- **table.** Failure Rate vs Provisioner Version (project-attributed)
- **chart.** Runs vs Failure Rate by IaC Engine Plugin
- **table.** Project x Month Executions Pivot
- **table.** Approval Wait vs Outcome

## Data notes

- Default window is the last 6 months.
- Filters: Organization, Project, Workspace, Provisioner, Provider, Status, Repository. Execution and policy widgets only have organization and project, so only those two filters apply to them.
- Workspace names link to the IaCM workspace page. One workspace, eks_ap_south_1, holds most of the resources.
- In the published window: 44 workspaces, 89 resources, 113 pipeline runs, 36.8% stage success, 42 applies at 50% success, 3 drift checks all failed, 16 policy evaluations all passed.

## Example file

Import [`dashboards.json`](dashboards.json) from Dashboards. It is a Dashboards 3.0 document at schema `1.15.0`

[Back to the examples](../README.md)
