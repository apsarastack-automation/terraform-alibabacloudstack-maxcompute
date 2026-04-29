# 阿里云 MaxCompute Terraform 模块

该模块用于在阿里云 Stack 上管理 MaxCompute 项目和 CU（计算单元），支持：
- **创建新的 MaxCompute 项目** 并配置关联的 CU
- **可选配置 VPC 网络附件**（复用现有 VPC 或自动创建 VPC）
- **灵活的配置选项** 用于磁盘大小、外部表和计算资源

## 支持资源

* [alibabacloudstack_maxcompute_project](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/maxcompute_project)
* [alibabacloudstack_maxcompute_cu](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/maxcompute_cu)
* [alibabacloudstack_vpc_vpc](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/vpc_vpc)

## 使用方法

### 场景 1：创建基本的 MaxCompute 项目

```hcl
module "maxcompute" {
  source = "./terraform-alibabacloudstack-maxcompute"

  project_name = "my-maxcompute-project"
}
```

### 场景 2：创建带自定义 CU 的 MaxCompute 项目

```hcl
module "maxcompute" {
  source = "./terraform-alibabacloudstack-maxcompute"

  project_name     = "my-maxcompute-project"
  cu_name          = "custom-cu"
  cu_num           = 4
  cluster_name     = "HYBRIDODPSCLUSTER-A-20210520-07B0"
  disk_size        = "100"
}
```

### 场景 3：创建带 VPC 附件的 MaxCompute 项目（自动创建 VPC）

```hcl
module "maxcompute" {
  source = "./terraform-alibabacloudstack-maxcompute"

  project_name = "my-maxcompute-with-vpc"
  vpc_name     = "my-vpc"  # 触发自动创建 VPC
  attach_vpc   = true
}
```

### 场景 4：使用现有 VPC 附加

```hcl
module "maxcompute" {
  source = "./terraform-alibabacloudstack-maxcompute"

  project_name = "my-maxcompute-with-existing-vpc"
  vpc_id       = "vpc-xxxxxxxx"  # 使用现有 VPC
  attach_vpc   = true
}
```

> ⚠️ **关键约束**：
> - 当 `attach_vpc = true` 时，**必须提供 `vpc_id` 或 `vpc_name`**。
> - `cluster_name` 是可选的；如果未提供，模块将从可用集群中自动检测。

## 要求

| 名称 | 版本 |
|------|------|
| terraform | >= 1.5.6 |

## 提供商

| 名称 | 版本 |
|------|------|
| alibabacloudstack | >= 3.18.28, < 3.19.0 |

## 输入变量

| 名称 | 描述 | 类型 | 默认值 | 必需 |
|------|------|------|--------|------|
| **project_name** | **新 MaxCompute 项目的名称** | `string` | — | 是 |
| create_cu | 是否创建新的 MaxCompute CU | `bool` | `true` | 否 |
| cu_name | MaxCompute CU 的名称（默认为 project_name） | `string` | `""` | 否 |
| cu_num | MaxCompute CU 的数量 | `number` | `2` | 否 |
| cluster_name | MaxCompute CU 的集群名称（为空时自动检测） | `string` | `""` | 否 |
| disk_size | MaxCompute 项目的磁盘大小 | `string` | `"50"` | 否 |
| enable_external_table | 是否启用外部表（联合计算） | `bool` | `true` | 否 |
| **attach_vpc** | 是否将 VPC 附加到 MaxCompute 项目 | `bool` | `false` | 否 |
| **vpc_id** | **要附加的现有 VPC ID（当 `attach_vpc = true` 时必填之一）** | `string` | `""` | 否 |
| **vpc_name** | **用于自动创建 VPC 的名称前缀（当 `attach_vpc = true` 时必填之一）** | `string` | `""` | 否 |
| core_arch | MaxCompute 项目的核心架构 | `string` | `""` | 否 |
| cpu_type | MaxCompute 项目的 CPU 类型 | `string` | `""` | 否 |

> 💡 **互斥规则**：
> - `vpc_id` 和 `vpc_name`：当 `attach_vpc = true` 时，至少提供一个

## 输出变量

| 名称 | 描述 |
|------|------|
| project_id | MaxCompute 项目的 ID |
| project_name | MaxCompute 项目的名称 |
| user_id | MaxCompute 用户的 ID |
| user_pk | MaxCompute 用户的 PK |
| cu_id | MaxCompute CU 的 ID |
| vpc_id | 使用或创建的 VPC ID |

## 注意事项

* 当 `attach_vpc = true` 且未提供 `vpc_id` 时，模块会自动创建 VPC，名称基于 `vpc_name`。
* MaxCompute 项目 ID 与其名称相同。

## 提交问题

如果您在使用此模块时遇到任何问题，请提交 [provider issue](https://github.com/aliyun/terraform-provider-alibabacloudstack/issues/new) 并告知我们。

**注意：** 不建议在此仓库上提交 issue。

## 作者

由阿里云 Terraform 团队创建和维护

## 许可证

MIT 许可证。详情请参见 LICENSE。

## 参考

* [Terraform-Provider-Alibabacloudstack Github](https://github.com/aliyun/terraform-provider-alibabacloudstack)
* [Terraform-Provider-Alibabacloudstack Release](https://registry.terraform.io/providers/aliyun/alibabacloudstack)
* [Terraform-Provider-Alibabacloudstack 文档](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs)
