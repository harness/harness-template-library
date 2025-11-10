# Harness Template Library - Developer Environment Setup
[<- Return to Harness Template Library - Developer's Guide](../../README.md)

## Summary
Developing for HTL involves having docker, terraform/opentofu, and git installed locally.


## Using the DevContainer in this repository

This repository includes support for DevContainers.  In order to install this into your environment, you will need to have:
- A supported version of docker or [docker-compatible](https://code.visualstudio.com/remote/advancedcontainers/docker-options) engine
- [DevContainers Extension for VS Code](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) or compatible extension for your IDE

Once your development environment is ready, you can simply clone this repository into your IDE.  For VS Code installations, you should be prompted to reopen the workspace in a new container.

To modify the DevContainer, simply edit the `devcontainer.json` at the root of this repository and reload.

## Using Harness Cloud Development Environments (Gitspaces)

Harness supports the use of Cloud Development Environments (Harness Gitspaces) which can launch an interactive environment using the Harness CDE module. For more information, see the details on [Harness Cloud Development Environments](https://developer.harness.io/docs/cloud-development-environments)

## Local Container Based development

## Mise-en-place

A comprehensive `mise.toml` exists in the root of this repository. The command file contains frequently used shortcuts and commands. To use this solution, you will need to have:
- A supported version of docker or [docker-compatible](https://code.visualstudio.com/remote/advancedcontainers/docker-options) engine
- `Mise-en-place` must be installed on your local machine. Learn more at [Mise-en-place](https://mise.jdx.dev/getting-started.html)

Find more information on [Local Testing using Mise-en-Place](../mise-en-place-commands.md) in this repository

To get the current list of available commands, type `mise help` in a Terminal session in this directory.
```
Name             Description
all              End-to-end testing. Runs the commands - deploy, teardown
apply            Automatically runs a Terraform/Tofu `apply`
cycle            Idempotency Check. Runs the commands - init, destroy, apply, and plan
debug            Loads the current directory into the container to allow running commands locally
deploy           Applies the Terraform template. Runs the commands - init, plan, and apply
deploy:dryrun    Dry run deployment. Runs init and plan without apply
destroy          Automatically runs a Terraform/Tofu `destroy`
docs             Generate readme tables for variables and outputs automatically
fmt              Formats the Terraform files in the current directory
fmt:all          Formats all Terraform files in the entire repository
help             Show available tasks
init             Executes Terraform/Tofu `init`. Pass `migrate` to delete any local `backend.tf` and a `-migrate-state` will be performed.
init:migrate     Executes Terraform/Tofu `init` with state migration
output           Display the Terraform/Tofu outputs | Set RESOURCE env var for a single output
plan             Executes a Terraform/Tofu `plan`
plan:init        Idempotency Check. Runs the commands - init, destroy, apply, and plan
plan:output      Executes a Terraform/Tofu `plan` and saves to file
plan:show        Shows a saved Terraform/Tofu plan
plan:show:file   Shows a saved Terraform/Tofu plan and outputs to file
provider         Add a local provider file in this template directory
refresh          Refreshes the statefile
teardown         Full Suite Cleanup. Runs the commands - destroy and testing_cleanup
template         Generate a new directory using a template type. Must provide the name of the template to create
testing:cleanup  Removes the local `.terraform`,`.terraform.lock.hcl`, tfstate, and provider files
```

## Makefile management (Deprecated - 2025-11-07)

A robust `Makefile` configuration is included within this repository. The command file contains frequently used shortcuts and commands. To use this solution, you will need to have:
- A supported version of docker or [docker-compatible](https://code.visualstudio.com/remote/advancedcontainers/docker-options) engine
- `Make` installed for your OS [Windows](https://gnuwin32.sourceforge.net/packages/make.htm) or Mac with Xcode Command line tools Installed [or with Homebrew Gnu Make](https://formulae.brew.sh/formula/make)

Find more information on [Local Testing using make](../makefile-commands.md) in this repository

To get the current list of available commands, type `make help` in a Terminal session in this directory.
```
debug            Loads the current directory into the container to allow running commands locally
init             Executes Terraform/Tofu `init`. Pass `migrate` to delete any local `backed.tf` and a `-migrate-state` will be performed.
plan             Executes a Terraform/Tofu `plan`
plan_output      Executes a Terraform/Tofu `plan`
plan_show        Executes a Terraform/Tofu `plan`
apply            Automatically runs a Terraform/Tofu `apply`
destroy          Automatically runs a Terraform/Tofu `destroy`
refresh          Refreshes the statefile
output           Display the Terraform/Tofu outputs | To return a single output, pass `RESOURCE=<terraform-output-name>`
fmt              Formats the Terraform files in the current directory
fmt_all          Formats all Terraform files in the entire repository
testing_cleanup  Removes the local `.terraform` and `.terraform.lock.hcl` files.
cycle            Idempotency Check. Runs the commands - init, destroy, apply, and plan
teardown         Full Suite Cleanup.  Runs the commands - destroy and testing_cleanup
all              End-to-end testing. Runs the commands - init, fmt, plan, apply, destroy, testing_cleanup
version_tests    Runs an entire suite of executions for a template based on the chose type. Supported types: terraform or tofu - e.g `type=tofu`
full_suite       Cycles a full End-to-end testing for all versions listed. Reads all versions in the .terraform_verions and .tofu_versions files.
generate         Generate a new directory using a template type. The argument `name=<new-template-name>` needs to be passed along with this command
```
