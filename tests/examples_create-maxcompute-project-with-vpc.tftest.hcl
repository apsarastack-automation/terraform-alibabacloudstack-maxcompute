run "setup_vpc" {
  command = apply
  module {
    source = "./setup_vpc/simple_vpc"
  }
  variables {
    name = "tfmax3"
  }
}

run "validate" {
  command = apply
  module {
    source = "../examples/create-maxcompute-project-with-vpc"
  }
  variables {
    project_name = "tfmax4"
    vpc_id       = run.setup_vpc.vpc_id
    cu_num       = 2
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
