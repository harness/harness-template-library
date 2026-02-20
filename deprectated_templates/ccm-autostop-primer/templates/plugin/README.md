# add autostopping variables

Python script to add variables to an existing Harness service.

If the service is empty, make it a Kubernetes service.

If the service isn't of type Kubernetes or NativeHelm, skip.

## Variables

YAML for variables to add found in `service_variables.yaml`

## Running

The following ENV vars are required:
- PLUGIN_HARNESS_ACCOUNT_ID
- PLUGIN_HARNESS_PLATFORM_API_KEY (needs access to edit services)
- PLUGIN_SERVICE: identifier of target service

Optional vars:
- PLUGIN_HARNESS_ENDPOINT (default: app.harness.io)
- PLUGIN_ORGANIZATION: organization identifier for service
- PLUGIN_PROJECT: project identifier for service

For account level services, define no org or project, for org level, no project. Project level requires org and project be defined.

### Shell

```shell
pip install -r requirements.txt
python main.py
```

### Docker

Local image:
```shell
docker build -t add-autostopping-variables .
docker run -e PLUGIN_HARNESS_ACCOUNT_ID=$HARNESS_ACCOUNT_ID -e PLUGIN_HARNESS_PLATFORM_API_KEY=$HARNESS_PLATFORM_API_KEY -e PLUGIN_SERVICE=whoami -e PLUGIN_ORGANIZATION=default -e PLUGIN_PROJECT=home_lab add-autostopping-variables
```

Public image:
```
docker run -e PLUGIN_HARNESS_ACCOUNT_ID=$HARNESS_ACCOUNT_ID -e PLUGIN_HARNESS_PLATFORM_API_KEY=$HARNESS_PLATFORM_API_KEY -e PLUGIN_SERVICE=whoami -e PLUGIN_ORGANIZATION=default -e PLUGIN_PROJECT=home_lab harnesscommunity/add-autostopping-variables
```

### Plugin

If using the container as a plugin in a Harness pipeline, you can omit the `PLUGIN_` prefix.