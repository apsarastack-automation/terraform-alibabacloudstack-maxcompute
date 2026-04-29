# Alibaba Cloud MaxCompute Terraform Module

This module manages Alibaba Cloud MaxCompute projects, CUs (Compute Units), and users on Alibaba Cloud Stack, supporting:
- **Creating a new MaxCompute project** with associated CU and user
- **Optional VPC network attachment** (reusing an existing VPC or automatically creating one)
- **Flexible configuration** for disk size, external tables, and compute resources

## Supported Resources

* [alibabacloudstack_maxcompute_project](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/maxcompute_project)
* [alibabacloudstack_maxcompute_cu](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/maxcompute_cu)
* [alibabacloudstack_vpc_vpc](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/vpc_vpc)

## Usage Examples

### Scenario 1: Create a basic MaxCompute project

```hcl
module "maxcompute" {
  source = "./terraform-alibabacloudstack-maxcompute"

  project_name = "my-maxcompute-project"
}
```

### Scenario 2: Create MaxCompute project with custom CU and user

```hcl
module "maxcompute" {
  source = "./terraform-alibabacloudstack-maxcompute"

  project_name     = "my-maxcompute-project"
  user_name        = "custom-user"
  user_description = "Custom user for MaxCompute project"
  cu_name          = "custom-cu"
  cu_num           = 4
  cluster_name     = "HYBRIDODPSCLUSTER-A-20210520-07B0"
  disk_size        = "100"
}
```

### Scenario 3: Create MaxCompute project with VPC attachment (auto-create VPC)

```hcl
module "maxcompute" {
  source = "./terraform-alibabacloudstack-maxcompute"

  project_name = "my-maxcompute-with-vpc"
  vpc_name     = "my-vpc"  # Triggers automatic VPC creation
  attach_vpc   = true
}
```

### Scenario 4: Attach using an existing VPC

```hcl
module "maxcompute" {
  source = "./terraform-alibabacloudstack-maxcompute"

  project_name = "my-maxcompute-with-existing-vpc"
  vpc_id       = "vpc-xxxxxxxx"  # Use existing VPC
  attach_vpc   = true
}
```

> ⚠️ **Key Constraints**:
> - When `attach_vpc = true`, you **must provide either `vpc_id` or `vpc_name`**.
> - `cluster_name` is optional; if not provided, the module will auto-detect from available clusters.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.6 |

## Providers

| Name | Version |
|------|---------|
| alibabacloudstack | >= 3.18.28, < 3.19.0 |

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| **project_name** | **Name for the new MaxCompute project** | `string` | — | Yes |
| create_user | Whether to create a new MaxCompute user | `bool` | `true` | No |
| user_name | Name for the MaxCompute user (defaults to project_name) | `string` | `""` | No |
| user_description | Description for the MaxCompute user | `string` | `""` | No |
| create_cu | Whether to create a new MaxCompute CU | `bool` | `true` | No |
| cu_name | Name for the MaxCompute CU (defaults to project_name) | `string` | `""` | No |
| cu_num | Number of CUs for the MaxCompute CU | `number` | `2` | No |
| cluster_name | Cluster name for the MaxCompute CU (auto-detected if empty) | `string` | `""` | No |
| disk_size | Disk size for the MaxCompute project | `string` | `"50"` | No |
| enable_external_table | Whether to enable external table (joint computing) | `bool` | `true` | No |
| **attach_vpc** | Whether to attach a VPC to the MaxCompute project | `bool` | `false` | No |
| **vpc_id** | **ID of an existing VPC to attach (required if `attach_vpc = true` and not using `vpc_name`)** | `string` | `""` | No |
| **vpc_name** | **Name prefix for automatically creating a VPC (required if `attach_vpc = true` and not using `vpc_id`)** | `string` | `""` | No |
| core_arch | Core architecture of the MaxCompute project | `string` | `""` | No |
| cpu_type | CPU type of the MaxCompute project | `string` | `""` | No |

> 💡 **Mutual Exclusion Rules**:
> - `vpc_id` and `vpc_name`: when `attach_vpc = true`, at least one must be provided.

## Output Values

| Name | Description |
|------|-------------|
| project_id | ID of the MaxCompute project |
| project_name | Name of the MaxCompute project |
| user_id | ID of the MaxCompute user |
| user_pk | PK of the MaxCompute user |
| cu_id | ID of the MaxCompute CU |
| vpc_id | ID of the VPC used or created |

## Notes

* When `attach_vpc = true` and `vpc_id` is not provided, the module automatically creates a VPC using `vpc_name` as the name prefix.
* The MaxCompute project ID is the same as its name.

## Reporting Issues

If you encounter any issues while using this module, please open an issue in the [provider repository](https://github.com/aliyun/terraform-provider-alibabacloudstack/issues/new).

> **Note**: Please do **not** open issues in this module's repository.

## Authors

Created and maintained by the Alibaba Cloud Terraform Team.

## License

MIT License. See LICENSE for details.

## References

* [Terraform Provider for Alibaba Cloud Stack (GitHub)](https://github.com/aliyun/terraform-provider-alibabacloudstack)
* [Terraform Provider Registry](https://registry.terraform.io/providers/aliyun/alibabacloudstack)
* [Provider Documentation](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs)
