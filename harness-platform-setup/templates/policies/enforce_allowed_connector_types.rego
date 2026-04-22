########################
# Governance Policy for limiting Allowed Harness Connector Types
#
# Policy: Enforce Allowed Connector Types
# 
# This policy will block the creation of specific types of connectors.
# There is an exception policy to allow specific users or groups to bypass this rule.
########################
package pipeline

import future.keywords.if
import future.keywords.in

#### BEGIN - Policy Controls ####
#
# Inputs:
#   approved_users     = List of users allowed to bypass this rule
#   approved_groups    = List of user groups allowed to bypass this rule
#   allowed_connector_types = List of connector types that are allowed to be created. Any connector type not in this list will be blocked.

# Exception Handlers
approved_users := []

approved_groups := []

allowed_connector_types := ["K8sCluster"]


#### END   - Policy Controls ####

#### BEGIN - Connector Type Validation ####
# Deny connector creation policy
deny[msg] {
	not verify_exception_handlers

	not array_contains(allowed_connector_types, input.entity.type)

	msg := sprintf("Failed: This connector '%s' failed due to some condition.", [input.entity.name])
}

# Rule Execption checks
verify_exception_handlers if {
	tmp_output := array.concat(
		[return_count_if_elem_in_list(input.metadata.user.email, approved_users)],
		[return_count_if_elem_in_list(input.metadata.userGroups, approved_groups)]
	)
	count([elem | some elem in tmp_output; elem > 0]) > 0
}

#### END   - Connector Type Validation ####

#### BEGIN - Helper Evaluation Methods ####

return_notated_obj(eval_item) := eval_item.identifier if {
	eval_item.projectIdentifier != ""
} else := concat(".", ["org", eval_item.identifier]) if {
	eval_item.orgIdentifier != ""
} else := concat(".", ["account", eval_item.identifier]) if {
	eval_item.identifier != ""
} else := eval_item

return_count_if_elem_in_list(items, eval_arr) := output if {
	is_array(items)
	output := count([item | some item in items; array_contains(eval_arr, return_notated_obj(item))])
} else := output if {
	is_object(items)
    output := to_number(has_all_keys_and_values(items, eval_arr))
} else := count([item | some item in [items]; array_contains(eval_arr, return_notated_obj(item))])

#### END   - Helper Evaluation Methods ####

#### BEGIN - Policy Helper Functions ####

array_contains(arr, elem) if {
	arr[_] = elem
}

has_key(x, k) if {
	_ = x[k]
}

has_all_keys_and_values(truth, check) := true if {
	count([ key | some key,elem in truth; has_key(check, key); elem == check[key]]) == count(object.keys(check))
} else := false

#### END   - Policy Helper Functions ####