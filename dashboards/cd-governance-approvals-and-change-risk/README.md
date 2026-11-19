# CD Governance, Approvals & Change Risk

Change-management view of continuous delivery: approval gates and wait times, change timing, failed/aborted changes and rollbacks, and who initiates changes with which runtime inputs.

**Persona:** Change management and governance  
**Modules:** CD  
**Kind:** Persona  
**Tags:** CD, Governance, Change Management, Custom  
**Published:** 2026-11-17 01:38:39 UTC  
[Back to the examples](../README.md)

## Why this dashboard exists

This is the change-management view of delivery. It covers approval gates and how long they wait, when changes happen (weekday and hour), which changes failed, aborted, or rolled back, and who started them with which runtime inputs.

## Who should open it

Change advisory boards, compliance partners, and release managers who approve production change.

## Questions it answers

- How many changes waited on an approval, and how long was the wait?
- What share of changes failed, aborted, or rolled back?
- Are changes clustering on particular weekdays or hours?
- Who triggers changes, and which runtime inputs are used most?

## Time range and filters

The dashboard opens on **Last 3 months**. The date picker is on, and every data widget inherits it. Changing the range recalculates every number on the page.

Filters: **Project**, **Service**, **Environment**, **Environment Type**.

Each filter is a multi-select. With nothing selected, the widget shows all values. Selecting a value limits the widgets that have that field. A filter is left off a widget that does not have the column, so the widget stays populated.

## What you will see

Approval wait is the time from the approval step opening to the decision. Rejected, expired, and aborted approvals are counted together as approvals that did not pass. Failed change rate is failed plus aborted deployments over all changes. The failed-change table lists the executions a reviewer can open.

### Overview

- **text.** ## Approval Gates
- **metric.** Approval Steps
- **metric.** Avg Approval Wait
- **metric.** Rejected / Expired / Aborted Approvals
- **donut.** Approval Outcomes
- **chart.** Approvals by Approver
- **chart.** Weekly Approval Volume & Median Wait
- **text.** ## Change Risk
- **metric.** Changes Deployed
- **metric.** Failed & Aborted Changes
- **metric.** Automated Rollbacks
- **gauge.** Failed Change Rate
- **chart.** Change Volume by Day of Week
- **chart.** Change Volume by Hour of Day (UTC)
- **table.** Failed, Aborted & Rolled-back Changes
- **text.** ## Change Initiation & Runtime Inputs
- **chart.** Changes by Trigger Type & User
- **chart.** Most-Used Runtime Inputs

## Data notes

- Default window is the last 3 months.
- In this account every recorded approval was acted on by one approver, so the approver chart is concentrated.
- Project, Service, Environment, and Environment Type filters apply to the deployment widgets. Approval widgets follow Project.

## Example file

Import [`dashboards.json`](dashboards.json) from Dashboards. It is a Dashboards 3.0 document at schema `1.15.0`

[Back to the examples](../README.md)
