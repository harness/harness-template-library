# CD Service & Environment Operations

Operational view of service deployments across environments and infrastructure: where things are deployed, what is running, how long deployments take and what is failing.

**Persona:** Release management and operations  
**Modules:** CD  
**Kind:** Persona  
**Tags:** CD, Release Management, Operations, Custom  
**Published:** 2026-11-17 01:36:28 UTC  
[Back to the examples](../README.md)

## Why this dashboard exists

This is the operations view of where software is running. It shows which services landed in which environments, what infrastructure and strategy was used, how long those deployments took, what is currently active, and which deployments failed.

## Who should open it

Release managers, SREs, and environment owners who need to know what is deployed where.

## Questions it answers

- Which services deployed, into which environments, and how often?
- What is the mix of environment type, deployment type, and execution strategy?
- Where are the active instances, and which recent deployments failed?

## Time range and filters

The dashboard opens on **Last 1 month**. The date picker is on, and every data widget inherits it. Changing the range recalculates every number on the page.

Filters: **Project**, **Service**, **Environment**, **Environment Type**.

Each filter is a multi-select. With nothing selected, the widget shows all values. Selecting a value limits the widgets that have that field. A filter is left off a widget that does not have the column, so the widget stays populated.

## What you will see

The service-by-environment matrix is the operational map: one row per service and environment pair, with volume and outcome. Active instances come from the service infrastructure inventory and are tied to deployments in the selected window. Duration trend is per service so a single slow service is visible.

### Overview

- **text.** ## Deployment Activity
- **metric.** Deployments
- **metric.** Services Deployed
- **metric.** Environments Targeted
- **metric.** Failed Deployments
- **chart.** Deployments by Service and Environment
- **donut.** Environment Type Split
- **chart.** Daily Deployments by Environment
- **chart.** Deployment Duration Trend by Service
- **text.** ## Runtime & Infrastructure
- **chart.** Active Instances by Service & Environment
- **donut.** Deployment Type
- **donut.** Execution Strategy
- **text.** ## Service x Environment Status
- **table.** Service x Environment Matrix
- **table.** Failed Deployments

## Data notes

- Default window is the last month, which matches an operational review.
- Many custom stages have no service, so service-level widgets omit them.
- Project, Service, Environment, and Environment Type filters apply to every widget.

## Example file

Import [`dashboards.json`](dashboards.json) from Dashboards. It is a Dashboards 3.0 document at schema `1.15.0`

[Back to the examples](../README.md)
