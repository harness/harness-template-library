# CI Reliability & Failure Analysis

Platform/DevOps view of CI failure rate, where failures concentrate, why builds fail, aborted and expired runs, and how quickly pipelines recover.

**Persona:** Platform engineering  
**Modules:** CI  
**Kind:** Persona  
**Tags:** CI, Platform Engineering, Reliability, Custom  
**Published:** 2026-11-17 01:37:13 UTC  
[Back to the examples](../README.md)

## Why this dashboard exists

This is the reliability view of CI. It concentrates on what fails, where those failures cluster, the messages behind them, and how long a pipeline takes to go green again after a failure.

## Who should open it

Platform and DevOps engineers who own the build fleet and get paged when main goes red.

## Questions it answers

- What is the failure rate, and which projects and repositories drive it?
- Which step types and failure messages repeat?
- How many runs were aborted or expired rather than failed?
- How long does a failing pipeline take to recover?

## Time range and filters

The dashboard opens on **Last 1 month**. The date picker is on, and every data widget inherits it. Changing the range recalculates every number on the page.

Filters: **Project**, **Pipeline**, **Repository**.

Each filter is a multi-select. With nothing selected, the widget shows all values. Selecting a value limits the widgets that have that field. A filter is left off a widget that does not have the column, so the widget stays populated.

## What you will see

Mean time to recovery is the gap from a failed build to the next successful build of the same pipeline. Aborted and expired runs are counted apart from failures so a cancelled build is not treated as a broken test. The recent-unsuccessful table is the working queue: each row can be opened as a pipeline execution.

### Overview

- **text.** ## Reliability KPIs
- **metric.** Build Failure Rate
- **metric.** Failed Builds
- **metric.** Aborted & Expired Builds
- **metric.** Mean Time to Recovery
- **chart.** Weekly Failure Rate & Failed Builds
- **donut.** Stage Failure Categories
- **text.** ## Where Failures Happen
- **chart.** Failures by Project
- **chart.** Failures by Repository
- **donut.** Failed Steps by Step Type
- **table.** Top Failing Pipelines
- **text.** ## Failure Reasons & Interrupted Runs
- **table.** Top Step Failure Messages
- **chart.** Aborted & Expired Builds by Week
- **table.** Recent Unsuccessful Builds

## Data notes

- Default window is the last month.
- Project, Pipeline, and Repository filters apply to every widget.

## Example file

Import [`dashboards.json`](dashboards.json) from Dashboards. It is a Dashboards 3.0 document at schema `1.15.0`

[Back to the examples](../README.md)
