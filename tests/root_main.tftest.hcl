run "validate" {
  command = apply
  module {
    source = "../"
  }
  variables {
    project_name          = "tfmaxcompute5"
    user_description      = "Test MaxCompute project"
    cu_num                = 2
    disk_size             = "50"
    enable_external_table = true
    attach_vpc            = true
  }

  assert {
    condition     = output.project_id != ""
    error_message = "MaxCompute project ID should not be empty."
  }

  assert {
    condition     = output.project_name == "tfmaxcompute5"
    error_message = "Project name should match the input."
  }

  assert {
    condition     = output.user_id != ""
    error_message = "User ID should not be empty."
  }

  assert {
    condition     = output.cu_id != ""
    error_message = "CU ID should not be empty."
  }

  assert {
    condition     = output.vpc_id != ""
    error_message = "VPC ID should not be empty when attach_vpc=true."
  }
}
