# Harness Template Library - Local Testing using Mise-en-Place
[<- Return to Harness Template Library - Developer's Guide](../../README.md)

## Summary
This document details the available Mise-en-Place commands.  The goal is to simplify the various commands to rapid testing and prototyping.

## Prerequisites

This document assumes that your local development environment has followed the steps outline in the [Developer Environment Setup](../local-developers-lab.md) guide.  Please review those requirements to ensure that you have all the tools necessary to proceed.

## Commands
_Note: a local list of available target commands can be printed by  running the command `mise help`_

### General Tasks
| Command | Description | Notes |
| --- | --- | --- |
| help | Show available tasks | |
| docs | Generate readme tables for variables and outputs automatically | |
| debug | Loads the current directory into the container to allow running commands locally | |

### TERRAFORM CONTROLS
| Command | Description | Notes |
| --- | --- | --- |
| apply | Automatically runs a Terraform/Tofu `apply` | |
| destroy | Automatically runs a Terraform/Tofu `destroy` | |
| fmt |  Formats the Terraform files in the current directory | _Note: This is run automatically when a `plan` task is run_|
| init | Executes Terraform/Tofu `init`| |
| init:migrate | Executes Terraform/Tofu `init` with state migration | This command can be used to switch a statefile from a remote to local. _Note: This will deleted the local `backend.tf` in the directory_|
| plan | Executes a Terraform/Tofu `plan` | |
| plan:store | Executes a Terraform/Tofu `plan` and saves to file | Generates the file `terraform.tfplan` based on the `plan` data |
| plan:show | Shows a saved Terraform/Tofu plan as Terraform/Tofu display | Reads the file details `terraform.tfplan` |
| plan:output | Shows a saved Terraform/Tofu plan and outputs to file | Converts the file `terraform.tfplan` (binary) to `terraform.tfplan.out` (plain text)|
| refresh | Refreshes the statefile | |
| output |  Display the Terraform/Tofu outputs | Supports returning a single output by providing that resource name as an argument|

### TERRAFORM Test Suites
| Command | Description | Notes |
| --- | --- | --- |
| all |  End-to-end testing. Runs the commands - deploy, teardown | Performs a full deployment and teardown |
| fmt:all | Formats all Terraform files in the entire repository | |
| cycle | Idempotency Check. Runs the commands - init, destroy, apply, and plan | Allows for Idempotency checks for templates |
| plan:init | Executes a Terraform/Tofu `plan` after an `init` | |
| deploy |  Applies the Terraform template. Runs the commands - init, plan, and apply | |
| deploy:dryrun | Dry run deployment. Runs init and plan without apply | |
| teardown | Full Suite Cleanup. Runs the commands - destroy and testing_cleanup | |
| testing:cleanup | Removes the local `.terraform`,`.terraform.lock.hcl`, tfstate, and provider files | Alias = cleanup |

### SCAFFOLD CONTROLS
| Command | Description | Notes |
| --- | --- | --- |
| provider | Add a local provider file in this template directory | |
| template | Generate a new directory using a template type. Must provide the name of the template to create | |

## Contributing

A complete [Contributors Guide](../../../CONTRIBUTING.md) can be found in this repository

## Authors

This repository is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../../../LICENSE) for full details.
