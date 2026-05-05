# Harness OPA: deny pipelines where any Run step's spec.image does not start with "imagerepo/".
# example-pipeline-payload.json: OPA `input` is the full on-save payload; pipeline is at input.pipeline.
# Run steps appear as JSON objects with "type": "Run" (see path under ... stepGroup ... step).
package pipeline

valid_imagerepo_image(img) {
	is_string(img)
	startswith(img, "imagerepo/")
}

deny[msg] {
	walk(input.pipeline, [_, value])
	value.type == "Run"
	image := object.get(value, ["spec", "image"], "")
	not valid_imagerepo_image(image)
	name := object.get(value, "name", object.get(value, "identifier", "Run"))
	msg := sprintf("Run step %q: spec.image must start with \"imagerepo/\" (found %v)", [name, image])
}
