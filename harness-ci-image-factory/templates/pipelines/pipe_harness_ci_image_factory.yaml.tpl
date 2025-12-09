pipeline:
  identifier: ${PIPELINE_IDENTIFIER}
  name: ${PIPELINE_NAME}
  orgIdentifier: ${ORGANIZATION_ID}
  projectIdentifier: ${PROJECT_ID}
  description: "${DESCRIPTION}"
  tags:
    ${indent(4, TAGS)}
  stages:
    - stage:
        name: Discover Harness images
        identifier: Discover_Harness_images
        description: ""
        type: CI
        spec:
          cloneCodebase: false
          caching:
            enabled: false
${STAGE_INFRASTRUCTURE}
          execution:
            steps:
              - step:
                  type: Run
                  name: Prepare Image Payload
                  identifier: Prepare_Image_Payload
                  spec:
                    connectorRef: ${STEP_CONNECTOR_REF}
                    image: ${HSF_SCRIPT_MGR_IMAGE}
                    shell: Python
                    command: |-
                      #!/bin/python
                      from os import environ, scandir, path
                      from configparser import ConfigParser
                      from harness_open_api.api_client import ApiClient
                      def call_api(resource_path, method, payload=None):
                          (response_body, response_status, response_headers) = client.call_api(resource_path, method, body=payload, response_type=object)
                          if not response_status in [200, 201]:
                              raise Exception(f"Failed: {response_status} - {response_body}")
                          return response_body

                      # Environment Variable Handlers
                      harness_idp_fallback_host="https://idp.harness.io"
                      harness_host=environ.get('PLUGIN_HARNESS_URI')
                      harness_acct=environ.get('PLUGIN_HARNESS_ACCT')
                      harness_key=environ.get('PLUGIN_HARNESS_PLATFORM_API_KEY')
                      working_dir=environ.get('PLUGIN_WORKING_DIR')
                      ignore_list=environ.get('PLUGIN_IGNORE_LIST', "").split(",")


                      # Setup API Client
                      client=ApiClient()
                      client.configuration.host = harness_host
                      client.set_default_header("Harness-Account", harness_acct)
                      client.set_default_header("x-api-key", harness_key)

                      query_string=f"?accountIdentifier={harness_acct}&infra=K8"
                      base_uri=f"/gateway/<+pipeline.variables.MODULE>/execution-config"
                      uri_default_config = f"{base_uri}/get-default-config{query_string}"
                      uri_customer_config = f"{base_uri}/get-customer-config{query_string}&overridesOnly=true"

                      all_default_images = call_api(uri_default_config, "GET")
                      all_customer_images = call_api(uri_customer_config, "GET")

                      images_to_migrate={}
                      for tag,image in all_default_images['data'].items():
                          if tag not in all_customer_images['data']:
                              if tag in ignore_list:
                                  continue
                              images_to_migrate[tag] = image
                      output=",".join(["=".join([k,v]) for k,v in images_to_migrate.items()])
                      environ['ALL_IMAGES'] = output
                    envVariables:
                      PLUGIN_HARNESS_URI: <+pipeline.variables.HARNESS_URI>
                      PLUGIN_HARNESS_ACCT: <+pipeline.variables.HARNESS_ACCT>
                      PLUGIN_HARNESS_PLATFORM_API_KEY: <+pipeline.variables.HARNESS_API_KEY>
                      PLUGIN_IGNORE_LIST: iacmTerraform,iacmOpenTofu,iacmCheckov,iacmTFCompliance,iacmTFLint,iacmTFSec,iacmModuleTest,iacmTerragrunt,iacmAnsible
                    outputVariables:
                      - name: ALL_IMAGES
    - stage:
        name: Register Harness images
        identifier: Register_Harness_images
        description: ""
        type: CI
        spec:
          cloneCodebase: false
          caching:
            enabled: false
          infrastructure:
            useFromStage: Discover_Harness_images
          execution:
            steps:
              - stepGroup:
                  name: Image Manager
                  identifier: Image_Manager
                  steps:
                    - step:
                        type: Plugin
                        name: migrate_image
                        identifier: migrate_image
                        spec:
                          connectorRef: ${STEP_CONNECTOR_REF}
                          image: ${HARNESS_IMAGE_PLUGIN}
                          settings:
                            source: <+stepGroup.variables.REPOSITORY><+stepGroup.variables.FULL_IMAGE_NAME>:<+stepGroup.variables.IMAGE_TAG>
                            source_is_public: true
                            destination: <+stepGroup.variables.IMAGE_NAME>:<+stepGroup.variables.IMAGE_TAG>
                            username: <+pipeline.variables.CONTAINER_REGISTRY_USERNAME>
                            password: <+pipeline.variables.CONTAINER_REGISTRY_PASSWORD>
                            overwrite: true
                    - step:
                        type: Run
                        name: Update Harness Configuration
                        identifier: Update_Harness_Configuration
                        spec:
                          connectorRef: ${STEP_CONNECTOR_REF}
                          image: ${HSF_SCRIPT_MGR_IMAGE}
                          shell: Python
                          command: |-
                            #!/bin/python
                            import logging
                            from sys import stdout
                            from os import environ, scandir, path
                            from configparser import ConfigParser
                            from harness_open_api.api_client import ApiClient

                            logging.basicConfig(stream=stdout,
                                                level=logging.INFO,
                                                format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
                            logger = logging.getLogger(__name__)
                            if environ.get('PLUGIN_DEBUG_MODE', "false") == "true":
                                logger.setLevel("DEBUG")

                            logger.info("Beginning Update Process")
                            def call_api(resource_path, method, payload=None):
                                (response_body, response_status, response_headers) = client.call_api(resource_path, method, body=payload, response_type=object)
                                if not response_status in [200, 201]:
                                    raise Exception(f"Failed: {response_status} - {response_body}")
                                return response_body

                            # Environment Variable Handlers
                            logger.info("Loading Environment Variables")
                            harness_idp_fallback_host="https://idp.harness.io"
                            harness_host=environ.get('PLUGIN_HARNESS_URI')
                            harness_acct=environ.get('PLUGIN_HARNESS_ACCT')
                            harness_key=environ.get('PLUGIN_HARNESS_PLATFORM_API_KEY')
                            working_dir=environ.get('PLUGIN_WORKING_DIR')
                            ignore_list=environ.get('PLUGIN_IGNORE_LIST', "").split(",")

                            image_field=environ.get('PLUGIN_IMAGE_FIELD')
                            image_path=environ.get('PLUGIN_IMAGE_PATH')

                            if image_field=="" or image_path=="":
                              raise Exception("Both the PLUGIN_IMAGE_FIELD and PLUGIN_IMAGE_PATH must be passed")


                            # Setup API Client
                            logger.info("Setting up API Client")
                            client=ApiClient()
                            client.configuration.host = harness_host
                            client.set_default_header("Harness-Account", harness_acct)
                            client.set_default_header("x-api-key", harness_key)

                            query_string=f"?accountIdentifier={harness_acct}&infra=K8"
                            base_uri=f"/gateway/<+pipeline.variables.MODULE>/execution-config"
                            uri_default_config = f"{base_uri}/get-default-config{query_string}"
                            uri_customer_config = f"{base_uri}/get-customer-config{query_string}&overridesOnly=true"

                            update_uri=f"{base_uri}/update-config{query_string}"
                            images_to_update=[{
                              "field": image_field,
                              "value": image_path
                            }]
                            logger.info(f"Preparing to update image reference: {image_field} -> {image_path}")
                            logger.debug(f"Image Payload: {images_to_update}")
                            output=call_api(update_uri, "POST", images_to_update)
                            logger.debug(f"Update Results: {output}")
                            if 'data' not in output or not output['data']:
                              raise Exception(f"Failed to update this image. {output}")
                            environ['STATUS']=output['status']
                            logger.info("Finished Update Process")

                          envVariables:
                            PLUGIN_HARNESS_URI: <+pipeline.variables.HARNESS_URI>
                            PLUGIN_HARNESS_ACCT: <+pipeline.variables.HARNESS_ACCT>
                            PLUGIN_HARNESS_PLATFORM_API_KEY: <+pipeline.variables.HARNESS_API_KEY>
                            PLUGIN_IMAGE_FIELD: <+stepGroup.variables.IMAGE_TYPE>
                            PLUGIN_IMAGE_PATH: <+stepGroup.variables.IMAGE_NAME>:<+stepGroup.variables.IMAGE_TAG>
                          outputVariables:
                            - name: STATUS
                        when:
                          stageStatus: Success
                          condition: <+stepGroup.variables.SHOULD_UPDATE_HARNESS_MGR> == "true"
                  variables:
                    - name: REPOSITORY
                      type: String
                      value: <+pipeline.variables.HARNESS_IMAGE_REGISTRY>
                      description: ""
                      required: true
                    - name: REGISTRY_NAME
                      type: String
                      value: <+pipeline.variables.IMAGE_REGISTRY>
                      description: ""
                      required: true
                    - name: IMAGE_TYPE
                      type: String
                      value: <+<+repeat.item>.split("=")[0]>
                      description: ""
                      required: true
                    - name: FULL_IMAGE_PATH
                      type: String
                      value: <+<+repeat.item>.split("=")[1]>
                      description: ""
                      required: true
                    - name: FULL_IMAGE_NAME
                      type: String
                      value: <+<+repeat.item>.split("=")[1].split(":")[0]>
                      description: ""
                      required: true
                    - name: IMAGE_NAME
                      type: String
                      value: <+stepGroup.variables.REGISTRY_NAME>/<+<+stepGroup.variables.FULL_IMAGE_NAME>.split("/")[1]>
                      description: ""
                      required: true
                    - name: IMAGE_TAG
                      type: String
                      value: <+<+repeat.item>.split("=")[1].split(":")[1]>
                      description: ""
                      required: true
                    - name: SHOULD_UPDATE_HARNESS_MGR
                      type: String
                      value: <+pipeline.variables.SHOULD_UPDATE_HARNESS_MGR>
                      description: ""
                      required: true
                  strategy:
                    repeat:
                      items: <+<+pipeline.stages.Discover_Harness_images.spec.execution.steps.Prepare_Image_Payload.output.outputVariables.ALL_IMAGES>.split(",")>
                      maxConcurrency: ${MAX_CONCURRENCY}
        when:
          pipelineStatus: Success
          condition: <+pipeline.stages.Discover_Harness_images.spec.execution.steps.Prepare_Image_Payload.output.outputVariables.ALL_IMAGES>!=""
  variables:
    - name: HARNESS_URI
      type: String
      description: ""
      required: true
      value: <+variable.account.solutions_factory_endpoint>
    - name: HARNESS_ACCT
      type: String
      description: ""
      required: true
      value: <+account.identifier>
    - name: HARNESS_API_KEY
      type: Secret
      description: ""
      required: true
      value: org.hsf_platform_api_key
    - name: HARNESS_IMAGE_REGISTRY
      type: String
      description: ""
      required: true
      value: <+input>.default(${HARNESS_REGISTRY_SOURCE})
    - name: IMAGE_REGISTRY
      type: String
      description: ""
      required: true
      value: <+input>.default(${CUSTOMER_REGISTRY_TARGET})
    - name: CONTAINER_REGISTRY_USERNAME
      type: Secret
      description: ""
      required: true
      value: <+input>.default(${CONTAINER_REGISTRY_USERNAME_REF})
    - name: CONTAINER_REGISTRY_PASSWORD
      type: Secret
      description: ""
      required: true
      value: <+input>.default(${CONTAINER_REGISTRY_PASSWORD_REF})
    - name: SHOULD_UPDATE_HARNESS_MGR
      type: String
      description: ""
      required: true
      value: <+input>.default(${SHOULD_UPDATE_HARNESS_MGR}).allowedValues(true,false)
    - name: MODULE
      type: String
      description: ""
      required: false
      value: <+input>.default(ci).selectOneFrom(ci,idp,iacm-manager)