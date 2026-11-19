# CD Executive Delivery & DORA Overview

DORA metrics for continuous delivery: deployment frequency, change failure rate, lead time and time to restore, with delivery trends and a per-service scorecard.

**Persona:** Engineering leadership  
**Modules:** CD  
**Kind:** Persona  
**Tags:** CD, Executive, DORA, Custom  
**Published:** 2026-11-17 01:34:56 UTC  
[Back to the examples](../README.md)

## Why this dashboard exists

This is the leadership view of continuous delivery, organized around the four DORA metrics: how often you deploy, how often a change fails, how long a deployment takes, and how long a failed service takes to become healthy again. A per-service scorecard sits under the trends.

## Who should open it

VPs, directors of engineering, and release leaders reviewing delivery performance.

## Questions it answers

- How often do we deploy, and what share of those deployments fail?
- How long does a deployment take, and how long does a failed service take to recover?
- How does production volume compare with non-production?
- Which services carry the delivery load?

## Time range and filters

The dashboard opens on **Last 3 months**. The date picker is on, and every data widget inherits it. Changing the range recalculates every number on the page.

Filters: **Project**, **Service**, **Environment**, **Environment Type**.

Each filter is a multi-select. With nothing selected, the widget shows all values. Selecting a value limits the widgets that have that field. A filter is left off a widget that does not have the column, so the widget stays populated.

## What you will see

Change failure rate is failed service deployments divided by all service deployments. Median lead time is the median deployment duration. Mean time to restore is computed as the time from a failed deployment of a service to the next successful deployment of that same service, because the built-in restore column in this account is always zero. The change-failure gauge is banded against common DORA ranges.

### Overview

- **text.** ## DORA Key Metrics
- **metric.** Deployments
- **metric.** Change Failure Rate
- **metric.** Median Lead Time
- **metric.** Mean Time to Restore (proxy)
- **gauge.** Change Failure Rate vs DORA Bands
- **gauge.** Deployment Success Rate
- **donut.** Production vs Non-Production
- **donut.** Deployment Outcomes
- **text.** ## Delivery Trends
- **chart.** Weekly Deployment Frequency
- **chart.** Weekly Success Rate & Change Failure Rate
- **chart.** Weekly Lead Time (Median Deployment Duration)
- **chart.** Top Services by Deployments
- **text.** ## Service DORA Scorecard
- **table.** Service DORA Scorecard

## Data notes

- Default window is the last 3 months.
- This account has had a single Production deployment, so these DORA numbers describe pre-production delivery health.
- Project, Service, Environment, and Environment Type filters apply to every widget.

## Example file

Import [`dashboards.json`](dashboards.json) from Dashboards. It is a Dashboards 3.0 document at schema `1.15.0`

[Back to the examples](../README.md)
