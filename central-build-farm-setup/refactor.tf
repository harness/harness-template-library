# 2024-10-02 Refactor to leverage modules and add cloud_connectors
moved {
  from = harness_platform_connector_github.source_code_manager[0]
  to   = module.scm_github[0].harness_platform_connector_github.source_code_manager[0]
}
moved {
  from = harness_platform_connector_bitbucket.source_code_manager[0]
  to   = module.scm_bitbucket[0].harness_platform_connector_bitbucket.source_code_manager[0]
}
moved {
  from = harness_platform_connector_docker.container_registry[0]
  to   = module.cr_docker[0].harness_platform_connector_docker.container_registry[0]
}
moved {
  from = harness_platform_connector_artifactory.container_registry[0]
  to   = module.cr_artifactory[0].harness_platform_connector_artifactory.container_registry[0]
}
