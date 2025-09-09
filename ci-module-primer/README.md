# CI Golden Standards Templates

This module provides a comprehensive collection of Harness CI templates designed to implement golden standards for Continuous Integration workflows. The module follows a two-tier architecture:

1. **Main Module**: Creates reusable templates (step groups, stages, and pipelines)
2. **Register-Pipeline Module**: Creates individual pipelines using the templates

## Harness Module Support

- **Continuous Integration**: Build and Publish Container Images
- **Security Test Orchestration**: Source Code vulnerability and secret scans along with Container Image scans
- **Supply Chain Security**: Generate SBOM, SLSA, and Artifact Signing

## Architecture Overview

```
ci-golden-standards/
├── main.tf                    # Entry point and documentation
├── data.tf                    # Data lookup details
├── harness_stages_v1.tf       # Stage Template creation
├── harness_step_groups_v1.tf  # StepGroup Template creation
├── timers.tf                  # Manage sleep timers for dependency controls
├── terraform.tf               # Provider management
├── variables.tf               # Main module variables
├── outputs.tf                 # Template outputs for consumption
├── templates/                 # YAML template files
```

## Expected Flow (IDP + IACM Workflow)

The CI Golden Standards follow the Harness ecosystem pattern using **IDP (Internal Developer Portal)**, **IACM (Infrastructure as Code Management)**, and **Pipeline** integration:

### 🏗️ **Architecture Flow**
1. **IDP Catalog** → Triggers workflow via `catalog_template.yaml`
2. **IACM Pipeline** → Executes Terraform in managed workspace
3. **Terraform State** → Stored and managed in IACM
4. **Child Workflows** → Become available after main deployment

### 🚀 **Step 1: Deploy Golden Standard Templates**

1. Navigate to **Harness IDP Catalog**
2. Find "**Deploy Harness CI Golden Standard Templates**" workflow
3. Configure:
   - **Build Infrastructure**: Choose Cloud, Build Farm, or Custom K8s
   - **Security and SBOM Configuration**: Security Scanner and SBOM details
   - **Solutions Factory**: Auto-configured
4. Execute workflow

**What happens:**
- IDP triggers IACM pipeline with your parameters
- IACM executes Terraform in this directory (`ci-module-primer/`)
- Creates all reusable templates (step groups, stages, pipelines)
- Terraform state saved in IACM workspace
- Child workflow becomes available for pipeline creation

### 🔄 **Step 2: Create Individual Pipelines**

After templates are deployed:

1. Navigate to **Harness IDP Catalog**
2. Find "**Create CI Pipeline using Golden Standards**" workflow
3. Configure:
   - **Organization & Project**: Where to create the pipeline
   - **Pipeline Name**: Your application name
   - **Repository Details**: Git connector and repo path
4. Execute workflow

**What happens:**
- IDP triggers IACM pipeline with pipeline parameters
- IACM executes Terraform in `ci-golden-pipeline/`
- Creates individual pipeline using Golden Standard templates
- Pipeline ready with all CI best practices

### 📊 **Multiple Pipeline Creation**

Repeat Step 2 for each application/repository:
- Frontend applications
- Backend services
- Libraries and utilities
- Each gets standardized CI pipeline

### 🔧 **Alternative: Direct Terraform (Advanced)**

For advanced users who prefer direct Terraform:

```hcl
# 1. Deploy templates
module "ci_golden_standards" {
  source = "./ci-golden-standards"

  harness_platform_account = "your_account_id"
  organization_id          = "your_org_id"
  project_id              = "your_project_id"
  kubernetes_connector     = "your_k8s_connector"
}

# 2. Create individual pipelines
module "my_app_pipeline" {
  source = "./ci-golden-standards/modules/register-pipeline"

  organization_id          = "your_org_id"
  project_id              = "your_project_id"
  pipeline_name           = "My Application CI Pipeline"
  repository_connector_ref = "account.my_git_connector"
  repository_name         = "my-application"
  repository_path         = "my-org/my-application"

  depends_on = [module.ci_golden_standards]
}
```

## Main Module Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| harness_platform_url | Harness Platform URL. Defaults to Harness SaaS gateway endpoint. | string | https://app.harness.io/gateway | yes |
| harness_platform_account | Harness Platform Account ID (Required). | string || yes |
| organization_id | Existing Organization ID for use with template. Must exist before execution. | string | null | no |
| project_id | Existing Project ID for use with template. Must exist before execution. | string | null | no |
| tags | Tags to associate with Harness resources. | map(any) | {} | no |
| include_security_testing | Include the Harness Security Test Orchestration steps | bool | true | no |
| include_supply_chain_security | Include the Harness Supply Chain Security steps | bool | true | no |
| default_container_connector | Docker connector identifier to use for STO and SCS Steps. Must exist before execution. | string | account.harnessImage | no |
| kubernetes_connector | Required: Kubernetes connector identifier. Must exist before execution. | string | skipped | no |
| kubernetes_namespace | Kubernetes namespace for pipeline execution. | string | default | no |
| kubernetes_node_selectors | Kubernetes node selectors for workload scheduling. | map(any) | {} | no |
| kubernetes_override_image_connector | Container registry connector to override default connector. | string | skipped | no |
| sto_anchore_grype_fail_on | If the scan finds any vulnerability with the specified severity or higher, the pipeline fails. Supported values: skipped, none, low, medium, high, critical | string | skipped | no |

## Main Module Outputs

| Name | Description |
|------|-------------|
| step_group_templates | Information about created step group templates |
| stage_template | Information about created CI stage template |
| organization_info | Organization information |
| project_info | Project information |

## Template Categories

### 📦 Step Groups Templates
- **Code Smells and Linting**: Static analysis, secret scanning, linting
- **Build and Scan Container Image**: Docker build, vulnerability scan, registry push
- **Supply Chain Security**: SBOM, SLSA, artifact signing

### 🎭 Stage Templates
- **CI Stage Template**: Complete CI workflow orchestrating all step groups

### 🚀 Pipeline Templates
- **Python CI Golden Standard**: Production-ready CI pipeline template

## Configuration Examples

### Basic Setup
```hcl
# 1. Deploy templates
module "templates" {
  source = "./ci-module-primer"

  harness_platform_account = "your_account"
  kubernetes_connector     = "account.k8s_connector"
  kubernetes_namespace     = "harnessci
}

# 2. Create pipeline
module "my_pipeline" {
  source = "./ci-golden-pipeline"

  organization_id          = "your_org_id"
  project_id               = "your_project_id"
  pipeline_name            = "My Application Pipeline"
  repository_connector_ref = "account.my_git_connector"
  repository_path          = "my-org/my-app"
  branches                 = "all"
  webhook_type             = "github"

  tags = {
    environment = "production"
    team        = "platform"
  }
}
```

### Advanced Setup with Multiple Projects
```hcl
# Deploy templates at organization level
module "org_templates" {
  source = "./ci-golden-standards"

  harness_platform_account = "your_account"
  organization_id          = "engineering"
  project_id              = "platform"
  org_id_for_template      = "engineering"  # Templates at org level
  kubernetes_connector     = "shared-k8s"
}

# Create pipelines in different projects
module "frontend_pipeline" {
  source = "./ci-golden-standards/modules/register-pipeline"

  organization_id          = "engineering"
  project_id              = "frontend_team"
  pipeline_name           = "Frontend CI"
  repository_connector_ref = "org.github_connector"
  repository_name         = "web-app"
  repository_path         = "company/web-app"

  depends_on = [module.org_templates]
}

module "backend_pipeline" {
  source = "./ci-golden-standards/modules/register-pipeline"

  organization_id          = "engineering"
  project_id              = "backend_team"
  pipeline_name           = "Backend API CI"
  repository_connector_ref = "org.github_connector"
  repository_name         = "api-service"
  repository_path         = "company/api-service"

  depends_on = [module.org_templates]
}
```

## Benefits

1. **Consistency**: All pipelines use the same golden standard templates
2. **Maintainability**: Update templates once, all pipelines inherit changes
3. **Scalability**: Easy to create new pipelines for additional repositories
4. **Governance**: Centralized control over CI standards and security policies
5. **Reusability**: Templates can be shared across organizations and projects

## Best Practices

1. **Template Versioning**: Use stable template versions for production pipelines
2. **Centralized Templates**: Deploy templates at the organization level for sharing
3. **Environment Separation**: Use different projects for dev/staging/prod pipelines
4. **Dependency Management**: Always specify `depends_on` for pipeline modules
5. **Naming Conventions**: Use consistent naming for pipelines and resources

## Troubleshooting

### Common Issues

1. **Template Not Found**: Ensure main module is deployed before creating pipelines
2. **Permission Errors**: Verify connectors and secrets exist and are accessible
3. **Webhook Issues**: Check repository connector configuration and webhook permissions
4. **Infrastructure Problems**: Validate Kubernetes connector and namespace settings

### Debug Steps

1. Check template deployment: `terraform state list | grep template`
2. Verify connector accessibility in Harness UI
3. Review pipeline execution logs
4. Validate repository webhook configuration

---

## 📚 Additional Resources

- [Step Groups Documentation](templates/step_groups/README.md)
- [Stage Templates Documentation](templates/stages/README.md)
- [Harness CI Documentation](https://docs.harness.io/docs/continuous-integration/)
- [Template Reference Guide](https://docs.harness.io/docs/platform/templates/template/)

*This template collection represents golden standards for CI/CD practices with a scalable, modular architecture.*
