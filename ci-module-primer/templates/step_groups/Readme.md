# CI Golden Standards - Step Groups

This directory contains reusable Step Group templates that implement golden standards for Continuous Integration workflows. Each step group is a modular collection of related CI steps that can be used independently within CI stages.

## Available Step Groups

### 🔍 Code Smells and Linting (`stg_code_smells_and_linting.yaml`)

Performs static code analysis, secret scanning, and general linting on Python codebase using industry-standard security tools.

**Purpose**: Early detection of code quality issues, security vulnerabilities, and secrets in the codebase.

**Tools Used**:
- **Bandit**: Static code analysis for Python security vulnerabilities
- **Gitleaks**: Secret detection and prevention
- **Semgrep**: Pattern-based code analysis for quality and security issues

**Execution**: All steps run in parallel for optimal performance.

**Variables**:

| Variable Name | Required | Description | Default Value |
|---------------|----------|-------------|---------------|
| None | - | This step group has no input variables | - |

**Configuration**:
- `fail_on_severity: none` - Collects all findings without failing the pipeline
- `mode: orchestration` - Uses Harness STO orchestration mode
- `detection: auto` - Automatic detection of scan targets

**Tags**:
- `module: STO`
- `language: Python`
- `dependency: No`
- `Independent: Yes`

---

### 🐳 Build and Scan Container Image (`stg_build_and_scan_container_image.yaml`)

Streamlines Docker image building, vulnerability scanning, and registry push with comprehensive security checks.

**Purpose**: Build, scan, and securely publish Docker containers with vulnerability assessment.

**Tools Used**:
- **Docker**: Container building and publishing
- **Anchore Grype**: Container vulnerability scanning

**Workflow**:
1. Initialize background Docker daemon
2. Build Docker image and save as local archive
3. Scan local image for vulnerabilities
4. Push scanned image to registry

**Variables**:

| Variable Name | Required | Description | Default Value |
|---------------|----------|-------------|---------------|
| `DOCKER_REPOSITORY` | Yes | Repository name in format `<hub-user>/<repo-name>` | `<+input>` |
| `DOCKER_TAG` | Yes | Tag to assign to the Docker image | `<+input>` |

**Dependencies**:
- Docker connector configured in `<+stage.variables.DOCKER_CONNECTOR>`
- Kubernetes runtime (if `KUBERNETES_CONNECTOR != "skipped"`)

**Tags**:
- `module: CI`
- `extraModule: STO`
- `externalDependency: false`
- `externalVariables: Yes`
- `independent: Yes`

---

### 🔐 Supply Chain Security (`stg_supply_chain_security.yaml`)

Implements comprehensive supply chain security practices including SBOM generation, SLSA provenance, and artifact signing.

**Purpose**: Ensure software supply chain integrity and security through attestation and signing.

**Tools Used**:
- **Syft**: Software Bill of Materials (SBOM) generation
- **Cosign**: Artifact signing and attestation
- **SLSA**: Supply-chain Levels for Software Artifacts provenance

**Workflow**:
1. Generate SBOM in CycloneDX JSON format
2. Create SLSA provenance attestation
3. Sign artifacts using Cosign

**Variables**:

| Variable Name | Required | Description | Default Value |
|---------------|----------|-------------|---------------|
| `DOCKER_REPOSITORY` | Yes | Repository where the image was pushed | `<+input>` |
| `DOCKER_TAG` | Yes | Tag of the built image | `<+input>` |

**Additional Inputs** (provided at runtime):
- `private_key`: Cosign private key (Harness Secret)
- `password`: Cosign private key password (Harness Secret)

**Prerequisites**:
- Generated Cosign private/public key pair
- Cosign keys stored as Harness Secrets
- Docker connector configured

**Tags**:
- `module: SCS`
- `externalDependency: No`
- `independent: Yes`
- `extraSetup: Yes`

---

## Usage Guidelines

### 1. Using Step Groups in CI Stages

```yaml
# Example: Including Code Smells and Linting
stepGroup:
  name: Code Quality Analysis
  identifier: code_quality
  template:
    templateRef: account.stg_code_smells_and_linting
    versionLabel: "1.0"
```

### 2. Providing Required Variables

```yaml
# Example: Build and Scan step group with variables
stepGroup:
  name: Build and Security Scan
  identifier: build_scan
  template:
    templateRef: account.stg_build_and_scan_container_image
    versionLabel: "1.0"
    templateInputs:
      variables:
        - name: DOCKER_REPOSITORY
          value: myorg/myapp
        - name: DOCKER_TAG
          value: <+pipeline.sequenceId>
```

### 3. Supply Chain Security Setup

```yaml
# Example: Supply Chain Security with secrets
stepGroup:
  name: Supply Chain Security
  identifier: scs
  template:
    templateRef: account.stg_supply_chain_security
    versionLabel: "1.0"
    templateInputs:
      variables:
        - name: DOCKER_REPOSITORY
          value: myorg/myapp
        - name: DOCKER_TAG
          value: <+pipeline.sequenceId>
      spec:
        steps:
          - step:
              identifier: ArtifactSigning
              spec:
                signing:
                  spec:
                    private_key: <+secrets.getValue("cosign_private_key")>
                    password: <+secrets.getValue("cosign_password")>
```

---

## Configuration Requirements

### Docker Connector Setup
All step groups require a Docker connector configured at the stage level:

```yaml
variables:
  - name: DOCKER_CONNECTOR
    type: String
    value: account.my_docker_connector
```

### Kubernetes Infrastructure (Optional)
For Kubernetes-based execution, configure:

```yaml
# In your CI stage infrastructure
infrastructure:
  type: KubernetesHosted
  spec:
    identifier: k8s-hosted-infra
```

### Cosign Setup (Supply Chain Security Only)
1. Generate Cosign key pair:
   ```bash
   cosign generate-key-pair
   ```

2. Store keys as Harness Secrets:
   - `cosign_private_key`: Private key content
   - `cosign_password`: Private key password

---

## Execution Conditions

All step groups are configured with:
```yaml
when:
  stageStatus: Success
```

This ensures step groups only execute when the preceding stage completes successfully.

---

## Resource Specifications

### Build and Scan Container Image
- **Grype Scanner**: 2GB memory, 1000m CPU
- **Docker Daemon**: Privileged execution required

### Supply Chain Security
- **SBOM Generation**: 2GI memory, 1 CPU
- **SLSA/Signing**: Standard resource allocation

---

## Best Practices

1. **Version Management**: Always specify `versionLabel` when referencing templates
2. **Variable Naming**: Use consistent, descriptive variable names across step groups
3. **Secret Management**: Store sensitive data (Cosign keys) in Harness Secrets
4. **Connector Organization**: Organize connectors at appropriate scopes (account/org/project)
5. **Resource Planning**: Consider resource requirements when planning pipeline execution

---

## Troubleshooting

### Common Issues

1. **Missing Docker Connector**
   - Verify connector exists and is accessible
   - Check connector permissions and configuration

2. **Cosign Key Issues**
   - Ensure keys are properly generated and stored
   - Verify secret references match actual secret names

3. **Resource Constraints**
   - Adjust memory/CPU limits if needed
   - Consider pipeline execution infrastructure capacity

4. **Permission Errors**
   - Verify RBAC permissions for template access
   - Check connector and secret permissions

### Debug Information

Enable detailed logging by setting:
```yaml
advanced:
  log:
    level: debug
```

---

## Template Identifiers

When deploying these templates, they will be created with identifiers based on your configuration:
- Code Smells and Linting: `${TEMPLATE_IDENTIFIER}_code_smells`
- Build and Scan: `${TEMPLATE_IDENTIFIER}_build_scan`
- Supply Chain Security: `${TEMPLATE_IDENTIFIER}_scs`

---

*These step group templates represent industry best practices for CI security and quality assurance. Regular updates ensure alignment with evolving security standards and tool capabilities.*