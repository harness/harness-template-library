# Harness Dashboards 3.0 examples

Example dashboards for Dashboards 3.0. Each folder has a `dashboards.json` you can import from the product, and a `README.md` that explains who the dashboard is for, what it shows, and how to read the numbers.

The JSON is the dashboard document: title, date range, filters, layout, and queries. Schema version is `1.15.0`. The file has no dashboard id and no widget ids. The product assigns those on import.

[`try-import.json`](try-import.json) is the smallest example: one metric, CI builds over the last 7 days. Import that first. If it opens, import any `dashboards.json` the same way.

Every dashboard has a date picker, and every widget follows it. Filters are multi-select. With nothing selected, a widget shows all values. Each filter applies to the widgets that have that field.

Two names stay in the JSON because they are part of the dashboard, not account identifiers:

- A filter `id` such as `project_filter`. A filter needs an id.
- A data source `id` such as `ci:pipeline_execution_summary_ci`. That is the Harness view the widget queries.

The queries contain no copied rows. In another account, the same dashboard shows that account's data. Widen the date range if a widget is empty.

## How to choose

| If you need | Example |
|---|---|
| A quarterly story of adoption, velocity, delivery, security, and estimated savings | [Business Value Realization](harness-business-value-realization/README.md) |
| One funnel from build, to registry, to scan, to policy, to deploy | [Artifact Lifecycle 360](artifact-lifecycle-360/README.md) |
| CI health for a leadership meeting | [CI Executive Build Health](ci-executive-build-health/README.md) |
| Which builds are slow, and who is waiting on them | [CI Developer Productivity](ci-developer-productivity/README.md) |
| Why CI is red, and how fast it recovers | [CI Reliability](ci-reliability-and-failure-analysis/README.md) |
| The whole CI system, including scans and policy on the same build | [CI Deep Dive](ci-deep-dive-build-intelligence-360/README.md) |
| DORA metrics for delivery | [CD Executive](cd-executive-delivery-and-dora/README.md) |
| What is deployed where | [CD Service and Environment Operations](cd-service-and-environment-operations/README.md) |
| Approvals, change windows, and failed changes | [CD Governance](cd-governance-approvals-and-change-risk/README.md) |
| The whole delivery system, including policy gates and approvals | [CD Deep Dive](cd-deep-dive-delivery-intelligence-360/README.md) |
| Security risk for a leadership meeting | [STO Executive](sto-executive-security-posture/README.md) |
| A queue of vulnerabilities to triage | [STO AppSec Triage](sto-appsec-vulnerability-triage/README.md) |
| Scan coverage, stale targets, and exemptions | [STO DevSecOps](sto-devsecops-scan-coverage-and-exemptions/README.md) |
| The whole security-testing system, joined to builds and deployments | [STO Deep Dive](sto-deep-dive-security-intelligence-360/README.md) |
| Workspaces, resources, drift, applies, and policy | [IaCM Deep Dive](iacm-deep-dive-infrastructure-intelligence-360/README.md) |
| Pushes, pulls, firewall posture, and whether a stored image was scanned and deployed | [Artifact Registry Deep Dive](ar-deep-dive-artifact-registry-intelligence-360/README.md) |
| SBOMs, component risk, signatures, provenance, and compliance | [SCS Deep Dive](scs-deep-dive-software-supply-chain-intelligence-360/README.md) |

## The examples

### Persona

| Dashboard | Who it is for | Range | JSON |
|---|---|---|---|
| [CI Executive Build Health](ci-executive-build-health/README.md) | Engineering leadership | 3 months | [json](ci-executive-build-health/dashboards.json) |
| [CI Developer Productivity & Build Performance](ci-developer-productivity/README.md) | Engineering manager | 1 month | [json](ci-developer-productivity/dashboards.json) |
| [CI Reliability & Failure Analysis](ci-reliability-and-failure-analysis/README.md) | Platform engineering | 1 month | [json](ci-reliability-and-failure-analysis/dashboards.json) |
| [CD Executive Delivery & DORA Overview](cd-executive-delivery-and-dora/README.md) | Engineering leadership | 3 months | [json](cd-executive-delivery-and-dora/dashboards.json) |
| [CD Service & Environment Operations](cd-service-and-environment-operations/README.md) | Release management | 1 month | [json](cd-service-and-environment-operations/dashboards.json) |
| [CD Governance, Approvals & Change Risk](cd-governance-approvals-and-change-risk/README.md) | Change management | 3 months | [json](cd-governance-approvals-and-change-risk/dashboards.json) |
| [STO Executive Security Posture](sto-executive-security-posture/README.md) | Security leadership | 3 months | [json](sto-executive-security-posture/dashboards.json) |
| [STO AppSec Vulnerability Triage](sto-appsec-vulnerability-triage/README.md) | Application security | 1 month | [json](sto-appsec-vulnerability-triage/dashboards.json) |
| [STO DevSecOps Scan Coverage & Exemptions](sto-devsecops-scan-coverage-and-exemptions/README.md) | DevSecOps | 3 months | [json](sto-devsecops-scan-coverage-and-exemptions/dashboards.json) |

### Cross-module

| Dashboard | Who it is for | Range | JSON |
|---|---|---|---|
| [Harness Business Value Realization (BVR)](harness-business-value-realization/README.md) | Executive and QBR | 6 months | [json](harness-business-value-realization/dashboards.json) |
| [Artifact Lifecycle 360](artifact-lifecycle-360/README.md) | Executive and supply chain | 6 months | [json](artifact-lifecycle-360/dashboards.json) |

### Deep dive

| Dashboard | Who it is for | Range | JSON |
|---|---|---|---|
| [CI Deep Dive: Build Intelligence 360](ci-deep-dive-build-intelligence-360/README.md) | All CI personas | 6 months | [json](ci-deep-dive-build-intelligence-360/dashboards.json) |
| [CD Deep Dive: Delivery Intelligence 360](cd-deep-dive-delivery-intelligence-360/README.md) | All CD personas | 6 months | [json](cd-deep-dive-delivery-intelligence-360/dashboards.json) |
| [STO Deep Dive: Security Intelligence 360](sto-deep-dive-security-intelligence-360/README.md) | All security personas | 6 months | [json](sto-deep-dive-security-intelligence-360/dashboards.json) |
| [IaCM Deep Dive: Infrastructure Intelligence 360](iacm-deep-dive-infrastructure-intelligence-360/README.md) | All infrastructure personas | 6 months | [json](iacm-deep-dive-infrastructure-intelligence-360/dashboards.json) |
| [AR Deep Dive: Artifact Registry Intelligence 360](ar-deep-dive-artifact-registry-intelligence-360/README.md) | All registry personas | 12 months | [json](ar-deep-dive-artifact-registry-intelligence-360/dashboards.json) |
| [SCS Deep Dive: Software Supply Chain Intelligence 360](scs-deep-dive-software-supply-chain-intelligence-360/README.md) | All supply-chain personas | 2 years | [json](scs-deep-dive-software-supply-chain-intelligence-360/dashboards.json) |

The deep dives are arranged in tabs. Each child README lists those tabs in order, then the widgets inside them.
