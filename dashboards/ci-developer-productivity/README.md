# CI Developer Productivity & Build Performance

Engineering-manager view of build speed, slow pipelines, busy repositories and branches, who triggers builds and how the build infrastructure performs.

**Persona:** Engineering manager  
**Modules:** CI  
**Kind:** Persona  
**Tags:** CI, Engineering Manager, Productivity, Custom  
**Published:** 2026-11-17 01:36:53 UTC  
[Back to the examples](../README.md)

## Why this dashboard exists

This is the manager view of build speed and developer load. It shows where time goes inside a build (setup versus execution), which pipelines and repositories are slow or busy, who is triggering builds, and how the build machines themselves perform.

## Who should open it

Engineering managers and developer-productivity leads who own cycle time for a team.

## Questions it answers

- Which pipelines are slow enough to interrupt developers?
- How much of stage time is machine setup rather than the build itself?
- Which repositories, branches, and people generate the build load?
- Does infrastructure (OS, resource class, Harness Cloud versus self-hosted) explain the slow builds?

## Time range and filters

The dashboard opens on **Last 1 month**. The date picker is on, and every data widget inherits it. Changing the range recalculates every number on the page.

Filters: **Project**, **Pipeline**, **Repository**.

Each filter is a multi-select. With nothing selected, the widget shows all values. Selecting a value limits the widgets that have that field. A filter is left off a widget that does not have the column, so the widget stays populated.

## What you will see

Average and 90th-percentile duration are both shown because a healthy median can hide a long tail. Setup time is reported separately from execution time so a slow pool of build machines is not mistaken for a slow test suite. Builds per developer is total builds divided by distinct triggering users.

### Overview

- **text.** ## Build Speed
- **metric.** Average Build Duration
- **metric.** P90 Build Duration
- **metric.** Average Stage Setup Time
- **metric.** Builds per Developer
- **chart.** Weekly Build Duration Trend
- **donut.** Build Duration Distribution
- **text.** ## Pipelines & Repositories
- **table.** Slowest Pipelines
- **table.** Busiest Repositories & Branches
- **text.** ## Developers & Triggers
- **donut.** Builds by Trigger Type
- **chart.** Top Developers by Builds
- **text.** ## Build Infrastructure
- **donut.** Stage Time by Infrastructure
- **chart.** Avg Stage Duration by OS & Resource Class
- **chart.** Setup vs Execution Time by Infrastructure

## Data notes

- Default window is the last month, which matches a sprint or monthly engineering review.
- Project, Pipeline, and Repository filters apply to every widget.

## Example file

Import [`dashboards.json`](dashboards.json) from Dashboards. It is a Dashboards 3.0 document at schema `1.15.0`

[Back to the examples](../README.md)
