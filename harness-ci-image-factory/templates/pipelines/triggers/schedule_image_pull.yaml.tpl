trigger:
  name: ${TRIGGER_NAME}
  identifier: ${TRIGGER_IDENTIFIER}
  orgIdentifier: ${ORGANIZATION_ID}
  projectIdentifier: ${PROJECT_ID}
  pipelineIdentifier: ${PIPELINE_IDENTIFIER}
  enabled: ${ENABLED}
  stagesToExecute: []
  tags:
    ${indent(4, TAGS)}
  source:
    type: Scheduled
    spec:
      type: Cron
      spec:
        type: UNIX
        expression: "${SCHEDULE}"
  inputYaml: |
    pipeline:
      identifier: ${PIPELINE_IDENTIFIER}
      variables:
        - name: HARNESS_IMAGE_REGISTRY
          type: String
          value: ${HARNESS_REGISTRY_SOURCE}
        - name: IMAGE_REGISTRY
          type: String
          value: ${CUSTOMER_REGISTRY_TARGET}
        - name: CONTAINER_REGISTRY_USERNAME
          type: Secret
          value: ${CONTAINER_REGISTRY_USERNAME_REF}
        - name: CONTAINER_REGISTRY_PASSWORD
          type: Secret
          value: ${CONTAINER_REGISTRY_PASSWORD_REF}
        - name: SHOULD_UPDATE_HARNESS_MGR
          type: String
          value: "${SHOULD_UPDATE_HARNESS_MGR}"
        - name: MODULE
          type: String
          value: "${MODULE}"
