# CI Executive Build Health

Leadership view of CI build volume, success rate, build speed and engineering time spent in CI, with period-over-period comparison.

**Persona:** Engineering leadership  
**Modules:** CI  
**Kind:** Persona  
**Tags:** CI, Executive, Build Health, Custom  
**Published:** 2026-11-17 01:36:31 UTC  
[Back to the examples](../README.md)

## Why this dashboard exists

This is the leadership view of continuous integration. It answers whether the build system is healthy enough to trust: how many builds ran, how often they succeeded, how long they took, and how much engineering time they consumed. Period-over-period deltas sit on the headline numbers so a weekly or quarterly review can see direction without opening a pipeline.

## Who should open it

VPs of engineering, heads of platform, and anyone presenting CI health in a staff or QBR meeting.

## Questions it answers

- Are builds succeeding, and is that rate moving up or down?
- How many builds run, and how many engineering hours do they consume?
- Which projects produce the most build volume?

## Time range and filters

The dashboard opens on **Last 3 months**. The date picker is on, and every data widget inherits it. Changing the range recalculates every number on the page.

Filters: **Project**, **Pipeline**, **Repository**.

Each filter is a multi-select. With nothing selected, the widget shows all values. Selecting a value limits the widgets that have that field. A filter is left off a widget that does not have the column, so the widget stays populated.

## What you will see

Success rate is successful builds divided by all builds in the selected window. Engineering hours are the sum of build durations. Median duration is used instead of the average so one stuck build does not dominate the headline. The weekly charts split outcomes so a rising volume of failures is visible even when total volume grows.

### Overview

- **text.** ## Build Health at a Glance
- **gauge.** Build Success Rate
- **metric.** Total Builds
- **metric.** Builds per Day
- **metric.** Median Build Duration
- **metric.** Active Pipelines
- **metric.** Active Repositories
- **metric.** Engineering Hours in CI
- **text.** ## Trends
- **chart.** Weekly Builds by Outcome
- **donut.** Build Status Mix
- **chart.** Weekly Success Rate
- **chart.** Weekly Engineering Hours in CI
- **text.** ## Where Builds Happen
- **chart.** Top Projects by Build Volume
- **table.** Project Build Scorecard

## Data notes

- Default window is the last 3 months. The date picker on the dashboard replaces that window for every widget.
- Project, Pipeline, and Repository filters apply to every widget.

## Example file

Import [`dashboards.json`](dashboards.json) from Dashboards. It is a Dashboards 3.0 document at schema `1.15.0`

[Back to the examples](../README.md)
