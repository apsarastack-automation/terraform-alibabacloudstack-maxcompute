run "setup_vpc" {
  command = apply
  module {
    source = "./setup_vpc/simple_vpc"
  }
  variables {
    name = "tfmaxcompute_test_003"
  }
}

run "validate" {
  command = apply
  module {
    source = "../examples/create-maxcompute-project-with-vpc"
  }
  variables {
    project_name = "tfmaxcompute_test_003"
    vpc_id       = run.setup_vpc.vpc_id
    cu_num       = 2
    user_id      = "5106"
    user_pk      = "1583089388453681"
  }
  assert {
    condition     = output.project_id != ""
    error_message = "MaxCompute project creation failed"
  }
  assert {
    condition     = output.vpc_id != ""
    error_message = "VPC attachment failed"
  }
}
