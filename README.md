# Alibaba Cloud MaxCompute Terraform Module

This module creates **MaxCompute projects, CUs (Compute Units), and users** on Alibaba Cloud Stack and optionally configures **VPC network attachments**.

## Features

- Creates a new MaxCompute project
- Automatically creates a MaxCompute user (optional)
- Automatically creates a MaxCompute CU (optional)
- Optional: Attaches the MaxCompute project to a VPC
  - Supports reusing an existing VPC (via `vpc_id`)
  - Supports automatic creation of a VPC (via `vpc_name`)

## Usage

### Basic Usage: Create MaxCompute Project

```hcl
module "maxcompute" {
  source = "<Module Path>"

  project_name = "my-maxcompute-project"
}
```

### Advanced Usage: Custom CU and User

```hcl
module "maxcompute" {
  source = "<Module Path>"

  project_name     = "my-maxcompute-project"
  user_name        = "custom-user"
  user_description = "Custom user for MaxCompute project"
  cu_name          = "custom-cu"
  cu_num           = 4
  cluster_name     = "HYBRIDODPSCLUSTER-A-20210520-07B0"
  disk_size        = "100"
}
```

### Advanced Usage: Enable VPC Attachment (Reuse Existing VPC)

```hcl
module "maxcompute" {
  source = "<Module Path>"

  project_name = "secure-maxcompute"
  attach_vpc   = true
  vpc_id       = "vpc-xxxxxxxx"  # Must be an existing VPC ID
}
```

### Advanced Usage: Enable VPC Attachment (Auto-create VPC)

```hcl
module "maxcompute" {
  source = "<Module Path>"

  project_name = "auto-vpc-maxcompute"
  attach_vpc   = true
  vpc_name     = "my-maxcompute-vpc"  # Used as prefix for VPC name
}
```

## Environment Dependencies

### Terraform Core

| Name      | Version   |
|-----------|-----------|
| Terraform | >= 1.5.6  |

### Provider

| Name              | Version                |
|-------------------|------------------------|
| alibabacloudstack | >= 3.18.24, < 3.19.0   |

## Module Variables

### Input Variables

| Name                         | Description                                                                                     | Type              | Default | Required |
|------------------------------|-------------------------------------------------------------------------------------------------|-------------------|---------|----------|
| `project_name`               | MaxCompute project name                                                                         | `string`          | —       | Yes      |
| `create_user`                | Whether to create a new MaxCompute user                                                         | `bool`            | `true`  | No       |
| `user_name`                  | MaxCompute user name (defaults to project_name)                                                 | `string`          | `""`    | No       |
| `user_description`           | MaxCompute user description                                                                     | `string`          | `""`    | No       |
| `create_cu`                  | Whether to create a new MaxCompute CU                                                           | `bool`            | `true`  | No       |
| `cu_name`                    | MaxCompute CU name (defaults to project_name)                                                   | `string`          | `""`    | No       |
| `cu_num`                     | Number of CUs                                                                                   | `number`          | `2`     | No       |
| `cluster_name`               | Cluster name for CU (auto-detected if empty)                                                    | `string`          | `""`    | No       |
| `disk_size`                  | Disk size for the project                                                                       | `string`          | `"50"`  | No       |
| `enable_external_table`      | Whether to enable external table (joint computing)                                              | `bool`            | `true`  | No       |
| `attach_vpc`                 | Whether to attach a VPC                                                                         | `bool`            | `false` | No       |
| `vpc_id`                     | Existing VPC ID (required if `attach_vpc = true`, one of two mutually exclusive options)       | `string`          | `""`    | No       |
| `vpc_name`                   | Name prefix for auto-created VPC (used when `attach_vpc = true` and `vpc_id` is not provided)  | `string`          | `""`    | No       |
| `core_arch`                  | Core architecture of the project                                                                | `string`          | `""`    | No       |
| `cpu_type`                   | CPU type of the project                                                                         | `string`          | `""`    | No       |

> 💡 **Mutual Exclusion Rule**: When `attach_vpc = true`, exactly *one* of `vpc_id` or `vpc_name` must be provided.

### Output Variables

| Name                | Description                                      |
|---------------------|--------------------------------------------------|
| `project_id`        | ID of the created MaxCompute project             |
| `project_name`      | Name of the created MaxCompute project           |
| `user_id`           | ID of the MaxCompute user                        |
| `user_pk`           | PK of the MaxCompute user                        |
| `cu_id`             | ID of the MaxCompute CU                          |
| `vpc_id`            | Associated VPC ID                                |

## Examples

For more usage scenarios, see the [`examples/`](./examples) directory:
- `create-maxcompute-project-with-vpc`
- `create-maxcompute-project-existing-resources`

## Notes

- This module **always creates a new MaxCompute project**.
- The MaxCompute project ID is the same as its name.
- When `attach_vpc = true` and no `vpc_id` is provided, the module automatically creates a VPC.
- The module can optionally create or use existing CU and user resources.
