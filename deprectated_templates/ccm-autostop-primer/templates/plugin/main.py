from os import getenv
from logging import error, info
from json import dumps

from requests import get, put
from yaml import load, dump, Loader, Dumper

from variables import SERVICE_VARIABLES

HEADERS = {
    "Harness-Account": getenv("PLUGIN_HARNESS_ACCOUNT_ID"),
    "x-api-key": getenv("PLUGIN_HARNESS_PLATFORM_API_KEY"),
}

ALLOWED_SERVICE_TYPES = ["Kubernetes", "NativeHelm"]


def get_harness_service(service: str, org: str = "", project: str = "") -> dict:
    """
    Retrieve the yaml definition of a Harness service
    """

    org_path = f"orgs/{org}/" if org else ""
    project_path = f"projects/{project}/" if project else ""

    resp = get(
        f"https://{getenv('HARNESS_ENDPOINT', 'app.harness.io')}/v1/{org_path}{project_path}services/{service}",
        headers=HEADERS,
    )

    resp.raise_for_status()

    try:
        data = resp.json()
    except Exception as e:
        error(e)
        return None

    info("retrieved service ", service)

    if "service" not in data:
        error("no service found in result")
        return None

    return data["service"]


def put_harness_service(
    service: str, payload: dict, org: str = "", project: str = ""
) -> dict:
    """
    Update a Harness service using yaml
    """

    org_path = f"orgs/{org}/" if org else ""
    project_path = f"projects/{project}/" if project else ""

    resp = put(
        f"https://{getenv('HARNESS_ENDPOINT', 'app.harness.io')}/v1/{org_path}{project_path}services/{service}",
        headers=HEADERS,
        json=payload,
    )

    resp.raise_for_status()

    try:
        data = resp.json()
    except Exception as e:
        error(e)

    info("updated service ", service)

    return data


def main(service: str, org: str = "", project: str = ""):
    # get the existing service from harness
    service_obj = get_harness_service(service, org, project)

    # load the service yaml into a dict
    service_yaml = load(service_obj["yaml"], Loader=Loader)

    # if service is empty, assume k8s and bootstrap
    if "serviceDefinition" not in service_yaml["service"]:
        error("service has no definition")
        service_yaml["service"]["serviceDefinition"] = {
            "type": ALLOWED_SERVICE_TYPES[0],
            "spec": {},
        }

    # make sure service is deployable to k8s
    if (
        service_yaml["service"]["serviceDefinition"]["type"]
        not in ALLOWED_SERVICE_TYPES
    ):
        error(f"service is not in {ALLOWED_SERVICE_TYPES}")
        return

    # if the service has no variables, insert all the new ones
    if "variables" not in service_yaml["service"]["serviceDefinition"]["spec"]:
        service_yaml["service"]["serviceDefinition"]["spec"][
            "variables"
        ] = SERVICE_VARIABLES

    # otherwise, add any variables that are not already defined
    else:
        existing_variables = [
            x["name"]
            for x in service_yaml["service"]["serviceDefinition"]["spec"]["variables"]
        ]

        for variable in SERVICE_VARIABLES:
            if variable["name"] not in existing_variables:
                service_yaml["service"]["serviceDefinition"]["spec"][
                    "variables"
                ].append(variable)

    # set updated yaml
    service_obj["yaml"] = dump(service_yaml, Dumper=Dumper)

    # save the updated service in harness
    result = put_harness_service(service, service_obj, org, project)
    print(dumps(result, indent=2))


if __name__ == "__main__":
    serivce_id = getenv("PLUGIN_SERVICE")

    # account for harness pipeline passing "null" when var is undefined
    org_id = getenv("PLUGIN_ORGANIZATION")
    if org_id == "null":
        org_id = None

    project_id = getenv("PLUGIN_PROJECT")
    if project_id == "null":
        project_id = None

    main(serivce_id, org_id, project_id)
