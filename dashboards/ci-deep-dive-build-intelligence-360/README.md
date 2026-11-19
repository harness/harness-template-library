# CI Deep Dive: Build Intelligence 360

Everything CI in one place: throughput, duration percentiles and outliers, failure forensics, flaky pipelines and MTTR, repositories/branches/commits, developers and triggers, build infrastructure and cost proxies, pipeline and template inventory, and security scans / policy evaluations correlated to CI executions.

**Persona:** All CI personas  
**Modules:** CI, with STO and policy correlation  
**Kind:** Deep dive  
**Tags:** CI, Deep Dive, 360, Correlation, All Personas, Custom  
**Published:** 2026-11-17 19:34:10 UTC  
[Back to the examples](../README.md)

## Why this dashboard exists

This is the full CI workspace. The eight persona dashboards above each answer one question; this one keeps throughput, duration, failures, source control, developers, infrastructure cost, pipeline inventory, and security-and-policy correlation in a single dashboard with shared filters. Security scans and policy evaluations are joined to the CI execution that produced them, so a build can be read together with the scan and the policy result from the same run.

## Who should open it

Anyone who needs the whole CI system rather than a single persona slice: platform, engineering management, and security engineering sharing one filtered view.

## Questions it answers

- What is build volume, success, and speed, and which projects moved in the last 30 days?
- Where does build time go, and which runs are slower than their own pipeline's 90th percentile?
- Which pipelines are flaky, what do the failures say, and how fast does each pipeline recover?
- Which repositories, branches, commits, developers, and triggers create the load, and when do they run?
- How many build hours and credits does each infrastructure, OS, and resource class consume?
- Which pipelines and templates exist, which of them actually run, and which builds were scanned or policy-checked?

## Time range and filters

The dashboard opens on **Last 6 months**. The date picker is on, and every data widget inherits it. Changing the range recalculates every number on the page.

Filters: **Organization**, **Project**, **Pipeline**, **Repository**, **Branch**, **Status**, **Trigger Type**, **Infrastructure**, **OS**.

Each filter is a multi-select. With nothing selected, the widget shows all values. Selecting a value limits the widgets that have that field. A filter is left off a widget that does not have the column, so the widget stays populated.

## What you will see

A headline strip of metrics and gauges sits above eight tabs, and every tab shares the same nine filters and the same date picker. Recovery time is per pipeline. Flaky pipelines are those whose status alternates. Outlier runs are slower than that pipeline's own 90th percentile, not slower than a global cutoff. Security and policy rows join to CI on the plan execution id, so a scan is counted only when it happened in that build.

### Overview

- **text.** # CI Deep Dive: Build Intelligence 360
- **metric.** Total Builds
- **metric.** Success Rate
- **metric.** Median Build Time
- **metric.** P90 Build Time
- **metric.** Build Hours
- **metric.** Active Developers
- **gauge.** Build Success Rate
- **gauge.** Automated Trigger Share
- **gauge.** Security-Scanned Builds
- **gauge.** Stage Setup Overhead

### Executive & Throughput

- **text.** ### Volume, outcomes and momentum
- **chart.** Daily Builds vs Success Rate
- **donut.** Build Status Mix
- **chart.** Weekly Builds by Outcome
- **table.** Momentum: Last 30 Days vs Prior 30 Days
- **table.** Project x Status Matrix
- **table.** Organization & Project Scorecard

### Performance & Duration

- **text.** ### How fast builds are, where the time goes, and which runs are outliers
- **chart.** Weekly Build Time Percentiles
- **donut.** Build Time Distribution
- **chart.** Daily Longest vs Median Build
- **chart.** Pipeline Speed vs Failure Rate
- **chart.** Setup vs Execution Time by Infrastructure
- **chart.** Stage Minutes by OS and Resource Class
- **chart.** Slowest Stages
- **table.** Slowest Pipelines
- **table.** Step Type Duration Profile
- **table.** Outlier Executions (Slower than Pipeline P90)

### Reliability & Failures

- **text.** ### Why builds fail, how often, how fast they recover and which pipelines are flaky
- **metric.** Failure Rate
- **metric.** Aborted & Expired
- **metric.** Mean Time to Recovery
- **chart.** Weekly Failure Rate vs Failed Builds
- **donut.** Stage Failure Categories
- **chart.** Failed Steps by Step Type
- **table.** MTTR by Pipeline
- **table.** Flaky Pipelines (Alternating Status)
- **table.** Top Step Failure Messages
- **table.** Recent Unsuccessful Builds

### Repos, Branches & Commits

- **text.** ### Source code view: repositories, branch leaderboard and commit-level history
- **metric.** Repositories Built
- **metric.** Branches Built
- **metric.** Commits Built
- **chart.** Repositories by Build Outcome
- **donut.** Builds by SCM Provider
- **table.** Branch Leaderboard
- **table.** Commit-Level History

### Developers & Triggers

- **text.** ### Who builds, when they build and what starts the builds
- **donut.** Builds by Trigger Type
- **chart.** Weekly Builds by Trigger Type
- **chart.** Top Developers by Outcome
- **chart.** Weekly Active Developers vs Builds
- **table.** When Builds Run: Weekday x Hour (UTC)
- **table.** Developer Scorecard
- **table.** Trigger Catalog

### Infrastructure & Cost

- **text.** ### Build machines, minutes and credits (cost proxies)
- **metric.** Stage Build Hours
- **metric.** CI Credits Consumed
- **gauge.** Harness Cloud Share of Hours
- **donut.** Build Minutes by Infrastructure
- **chart.** Weekly Stage Hours by Infrastructure
- **chart.** Credits by OS and Resource Class
- **table.** Infrastructure Matrix
- **table.** Stage Hours: Infrastructure x OS
- **chart.** Weekly Build Minutes vs Optimized Builds

### Pipeline Inventory & Templates

- **text.** ### What exists vs what runs: pipelines, Git storage, freshness and templates
- **metric.** Pipelines Updated
- **metric.** Templates Updated
- **donut.** Pipeline Freshness
- **chart.** Pipelines Created per Month
- **table.** Pipeline Inventory with Execution Health
- **donut.** Templates by Type
- **table.** Template Catalog
- **table.** Template Adoption by Pipelines

### Security & Governance

- **text.** ### Security scans and policy evaluations correlated to CI executions (joined by plan execution id)
- **metric.** CI Builds with Security Scans
- **metric.** Policy Evaluations on CI Runs
- **gauge.** Policy Pass Rate
- **donut.** Scans by Scanner
- **chart.** Weekly Builds: Scanned vs Not Scanned
- **chart.** Build Success: Scanned vs Not Scanned
- **donut.** Policy Results by Policy Set
- **table.** Governance Coverage by Pipeline
- **table.** CI Executions with Security Scans
- **table.** Policy Evaluations on CI Runs

## Data notes

- Default window is the last 6 months.
- Filters: Organization, Project, Pipeline, Repository, Branch, Status, Trigger Type, Infrastructure, OS.
- Pipeline names link to the pipeline page. Execution rows link to the execution page.

## Example file

Import [`dashboards.json`](dashboards.json) from Dashboards. It is a Dashboards 3.0 document at schema `1.15.0`

[Back to the examples](../README.md)
