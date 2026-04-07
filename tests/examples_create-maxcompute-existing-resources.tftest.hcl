run "setup_resources" {
  command = apply
  module {
    source = "./simple_resources"
  }
  variables {
    name       = "tfmax25"
  }
}

run "validate" {
  command = apply
  module {
    source = "../examples/create-maxcompute-existing-resources"
  }
  variables {
    project_name = "tfmax25"
    user_id      = run.setup_resources.user_id
    cu_id        = run.setup_resources.cu_id
  }
  assert {
    condition     = output.project_id != ""
    error_message = "MaxCompute project creation failed"
  }
  assert {
    condition     = output.project_name == "tfmax25"
    error_message = "Project name should match the input"
  }
}
