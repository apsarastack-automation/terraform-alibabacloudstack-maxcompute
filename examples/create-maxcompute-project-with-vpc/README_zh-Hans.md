# 带 VPC 附件的 MaxCompute 项目

本示例用于创建一个新的 MaxCompute 项目及其用户和 CU，并可选地将其附加到现有 VPC 或创建新 VPC。

> 注意：如果未提供 `vpc_id`，本示例将创建一个新的 VPC。

## 使用方法

1. 通过 `terraform.tfvars` 或命令行配置变量：
   ```hcl
   project_name = "my-maxcompute-with-vpc"
   vpc_id       = "vpc-xxxxxxxx"  # 可选：留空以创建新 VPC
   cu_num       = 4
   ```
2. 执行以下命令：
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

3. 清理资源：
   ```bash
   terraform destroy
   ```

## 要求

| 名称 | 版本 |
|------|------|
| terraform | >= 1.5.6 |

## 提供商

| 名称 | 版本 |
|------|------|
| alibabacloudstack | >= 3.18.28, < 3.19.0 |

## 模块

| 名称 | 来源 | 版本 |
|------|------|------|
| maxcompute_project | ../../modules/maxcompute_project | n/a |

## 输入变量

| 名称 | 描述 | 类型 | 示例值 | 必需 |
|------|------|------|--------|------|
| project_name | 要创建的新 MaxCompute 项目名称。 | string | "tfmaxcompute1" | 是 |
| vpc_id | 要附加的现有 VPC 的 ID（可选）。 | string | "vpc-xxxxxxxx" | 否 |
| cu_num | MaxCompute CU 的数量。 | number | 2 | 否 |

## 输出变量

| 名称 | 描述 |
|------|------|
| project_id | 创建的 MaxCompute 项目 ID。 |
| project_name | 创建的 MaxCompute 项目名称。 |
| user_id | MaxCompute 用户的 ID。 |
| cu_id | MaxCompute CU 的 ID。 |
| vpc_id | 使用或创建的 VPC ID。 |
