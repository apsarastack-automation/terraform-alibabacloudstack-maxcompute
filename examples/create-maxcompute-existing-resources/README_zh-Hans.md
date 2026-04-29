# 使用现有资源创建 MaxCompute 项目

此 Terraform 示例用于**使用现有的用户和 CU 资源创建 MaxCompute 项目**。

> ⚠️ **注意**：此示例假设您已经拥有 MaxCompute 用户和 CU。它不会创建新的资源。

## 使用方法

1. 确保已存在 MaxCompute 用户和 CU。
2. 配置变量（通过 `terraform.tfvars` 或命令行）：
   ```hcl
   project_name = "my-maxcompute-project"
   user_id      = "existing-user-id"
   user_pk      = "existing-user-pk"
   cu_id        = "existing-cu-id"
   ```
3. 执行以下命令：
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. 清理资源（仅删除项目 - 用户和 CU 不受影响）：
   ```bash
   terraform destroy
   ```

> ⚠️ **注意**：此操作**不会删除现有的用户或 CU** - 仅管理项目。

## 要求

| 名称 | 版本 |
|------|------|
| Terraform | >= 1.5.6 |

## 提供商

| 名称 | 版本 |
|------|------|
| alibabacloudstack | >= 3.18.28, < 3.19.0 |

## 模块依赖

| 模块名称 | 来源路径 |
|----------|----------|
| `maxcompute_project` | `../../modules/maxcompute_project` |

## 输入变量

| 名称 | 描述 | 类型 | 默认值 | 必需 |
|------|------|------|--------|------|
| `project_name` | **新 MaxCompute 项目的名称** | `string` | - | 是 |
| `cu_id` | **现有 MaxCompute CU 的 ID** | `string` | - | 是 |

## 输出变量

| 名称 | 描述 |
|------|------|
| `project_id` | 创建的 MaxCompute 项目 ID |
| `project_name` | 创建的 MaxCompute 项目名称 |

## 注意事项

- 此示例**假设用户和 CU 已存在**。如果不存在，Terraform 将报错。
- 执行 `terraform destroy`**仅删除项目** - 不会影响用户或 CU。
