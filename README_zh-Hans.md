# 阿里云 MaxCompute Terraform 模块

该模块用于在阿里云 Stack 上创建 **MaxCompute 项目、CU（计算单元）和用户**，并可选地配置 **VPC 网络附件**。

## 功能特性

- 创建新的 MaxCompute 项目
- 自动创建 MaxCompute 用户（可选）
- 自动创建 MaxCompute CU（可选）
- 可选：将 MaxCompute 项目附加到 VPC
  - 支持复用现有 VPC（通过 `vpc_id`）
  - 支持自动创建 VPC（通过 `vpc_name`）

## 使用方法

### 基础用法：创建 MaxCompute 项目

```hcl
module "maxcompute" {
  source = "<Module Path>"

  project_name = "my-maxcompute-project"
}
```

### 高级用法：自定义 CU 和用户

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

### 高级用法：启用 VPC 附件（复用现有 VPC）

```hcl
module "maxcompute" {
  source = "<Module Path>"

  project_name = "secure-maxcompute"
  attach_vpc   = true
  vpc_id       = "vpc-xxxxxxxx"  # 必须是已存在的 VPC ID
}
```

### 高级用法：启用 VPC 附件（自动创建 VPC）

```hcl
module "maxcompute" {
  source = "<Module Path>"

  project_name = "auto-vpc-maxcompute"
  attach_vpc   = true
  vpc_name     = "my-maxcompute-vpc"  # 用作 VPC 名称前缀
}
```

## 环境依赖

### Terraform Core

| 名称 | 版本 |
|------|------|
| Terraform | >= 1.5.6 |

### Provider

| 名称 | 版本 |
|------|------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## 模块变量

### 输入变量

| 名称 | 描述 | 类型 | 默认值 | 必需 |
|------|------|------|--------|------|
| `project_name` | MaxCompute 项目名称 | `string` | — | 是 |
| `create_user` | 是否创建新的 MaxCompute 用户 | `bool` | `true` | 否 |
| `user_name` | MaxCompute 用户名称（默认为 project_name） | `string` | `""` | 否 |
| `user_description` | MaxCompute 用户描述 | `string` | `""` | 否 |
| `create_cu` | 是否创建新的 MaxCompute CU | `bool` | `true` | 否 |
| `cu_name` | MaxCompute CU 名称（默认为 project_name） | `string` | `""` | 否 |
| `cu_num` | CU 数量 | `number` | `2` | 否 |
| `cluster_name` | CU 的集群名称（为空时自动检测） | `string` | `""` | 否 |
| `disk_size` | 项目的磁盘大小 | `string` | `"50"` | 否 |
| `enable_external_table` | 是否启用外部表（联合计算） | `bool` | `true` | 否 |
| `attach_vpc` | 是否附加 VPC | `bool` | `false` | 否 |
| `vpc_id` | 现有 VPC ID（当 `attach_vpc = true` 时必填之一） | `string` | `""` | 否 |
| `vpc_name` | 自动创建 VPC 的名称前缀（当 `attach_vpc = true` 且未提供 `vpc_id` 时使用） | `string` | `""` | 否 |
| `core_arch` | 项目的核心架构 | `string` | `""` | 否 |
| `cpu_type` | 项目的 CPU 类型 | `string` | `""` | 否 |

> 💡 **互斥规则**：当 `attach_vpc = true` 时，必须提供 `vpc_id` 或 `vpc_name` 中的一个。

### 输出变量

| 名称 | 描述 |
|------|------|
| `project_id` | 创建的 MaxCompute 项目 ID |
| `project_name` | 创建的 MaxCompute 项目名称 |
| `user_id` | MaxCompute 用户的 ID |
| `user_pk` | MaxCompute 用户的 PK |
| `cu_id` | MaxCompute CU 的 ID |
| `vpc_id` | 关联的 VPC ID |

## 示例

更多使用场景请参见 [`examples/`](./examples) 目录：
- `create-maxcompute-project-with-vpc`
- `create-maxcompute-project-existing-resources`

## 注意事项

- 本模块**总是创建新的 MaxCompute 项目**。
- MaxCompute 项目 ID 与其名称相同。
- 当 `attach_vpc = true` 且未提供 `vpc_id` 时，模块会自动创建 VPC。
- 模块可以选创建或使用现有的 CU 和用户资源。
