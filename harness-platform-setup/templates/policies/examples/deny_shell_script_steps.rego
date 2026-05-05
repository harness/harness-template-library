# Harness OPA: deny any pipeline that contains a shell script step
package pipeline

deny[msg] {
	walk(input.pipeline, [_, value])
	value.type == "ShellScript"
	msg := sprintf("Shell Script steps are not allowed",[])
}
