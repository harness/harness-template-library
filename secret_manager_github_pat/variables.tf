variable "tags" {
  type        = map(any)
  description = "[Optional] Provide a Map of Tags to associate with the resources"
  default     = {}
}

## Harness Hiearchy Setup Details
variable "organization_id" {
  type        = string
  description = "Provide an existing organization reference ID.  Must exist before execution"
  default     = null
}

variable "project_id" {
  type        = string
  description = "Provide an existing project reference ID.  Must exist before execution"
  default     = null

}

variable "github_api_url" {
  type        = string
  description = "URL for your GitHub instance."
  default     = "api.github.com"
}

variable "template_version" {
  type        = string
  description = "version of template to publish"
  default     = "v1"
}
