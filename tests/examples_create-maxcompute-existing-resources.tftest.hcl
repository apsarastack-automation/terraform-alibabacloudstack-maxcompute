run "setup_resources" {
  command = apply
  module {
    source = "./simple_resources"
  }
  variables {
    name = "tfmaxcompute_test_002"
  }
}

run "validate" {
  command = apply
  module {
    source = "../examples/create-maxcompute-existing-resources"
  }
  variables {
    project_name = "tfmaxcompute_test_002"
    cu_id        = run.setup_resources.cu_id
    user_id      = "5106"
    user_pk      = "1583089388453681"
  }
  assert {
    condition     = output.project_id != ""
    error_message = "MaxCompute project creation failed"
  }
  assert {
    condition     = output.project_name == "tfmaxcompute_test_002"
    error_message = "Project name should match the input"
  }
}
