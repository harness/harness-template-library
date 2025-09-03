# Timer Manager for Dependency Controls
resource "time_sleep" "step_groups_v1" {
  depends_on = [
    harness_platform_template.stg_code_smells_and_linting_v1,
    harness_platform_template.stg_build_and_scan_container_image_v1,
    harness_platform_template.stg_supply_chain_security_v1
  ]
  create_duration  = "5s"
  destroy_duration = "15s"
}

resource "time_sleep" "step_groups" {
  depends_on = [
    time_sleep.step_groups_v1
  ]

  destroy_duration = "15s"
}

resource "time_sleep" "stages_v1" {
  depends_on = [
    harness_platform_template.sta_ci_stage_v1
  ]

  create_duration  = "5s"
  destroy_duration = "15s"
}


resource "time_sleep" "stages" {
  depends_on = [
    time_sleep.stages_v1
  ]

  destroy_duration = "15s"
}
