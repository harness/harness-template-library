# Harness OPA: deny containerized step groups and CI stages that do not use the required namespace
package pipeline

required_namespace := "<+org.name>"

# Deny Containerized step groups that does not used the required namespace == required_namespace
# (Note that when a step group is containerized, the namespace field is not present at all if an user does not fill in the field.  In this case, the "default" namespace is used.).
deny[msg] {
	[path, sg] := walk(input.pipeline)
	path[count(path) - 1] == "stepGroup"
	sg.stepGroupInfra
	object.get(sg.stepGroupInfra.spec, "namespace", "") != required_namespace
	msg := sprintf("StepGroup %s does not use the requried namespace %s.", [sg.name, required_namespace])
}

# Deny CI stages that does not used the required namespace == required_namespace
deny[msg] {
	# Find all stages ...
	stage = input.pipeline.stages[_].stage

	# ... that are CI
	stage.type == "CI"

  # ... and Kubernetes based
	stage.spec.infrastructure.type == "KubernetesDirect"

	# ... and does not use the required namespace
  stage.spec.infrastructure.spec.namespace != required_namespace

	# Show a human-friendly error message
	msg := sprintf("Stage %s does not use the requried namespace %s.", [stage.name, required_namespace])
}
