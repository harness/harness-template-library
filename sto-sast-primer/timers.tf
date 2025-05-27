
resource "time_sleep" "steps" {
  depends_on = [
    harness_platform_template.stp_STO_ConfigManager_Repo_v1
  ]

  create_duration  = "15s"
  destroy_duration = "15s"
}

resource "time_sleep" "step_groups_v1" {
  depends_on = [
    harness_platform_template.stg_Gitleaks_Scans_v1,
    harness_platform_template.stg_OSV_SCA_v1,
    harness_platform_template.stg_OWASP_Dependency_Check_v1,
    harness_platform_template.stg_Semgrep_Sast_v1
  ]
  create_duration  = "5s"
  destroy_duration = "15s"
}
resource "time_sleep" "step_groups_v2" {
  depends_on = [
    harness_platform_template.stg_Gitleaks_Scans_v2,
    harness_platform_template.stg_OSV_SCA_v2,
    harness_platform_template.stg_OWASP_Dependency_Check_v2,
    harness_platform_template.stg_Semgrep_Sast_v2
  ]

  create_duration  = "5s"
  destroy_duration = "15s"
}
resource "time_sleep" "step_groups" {
  depends_on = [
    time_sleep.step_groups_v1,
    time_sleep.step_groups_v2
  ]

  destroy_duration = "15s"
}


resource "time_sleep" "stages_v1" {
  depends_on = [
    harness_platform_template.sta_STO_SAST_SCA_Primer_v1
  ]

  create_duration  = "5s"
  destroy_duration = "15s"
}

resource "time_sleep" "stages_v2" {
  depends_on = [
    harness_platform_template.sta_STO_SAST_SCA_Primer_v2
  ]

  create_duration  = "5s"
  destroy_duration = "15s"
}

resource "time_sleep" "stages" {
  depends_on = [
    time_sleep.stages_v1,
    time_sleep.stages_v2
  ]

  destroy_duration = "15s"
}


resource "time_sleep" "pipelines_v2" {
  depends_on = [
    time_sleep.stages,
    harness_platform_template.pipe_STO_SAST_SCA_Pipeline_HCR_v2,
    harness_platform_template.pipe_STO_SAST_SCA_Pipeline_v2
  ]

  create_duration  = "5s"
  destroy_duration = "15s"
}

resource "time_sleep" "pipelines" {
  depends_on = [
    time_sleep.pipelines_v2,
    harness_platform_template.pipe_STO_SAST_SCA_Pipeline_HCR_v1,
    harness_platform_template.pipe_STO_SAST_SCA_Pipeline_v1
  ]

  destroy_duration = "15s"
}
