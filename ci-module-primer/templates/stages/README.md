# CI Golden Standards - Stages

This directory contains Stage templates that implement golden standards for Continuous Integration workflows. Stage templates provide complete CI stage configurations that orchestrate multiple step groups and individual steps into cohesive workflows.

## Available Stage Templates

### 🎭 CI Stage Template (`sta_ci_stage.yaml`)

A comprehensive CI stage template that implements golden standards for Python development workflows, incorporating code quality, security scanning, building, and supply chain security practices.

**Purpose**: Provide a complete, standardized CI stage that follows industry best practices for code quality, security, and artifact management.

**Architecture**:
```
CI Stage Template
├── Install Dependency (Insert Point)
├── Parallel Execution:
│   ├── Code Smells and Linting (Step Group)
│   └── Extra Code Scanning Block (Insert Point)
├── Run Unit Tests (Insert Point)
├── Build and Scan (Step Group)
└── Supply Chain Security (Step Group)
```

**Platform Configuration**:
- **OS**: Linux
- **Architecture**: AMD64
- **Runtime**: Cloud-based execution
- **Codebase**: Cloning enabled
- **Caching**: Disabled by default
- **Build Intelligence**: Disabled by default

**Variables**:

| Variable Name | Required | Description | Default Value |
|---------------|----------|-------------|---------------|
| `PYTHON_IMAGE` | Yes | Python image with tag for build process | `<+input>.default(python:3.10.6)` |
| `DOCKER_REPOSITORY` | Yes | Repository name in format `<hub-user>/<repo-name>` | `<+input>` |
| `DOCKER_CONNECTOR` | Yes | Identifier of the Docker connector | `<+input>` |
| `DOCKER_TAG` | Yes | Tag of the Docker image | `<+input>` |

**Step Groups Included**:

1. **Code Smells and Linting**: Static analysis and security scanning
   - Template Reference: `${CODE_SMELL_TEMPLATE}`
   - No additional variables required

2. **Build and Scan**: Container building and vulnerability scanning
   - Template Reference: `${BUILD_AND_SCAN_TEMPLATE}`
   - Variables: `DOCKER_REPOSITORY`, `DOCKER_TAG`

3. **Supply Chain Security**: SBOM, SLSA, and artifact signing
   - Template Reference: `${SCS_TEMPLATE}`
   - Variables: `DOCKER_REPOSITORY`, `DOCKER_TAG`

**Insert Points**:

The stage template includes several insert points for custom steps:

1. **Install Dependency** (`Install_Dependency`):
   - Purpose: Custom dependency installation steps
   - Position: Before parallel code scanning
   - Use Case: Installing project-specific dependencies, tools, or configurations

2. **Extra Code Scanning Block** (`Extra_Code_Scanning_Block`):
   - Purpose: Additional security or quality scans
   - Position: Parallel with code smells and linting
   - Use Case: Custom SAST tools, license scanning, or compliance checks

3. **Run Unit Tests** (`Test_Block`):
   - Purpose: Custom unit testing implementation
   - Position: After code scanning, before building
   - Use Case: Running pytest, coverage reports, test intelligence integration

**Configuration Options**:
- `canEditInsertSteps: false` - Insert steps cannot be modified in the template
- `contextType: StageTemplate` - Identifies this as a stage-level template

**Tags**:
- `module: CI`
- `extraModule: STO`
- `extraMod: SCS`

---

## Infrastructure Snippets

### Infrastructure Configuration (`snippets/infrastructure.yaml`)

Provides standardized infrastructure specifications for CI pipeline execution with support for both cloud and Kubernetes runtimes.

**Supported Platforms**:
- **Cloud Runtime**: Harness-managed cloud infrastructure
- **Kubernetes**: Self-managed or cloud-managed Kubernetes clusters

**Configuration Features**:
- **Resource Allocation**: Configurable CPU and memory limits
- **Node Selection**: Support for Kubernetes node selectors
- **Networking**: Namespace-based isolation
- **Container Registry**: Configurable image connectors

**Usage in Stage Templates**:
```yaml
infrastructure:
  useFromStage:
    stage: infrastructure_setup
```

---

## Usage Guidelines

### 1. Using the CI Stage Template

```yaml
# Example: Complete CI stage from template
stage:
  name: Python CI Pipeline
  identifier: python_ci
  template:
    templateRef: account.sta_ci_stage
    versionLabel: "1.0"
    templateInputs:
      type: CI
      variables:
        - name: PYTHON_IMAGE
          value: python:3.11-slim
        - name: DOCKER_REPOSITORY
          value: myorg/myapp
        - name: DOCKER_CONNECTOR
          value: account.docker_hub
        - name: DOCKER_TAG
          value: <+pipeline.sequenceId>
```

### 2. Customizing Insert Points

```yaml
# Example: Adding custom steps to insert points
stage:
  template:
    templateRef: account.sta_ci_stage
    versionLabel: "1.0"
    templateInputs:
      type: CI
      spec:
        execution:
          steps:
            - insert:
                identifier: Install_Dependency
                steps:
                  - step:
                      type: Run
                      name: Install Poetry
                      identifier: install_poetry
                      spec:
                        shell: Bash
                        command: |
                          curl -sSL https://install.python-poetry.org | python3 -
                          poetry install
            - insert:
                identifier: Test_Block
                steps:
                  - step:
                      type: Run
                      name: Run Tests
                      identifier: run_tests
                      spec:
                        shell: Bash
                        command: |
                          poetry run pytest --cov=. --cov-report=xml
```

### 3. Infrastructure Configuration

```yaml
# Example: Stage with custom infrastructure
stage:
  template:
    templateRef: account.sta_ci_stage
    versionLabel: "1.0"
  spec:
    infrastructure:
      type: KubernetesHosted
      spec:
        identifier: k8s-ci-infra
        namespace: ci-builds
        nodeSelector:
          node-type: ci-optimized
```

---

## Template Dependencies

### Required Step Group Templates
The CI stage template depends on the following step group templates being available:

1. **Code Smells Template**: `${CODE_SMELL_TEMPLATE}`
2. **Build and Scan Template**: `${BUILD_AND_SCAN_TEMPLATE}`
3. **Supply Chain Security Template**: `${SCS_TEMPLATE}`

### Required Connectors
- **Docker Connector**: Specified in `DOCKER_CONNECTOR` variable
- **SCM Connector**: For codebase access (configured at pipeline level)

### Optional Dependencies
- **Kubernetes Connector**: For Kubernetes-based execution
- **Secret Manager**: For storing Cosign keys (supply chain security)

---

## Configuration Best Practices

### 1. Variable Management
```yaml
# Use pipeline-level variables for consistency
variables:
  - name: DOCKER_REGISTRY
    type: String
    value: myregistry.com
  - name: IMAGE_TAG
    type: String
    value: <+pipeline.sequenceId>
```

### 2. Infrastructure Planning
```yaml
# Consider resource requirements
infrastructure:
  type: KubernetesHosted
  spec:
    resources:
      limits:
        memory: 4Gi
        cpu: 2000m
```

### 3. Parallel Execution
The template is designed for parallel execution of code scanning steps to optimize build times.

### 4. Error Handling
```yaml
# Configure failure strategies
failureStrategies:
  - onFailure:
      errors:
        - AllErrors
      action:
        type: StageRollback
```

---

## Customization Patterns

### 1. Language-Specific Variations
```yaml
# Override Python image for different versions
variables:
  - name: PYTHON_IMAGE
    value: python:3.9-alpine  # Lightweight Alpine variant
```

### 2. Additional Security Scans
```yaml
# Add custom security tools via insert points
steps:
  - insert:
      identifier: Extra_Code_Scanning_Block
      steps:
        - step:
            type: Security
            name: Custom SAST
            identifier: custom_sast
```

### 3. Multi-Environment Support
```yaml
# Environment-specific configurations
when:
  stageStatus: Success
  condition: <+pipeline.variables.environment> == "production"
```

---

## Troubleshooting

### Common Issues

1. **Template Reference Errors**
   - Verify all referenced step group templates exist
   - Check template version labels match deployed versions
   - Ensure proper scope (account/org/project) for template references

2. **Variable Resolution Issues**
   - Validate all required variables are provided
   - Check variable types match expected formats
   - Verify pipeline and stage variable inheritance

3. **Infrastructure Problems**
   - Confirm Kubernetes connector configuration
   - Verify namespace existence and permissions
   - Check resource availability and limits

4. **Insert Point Configuration**
   - Ensure insert point identifiers match template definitions
   - Verify step syntax within insert blocks
   - Check for conflicting step identifiers

### Debug Information

Enable detailed logging:
```yaml
# In pipeline configuration
options:
  skipResourceVersioning: false
  keepResourceVersions: 10
```

---

## Performance Considerations

### 1. Parallel Execution
The template maximizes parallel execution:
- Code scanning runs parallel with custom scans
- Build and security steps run sequentially for dependency reasons

### 2. Resource Optimization
```yaml
# Optimize for build speed
spec:
  infrastructure:
    type: KubernetesHosted
    spec:
      nodeSelector:
        instance-type: compute-optimized
```

### 3. Caching Strategies
```yaml
# Enable intelligent caching
spec:
  caching:
    enabled: true
    paths:
      - /root/.cache/pip
      - node_modules
```

---

## Template Versioning

### Version Management
- Stage templates follow semantic versioning
- Template references should specify explicit versions
- Breaking changes increment major version

### Upgrade Path
1. Test new versions in development environments
2. Update template references gradually
3. Monitor for compatibility issues
4. Document any required configuration changes

---

*This stage template represents the golden standard for CI workflows, incorporating industry best practices for security, quality, and efficiency. Regular updates ensure alignment with evolving DevSecOps practices.*