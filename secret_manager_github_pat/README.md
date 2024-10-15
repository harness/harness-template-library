# Github App PAT Dispenser

Generate GitHub PATs on the fly using a GitHub App and Harness Custom Secret Manager

## Summary

Harness CI's [codebase configuration](https://developer.harness.io/docs/continuous-integration/use-ci/codebase-configuration/create-and-configure-a-codebase) uses a code repo connector to clone your code, push status updates to PRs, and create and use repo webhooks. If your code is stored in GitHub repos, you can [use a GitHub App in a Harness GitHub connector](https://developer.harness.io/docs/platform/connectors/code-repositories/git-hub-app-support) for authentication.

However, if you need your CI pipeline to commit and push changes to your repo, the code repo connector doesn't support pushing to the cloned repo.

If you need a CI pipeline to push changes to a repo, use the instructions in this article to configure a **Custom Secrets Manager** setup to generate a dynamic personal access token from the same GitHub App used by your code repo connector. Then, you can run your commit and push commands in a [Run step](https://developer.harness.io/docs/continuous-integration/use-ci/run-step-settings) using the generated credentials.


This Template will created the following resources:

- template: github_app_pat_dispenser

## Providers

This template is designed to be used as a Terraform Module. To leverage this module, an Harness provider configuration must be added to the calling template as defined by the [Harness Provider - Docs](https://registry.terraform.io/providers/harness/harness/latest/docs).

To aid in the setup and use of this module, we have added a file to the root of this repository called `providers.tf.example`. This file can be used as the basis for configuring your own `providers.tf` file for the calling template

_**Note**: If using this as module as a template, be sure to copy the provider sample file from the root of the repository into this directory prior to execution._
- Save a copy of the file as `providers.tf`
- Either configure the variables as defined or use their corresponding variables.

_**Note**: The gitignore file in this repository explicitly ignores any file called `providers.tf` from commits and changes._

### Terraform required providers declaration

```
terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
      version = ">= 0.31"
    }
  }
}

```

## Requirements

The following items must be preconfigured in the target Harness Account

- Harness secret file holding the PEM for the target GitHub app

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| github_api_url | URL for your GitHub instance. | `string` | `"api.github.com"` | no |
| organization_id | Provide an existing organization reference ID.  Must exist before execution | `string` | `null` | no |
| project_id | Provide an existing project reference ID.  Must exist before execution | `string` | `null` | no |
| tags | [Optional] Provide a Map of Tags to associate with the resources | `map(any)` | `{}` | no |
| template_version | version of template to publish | `string` | `"1"` | no |

## Terraform TFVARS

Included in this repository is a `terraform.tfvars.example` file with a sample file that can be used to construct your own `terraform.tfvars` file.

- Save a copy of the file as `terraform.tfvars`
- Update the variable values listed in the new TFVAR file

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_template_id"></a> [template\_id](#output\_template\_id) | the identifer of the template created |

## Contributing

A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors

Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
