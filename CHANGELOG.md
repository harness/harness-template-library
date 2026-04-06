# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v2.6.1] - 2026-04-06

- UPDATE: CiModulePrimer to correctly execute the `Register_Custom_IDP_Templates` pipeline after provisioning.
- UPDATE: StoSastPrimer to correctly execute the `Register_Custom_IDP_Templates` pipeline after provisioning.

## [v2.6.0] - 2026-02-03

_HSF Hub Support and Enhancements_

- ADD: HSF Hub Pipeline configurations for template 'central-build-farm-setup'
- ADD: HSF Hub Pipeline configurations for template 'ci-golden-pipeline'
- ADD: HSF Hub Pipeline configurations for template 'ci-module-primer'
- ADD: HSF Hub Pipeline configurations for template 'ci-sto-hcr-standard'
- ADD: HSF Hub Pipeline configurations for template 'delegate-image-factory'
- ADD: HSF Hub Pipeline configurations for template 'harness-ci-image-factory'
- ADD: HSF Hub Pipeline configurations for template 'harness-organization'
- ADD: HSF Hub Pipeline configurations for template 'harness-platform-setup'
- ADD: HSF Hub Pipeline configurations for template 'harness-project'
- ADD: HSF Hub Pipeline configurations for template 'scaffolds/terraform'
- ADD: HSF Hub Pipeline configurations for template 'secret-manager-cyberark-conjur'
- ADD: HSF Hub Pipeline configurations for template 'secret_manager_github_pat'
- ADD: HSF Hub Pipeline configurations for template 'sto-sast-primer/additional'
- ADD: HSF Hub Pipeline configurations for template 'sto-sast-primer'
- DEPRECATED: Harness Template Library template deprecated for 'ansible-step-group-template'
- DEPRECATED: Harness Template Library template deprecated for 'ccm-auto-k8s-connectors'
- DEPRECATED: Harness Template Library template deprecated for 'ccm-autostop-primer'
- DEPRECATED: Harness Template Library template deprecated for 'ccm-autostop-primer/templates/plugin'
- DEPRECATED: Harness Template Library template deprecated for 'ccm-cluster-orchestrator-deployment'
- DEPRECATED: Harness Template Library template deprecated for 'ccm-k8s-connectors'
- DEPRECATED: Harness Template Library template deprecated for 'create_and_push_new_catalog_yaml'
- DEPRECATED: Harness Template Library template deprecated for 'rbac-manager'
- FIX: IDP Workflow for 'ci-golden-pipeline' to force a project selection to prevent auto-population which causes a null condition
- FIX: IDP Workflow for 'ci-sto-hcr-standard' to force a project selection to prevent auto-population which causes a null condition
- FIX: IDP Workflow for 'sto-sast-primer/.harness/additional/catalog_template_register_repo.yaml' to force a project selection to prevent auto-population which causes a null condition
- UPDATE: IDP Worklow example in 'scaffolds' to correctly set the repo_source as 'custom' by default and remove dependency on the variables
- UPDATE: idp_registration_mgr.yaml file to remove deprecated templates
- UPDATE: 'harness-project' boilerplate file for groups to resolve typo

## [v2.5.8] - 2025-12-17

- UPDATE: HarnessPlatformSetup::README details (#9)

## [v2.5.7] - 2025-12-12

_Enhanced support for Harness Platform setup with account resources including enhancements for Orgs and Projects (#8)_

- UPDATE: HarnessProject to support enhanced management of resources including Policies and PolicySets
- UPDATE: HarnessOrganization to support enhanced management of resources including Policies and PolicySets
- ADD:       HarnessPlatformSetup template

## [v2.5.6] - 2025-12-09

- [Feature] Turn the CI image factory into a general factory for all container based modules (#7)

## [v2.5.5] - 2025-11-13

- UPDATE: IDP Registration Manager to correct the license check for CCM workflows from CCM -> CE (#6)

## [v2.5.4] - 2025-11-10

_Enhanced support for DevContainers and Mise support (#5)_

- UPDATE: DevContainer dockerfile to include the addition of mise-en-place tool
- UPDATE: DevContainer configuration to set the appropriate variables and install official tofu package
- UPDATE: .gitignore to ignore mise.local.toml files
- UPDATE: Scaffold Documentation for mise tasks
- ADD:    Convert Makefile configuration into mise.toml version

## [v2.5.3] - 2025-11-06

- UPDATE: HarnessOrganization::catalog_template to resolve issue with conditional factory-floor setup (#4)

## [v2.5.2] - 2025-11-04

- UPDATE: HarnessProject workflow to force an organization selection (#3)

## [v2.5.1] - 2025-10-29

_Update all workflows to IDP 2.0 format and update (#1)_

- UPDATE: CI_STO_HCR idp workflow
- UPDATE: HarnessOrganization::Variables defaul description for organizations
- UPDATE: HarnessProject roles and examples
- UPDATE: HarnessOrganization roles and examples
- UPDATE: All workflows to IDP 2.0 format

## [v2.5.0] - 2025-10-15

- UPDATE: All Workflow Templates to support Mini-Factory configurations (#73)

## [v2.4.1] - 2025-10-09

- UPDATE: CodeOwners to include group HSF_Mirror_Reviewers (#72)

## [v2.4.0] - 2025-10-09

_Template - Harness Day-Zero Pipeline and Repository (#71)_

> The execution of this template will create a new pipeline in the chosen project.  This pipeline will leverage the Stage Templates `sta_STO_SAST_SCA_Primer` and `CI_GoldenStandard_Container_Template`.  In addition to the creation of the pipeline, the code will add InputSets and Triggers as well as to create a new Harness Code Repository.

- ADD: Template::ci-sto-hcr-standard:: pipeline, input_sets, triggers, and Harness Code Repository

## [v2.3.3] - 2025-09-17

- FIX: Issue with IDP Workflow output in ci-module-primer (#70)

## [v2.3.2] - 2025-09-16

_Resolve minor issues with templates (#69)_

- UPDATE: CiGoldenPipeline Harness Trigger to correctly handle branch filtering
- UPDATE: HarnessCiImageFactory ignore list

## [v2.3.1] - 2025-09-09

- Resolve issue with Ci-Module-Primer to support setting the docker connector during setup (#68)

## [v2.3.0] - 2025-09-03

_CI Golden Standard Template (#67)_

- ADD: CI Module primer module resources to resolve and improve
- ADD: CI Golden Pipeline template to provide Day-One support for standard Containerized Application builds
- UPDATE: CiModulePrimer and CiGoldenPipeline documentation

## [v2.2.0] - 2025-07-30

_IDP 2.0 Upgrade (#65)_

- FIX: StoSASTPrimer to set optional variables for CPU and MEM
- UPDATE: All workflows to use new control mechanisms
- ADD: Baseline HSF Workspace Resource Template
- ADD: Initial IDP Registration File

## [v2.1.6] - 2025-05-30

_Adding Common Patterns to HTL (#63)_

- renaming resource hierarchy to add md extension
- adding resource hierarchy and updating readme
- adding pipeline infrastructure


## [v2.1.5] - 2025-05-27

_STO Primer version update (#59)_

- UPDATE: StoPrimer::Templates to support setting mem and cpu based on stage variables to correct issue where they were not being calculated when configured as stepGroup variables. This change required a new version of the templates to be created (v2) and set as the default to non-disruptively upgrade
- UPDATE: StoPrimer::IdpWorkflow to add support to configure the default scanner cpu and memory values

## [v2.1.4] - 2025-05-23

_Create Pull Request Template (#62)_

- Update .harness/pull_request_template.md
- Created PR Template

## [v2.1.3] - 2025-05-23

- address findings in devcontainer and ccm primer (#61)

## [v2.1.2] - 2025-05-08

_STO Primer - Register Repo for scans workflow update (#58)_

- UPDATE: StoPrimer::register-scans IDP workflow to conditionally display the webhook type property only when not using HCR

## [v2.1.1] - 2025-05-02

_Support optional Artifact Manager for Central Build Farm setup (#57)_

- UPDATE: CentralBuildFarmSetup terraform code to handle optional Artifact Manager configurations
- UPDATE: CentralBuildFarmSetup IDP catalog file
- UPDATE: README

## [v2.1.0] - 2025-04-28

_Harness CI Image Factory Template (#56)_

- ADD: harness-ci-image-factory terraform template to Mirror and Replicate official Harness images into a private container registry

## [v2.0.0] - 2025-04-15

_HTL Documentation Update (#55)_

- UPDATE: Scaffolds::Docs::local-developers-lab.md summary
- UPDATE: All templates to embed template library connector and repo details
- UPDATE: Scaffolds::Terraform to add comments into main.tf and outputs.tf files
- ADD: Scaffolds::Docs::UpgradingYourInstallation
- ADD: Scaffolds::Docs::AddCustomTemplateLibrary
- UPDATE: Scaffolds::docs titles
- UPDATE: Scaffolds::docs::local-developers-lab
- UPDATE: README to link directly to developer's guides

## [v1.5.0] - 2025-04-04

- Updated the Central Build Farm Workflow. (#53)
- CCM Cluster Orchestrator Service (#54)
- Create harness-project/harness_variables.tf

## [v1.4.0] - 2025-03-17

- Feat: [IMPEMG-303]: Added support for Rancher Build Farm (#32)
- Feat: [IMPEMG-308]: Added support for GitLab Build Farm (#33)
- HTL: Ansible Step Group Template (#46)
- UPDATE: StoSastPrimer::RegisterRepo::Outputs to fix issue with URL (#48)
- Add Harness GitSpace Support (#51)
- Updated Gitlab Resource and IDP Workflow. (#52)

## [v1.3.0] - 2025-02-24

- feat: add inital devcontainer (#20)
- feat: secret-manager-cyberark-conjur (#43)
- Update .harness/CODEOWNERS (#44)
- UPDATE: CentralBuildFarm aws to support cross_account_roles (#45)
- chore: add terraform-docs make command (#47)

## [v1.2.0] - 2025-01-31

- Feat: [IMPENG-301]: Added support for Azure CP Build Farm (#29)
- Feat: [IMPEMG-302]: Added support for GCP Build Farm (#30)
- Feat: [IMPENG-304]: Added support for NEXUS Build Farm (#31)
- add ccm-conn prefix to resource name (#34)
- Feat: [IMPENG-306]: Added support for HELM_OCI Build Farm (#35)
- Feat: [IMPENG-305]: Added support for HELM_HTTP Build Farm (#36)
- Merge branch 'feat/service-add-autostopping' into main (#37)
- chore: - to _ in resource id (#38)
- Automatic CCM Connectors (#39)
- Feat:[IMPENG-300]: Added support for AWS cloud provider in Build Farm UPDATE: changes to variables and modification of IDP workflow Updates to structure. Moving CP Connctors under container_registry as discussed. (#40)
- DelegateImageFactory updates for HarnessCloud and SelfHosted (#42)

## [v1.1.0] - 2024-12-18

- feat: add codeowners (#21)
- Org and Project Group Lifecycle hooks (#22)
- Chore: Scaffold tier_handler sample (#23)
- Harness STO SCA/SAST primer templates (#24)
- UPDATE: CentralBuildFarm to configure api_authentication for SCM configurations (#25)
- UPDATE: STO-SAST-Primer::Additional Catalog Item to include webhook_type (#26)
- Fix: Updated the delegate selector to dynamic for different entities (#28)


## [v1.0.0] - 2024-10-31
_Initial Repository Setup_

- ADD: new Template scaffold and Makefile setup (#1)
- ADD: Harness Solutions Factory Templates (#2)
- feat: github pat secret manager template (#3)
- fix: tfvars quotes, template helpers (#4)
- Refactor Central Build Farm setup (#5)
- Refactor Harness Organization Setup (#6)
- FIX: HarnessOrganization to include harness_platform_url variable in declaration (#7)
- Refactor Harness Project Setup (#8)
- Refactor Harness Delegate Image Factory (#9)
- UPDATE: IDP Workflow configuration for the Harness Tokens (#10)
- UPDATE: Scaffold::IDP::catalog_template.yaml to improve customization support (#11)
- UPDATE: Scaffolds::Terraform remove unnecessary variables and provider.tf file with updates to README (#12)
- Solution: Create and Push New Catalog (#13)
- ADD: RbacManager template (#14)
- UPDATE: RbacManager::Idp workflow branch (#15)
- UPDATE: RbacManager README (#16)
- UPDATE: CreateCatalog child template name (#17)
- UPDATE: DelegateImageFactory IDP workflow details (#18)
- add helpers to readme and tfvars example (#19)
