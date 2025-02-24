# Makefile
# Standard top-level shared Makefile switchboard to consolidate all common
# rules which will be used when testing or executing this repository.
#

# Auto-include a Makefile.local if it exists in this local directory
ifneq ("$(wildcard Makefile.local)", "")
	include Makefile.local
endif

# Turns this into a do-nothing target
$(eval migrate:;@:)
$(eval dryrun:;@:)
$(eval out:;@:)

ifeq ($(ROOT_DIR),)
	ROOT_DIR=${PWD}
endif
ifeq ($(DOCKER_COMMAND),)
	DOCKER_COMMAND=docker
endif
ifeq ($(TERRAFORM_IMAGE),)
	TERRAFORM_IMAGE=hashicorp/terraform
endif
ifeq ($(TOFU_IMAGE),)
	TOFU_IMAGE=ghcr.io/opentofu/opentofu
endif
ifeq ($(DOCKER_IMAGE),)
	DOCKER_IMAGE=${TOFU_IMAGE}
endif
ifeq ($(TERRAFORM_VERSION),)
	TERRAFORM_VERSION=latest
endif
ifeq ($(TERRAFORM_TFVARS),)
	TERRAFORM_TFVARS=terraform.tfvars
endif
ifeq ($(DOCKER_ENV),)
	DOCKER_ENV:=
endif
ifeq ($(DOCKER_MOUNTS),)
	DOCKER_MOUNTS:=
endif
ifeq ($(PROJECT_DIR),)
	PROJECT_DIR:=${PWD}
endif
ifeq ($(RESOURCE),)
	RESOURCE:=
endif
WORKDIR=/project
DOCKER_RUN=${DOCKER_COMMAND} run --rm -it ${DOCKER_ENV} -v ${PROJECT_DIR}:${WORKDIR} ${DOCKER_MOUNTS} -w ${WORKDIR} $(ENTRYPOINT) ${DOCKER_IMAGE}:${TERRAFORM_VERSION}


.PHONY: help
help:
	@grep -B1 -E "^[a-zA-Z0-9_-]+\:([^\=]|$$)" ${ROOT_DIR}/Makefile \
	 | grep -v -- -- \
	 | sed 'N;s/\n/###/' \
	 | sed -n 's/^#: \(.*\)###\(.*\):.*/\2###\1/p' \
	 | column -t  -s '###'

.PHONY: debug
#: Loads the current directory into the container to allow running commands locally
debug:
	$(eval ENTRYPOINT=--entrypoint sh)
	@(${DOCKER_RUN})

##################################
# TERRAFORM CONTROLS
##################################

.PHONY: init
#: Executes Terraform/Tofu `init`. Pass `migrate` to delete any local `backed.tf` and a `-migrate-state` will be performed.
init:
ifeq (migrate, $(filter migrate,$(MAKECMDGOALS)))
	$(info Migrating the state file)
	@(rm -rf ${PROJECT_DIR}/${TEMPLATE_DIR}/backend.tf)
	$(eval CLI_OVERRIDE=-migrate-state)
endif
	${DOCKER_RUN} init ${CLI_OVERRIDE}

.PHONY: plan
#: Executes a Terraform/Tofu `plan`
plan: fmt
	${DOCKER_RUN} plan -var-file=${TERRAFORM_TFVARS}

.PHONY: plan_output
#: Executes a Terraform/Tofu `plan`
plan_output: fmt
	${DOCKER_RUN} plan -out=terraform.tfplan -var-file=${TERRAFORM_TFVARS}

.PHONY: plan_show
#: Executes a Terraform/Tofu `plan`
plan_show: fmt
ifeq (out, $(filter out,$(MAKECMDGOALS)))
	$(eval ENTRYPOINT=--entrypoint sh)
	${DOCKER_RUN} -c "tofu show terraform.tfplan > terraform.tfplan.out"
else
	${DOCKER_RUN} show terraform.tfplan
endif

.PHONY: apply
#: Automatically runs a Terraform/Tofu `apply`
apply:
	${DOCKER_RUN} apply -auto-approve  -var-file=${TERRAFORM_TFVARS}

.PHONY: destroy
#: Automatically runs a Terraform/Tofu `destroy`
destroy:
	${DOCKER_RUN} destroy -auto-approve  -var-file=${TERRAFORM_TFVARS}

.PHONY: refresh
#: Refreshes the statefile
refresh:
	${DOCKER_RUN} apply -refresh-only -auto-approve  -var-file=${TERRAFORM_TFVARS}

.PHONY: output
#: Display the Terraform/Tofu outputs | To return a single output, pass `RESOURCE=<terraform-output-name>`
output:
	${DOCKER_RUN} output ${RESOURCE}  -var-file=${TERRAFORM_TFVARS}

.PHONY: fmt
#: Formats the Terraform files in the current directory
fmt:
	${DOCKER_RUN} fmt -recursive ${WORKDIR}/${TEMPLATE_DIR}

.PHONY: fmt_all
#: Formats all Terraform files in the entire repository
fmt_all:
	${DOCKER_RUN} fmt -recursive ${WORKDIR}

.PHONY: testing_cleanup
#: Removes the local `.terraform` and `.terraform.lock.hcl` files.
testing_cleanup:
	@(rm -rf ${PROJECT_DIR}/${TEMPLATE_DIR}/.terraform)
	@(rm -rf ${PROJECT_DIR}/${TEMPLATE_DIR}/.terraform.lock.hcl)


##################################
# TERRAFORM Test Suites
##################################
.PHONY: cycle # Idempotency Check
#: Idempotency Check. Runs the commands - init, destroy, apply, and plan
cycle: init destroy apply plan

.PHONY: teardown # Full Suite Cleanup
#: Full Suite Cleanup.  Runs the commands - destroy and testing_cleanup
teardown: init destroy testing_cleanup

.PHONY: deploy # Continuous Deployment
#: Applies the Terraform template. Runs the commands - init, plan, and apply. Note: If the argument `dryrun` is passed then the `apply` step is skipped.
ifeq (dryrun, $(filter dryrun,$(MAKECMDGOALS)))
deploy: init plan_output
else
deploy: init plan apply
endif

.PHONY: all # End-to-end testing
#: End-to-end testing. Runs the commands - init, fmt, plan, apply, destroy, testing_cleanup
all: deploy teardown

.PHONY: version_tests
#: Runs an entire suite of executions for a template based on the chose type. Supported types: terraform or tofu - e.g `type=tofu`
version_tests:
ifeq ($(type),)
	$(eval type="tofu")
endif
ifeq ($(type),terraform)
	$(eval DOCKER_IMAGE=${TERRAFORM_IMAGE})
else ifeq ($(type),tofu)
	$(eval DOCKER_IMAGE=${TOFU_IMAGE})
endif
	@(for version in `cat ${ROOT_DIR}/.${type}_versions`; do \
		echo "Running Full Suite tests for Terraform Version: $$version"; \
		make all TERRAFORM_VERSION=$$version DOCKER_IMAGE=${DOCKER_IMAGE} DOCKER_ENV="${DOCKER_ENV} -e TF_VAR_store_backend=false"; \
		error_code="$$?"; \
		case "$$error_code" in \
		2) \
		 echo "Failed to run tests on version: $$version"; \
		 echo "$$error_code"; \
		 exit 1; \
		esac; \
		sleep 15; \
	done;)

.PHONY: full_suite
#: Cycles a full End-to-end testing for all versions listed. Reads all versions in the .terraform_verions and .tofu_versions files.
full_suite: # Cycles a full End-to-end testing for all versions listed
	$(info Running full tests for all Terraform Versions)
	@(make version_tests type=terraform)
	$(info Running full tests for all Tofu Versions)
	@(make version_tests type=tofu)
##################################

##################################
# SCAFFOLD CONTROLS
##################################
# Generate new scaffold templates
.PHONY: generate
#: Generate a new directory using a template type. The argument `name=<new-template-name>` needs to be passed along with this command
generate:
ifeq ($(name),)
	$(info **** COMMAND PROCESSING ISSUE ****)
	$(info The argument `name=<new-template-name>` needs to be passed along with this command)
	$(info **********************************)
	$(error "Missing Argument")
endif
ifeq ($(type),terraform)
	@(mkdir -p ${name})
	@(cp -r scaffolds/terraform/ ${name})
else
	$(info **** COMMAND PROCESSING ISSUE ****)
	$(info The argument `type=<type>` needs to be passed along with this command)
	$(info )
	$(info Supported types:)
	$(info	- terraform)
	$(info **********************************)
	$(error Invalid Type)
endif

##################################

##################################
# TEMPLATE HELPERS
##################################
# Generate readme tables for variables and outputs automatically
docs:
	terraform-docs markdown table . --anchor=false

##################################