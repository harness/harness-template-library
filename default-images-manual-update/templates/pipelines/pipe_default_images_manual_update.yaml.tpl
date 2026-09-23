pipeline:
  name: ${PIPELINE_NAME}
  identifier: ${PIPELINE_IDENTIFIER}
  orgIdentifier: ${ORGANIZATION_ID}
  projectIdentifier: ${PROJECT_ID}
  description: ${DESCRIPTION}
  tags:
    ${indent(4, TAGS)}
  stages:
    - stage:
        name: execution
        identifier: execution
        description: ""
        type: Custom
        spec:
          execution:
            steps:
              - parallel:
                  - step:
                      type: Http
                      name: update default
                      identifier: update_default
                      spec:
                        url: https://app.harness.io/gateway/${MODULE}/execution-config/update-config?accountIdentifier=<+account.identifier>&infra=<+pipeline.variables.infra>
                        method: POST
                        headers:
                          - key: Content-Type
                            value: application/json
                          - key: x-api-key
                            value: <+secrets.getValue("${SECRET_ID}")>
                        inputVariables: []
                        outputVariables: []
                        requestBody: |
                          ${SET_IMAGES}
                        assertion: <+httpResponseCode> == 200
                      timeout: 10s
                      when:
                        stageStatus: Success
                        condition: not <+pipeline.variables.reset>
                  - step:
                      type: Http
                      name: reset default
                      identifier: reset_default
                      spec:
                        url: https://app.harness.io/gateway/${MODULE}/execution-config/reset-config?accountIdentifier=<+account.identifier>&infra=<+pipeline.variables.infra>
                        method: POST
                        headers:
                          - key: Content-Type
                            value: application/json
                          - key: x-api-key
                            value: <+secrets.getValue("${SECRET_ID}")>
                        inputVariables: []
                        outputVariables: []
                        requestBody: |
                          ${RESET_IMAGES}
                        assertion: <+httpResponseCode> == 200
                      timeout: 10s
                      when:
                        stageStatus: Success
                        condition: <+pipeline.variables.reset>
        tags: {}
  variables:
    - name: infra
      type: String
      description: "pipeline infrastructure type for changing defaults"
      required: true
      value: <+input>.default(K8).selectOneFrom(K8,VM)
    - name: reset
      type: String
      description: "reset all images to harness defaults"
      required: true
      value: <+input>.default(false).selectOneFrom(true,false)
%{ for image, value in DEFAULT_IMAGES ~}
    - name: ${ image }
      type: String
      description: ""
      required: true
      value: <+input>.default(${ value })
%{ endfor ~}
