# Create MaxCompute Project with Existing Resources

This Terraform example **creates a MaxCompute project using existing user and CU resources**.

> ⚠️ **Note**: This example assumes you already have a MaxCompute user and CU. It will not create new ones.

## Usage

1. Ensure a MaxCompute user and CU already exist.
2. Configure variables (via `terraform.tfvars` or command line):
   ```hcl
   project_name = "my-maxcompute-project"
   user_id      = "existing-user-id"
   user_pk      = "existing-user-pk"
   cu_id        = "existing-cu-id"
   ```
3. Run the following commands:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. Clean up resources (project only - user and CU remain unaffected):
   ```bash
   terraform destroy
   ```

> ⚠️ **Note**: This operation **does not delete the existing user or CU** - it only manages the project.

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.5.6 |

## Provider

| Name | Version |
|------|---------|
| alibabacloudstack | >= 3.18.28, < 3.19.0 |

## Module Dependency

| Module Name | Source Path |
|-------------|-------------|
| `maxcompute_project` | `../../modules/maxcompute_project` |

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `project_name` | **Name for the new MaxCompute project** | `string` | - | Yes |
| `user_id` | **ID of an existing MaxCompute user** | `string` | - | Yes |
| `user_pk` | **PK of an existing MaxCompute user** | `string` | - | Yes |
| `cu_id` | **ID of an existing MaxCompute CU** | `string` | - | Yes |

## Output Values

| Name | Description |
|------|-------------|
| `project_id` | ID of the created MaxCompute project |
| `project_name` | Name of the created MaxCompute project |

## Notes

- This example **assumes the user and CU already exist**. If not, Terraform will fail.
- Running `terraform destroy` **only deletes the project** - it does not affect the user or CU.
