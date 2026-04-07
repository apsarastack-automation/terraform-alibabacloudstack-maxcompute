# MaxCompute Project with VPC Attachment

This example creates a new MaxCompute project with user and CU, and optionally attaches it to an existing VPC or creates a new one.

> Note: If `vpc_id` is not provided, this example will create a new VPC.

## Usage

1. Configure variables (via `terraform.tfvars` or CLI):
   ```hcl
   project_name = "my-maxcompute-with-vpc"
   vpc_id       = "vpc-xxxxxxxx"  # Optional: leave empty to create new VPC
   cu_num       = 4
   ```
2. Run:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

3. Clean up:
   ```bash
   terraform destroy
   ```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.6 |

## Provider

| Name | Version |
|------|---------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## Module

| Name | Source | Version |
|------|--------|---------|
| maxcompute_project | ../../modules/maxcompute_project | n/a |

## Input Variables

| Name | Description | Type | Example | Required |
|------|-------------|------|--------|----------|
| project_name | Name of the new MaxCompute project to create. | string | "tfmaxcompute1" | Yes |
| vpc_id | ID of an existing VPC to attach (optional). | string | "vpc-xxxxxxxx" | No |
| cu_num | Number of CUs for the MaxCompute CU. | number | 2 | No |

## Output Variables

| Name | Description |
|------|-------------|
| project_id | ID of the created MaxCompute project. |
| project_name | Name of the created MaxCompute project. |
| user_id | ID of the MaxCompute user. |
| cu_id | ID of the MaxCompute CU. |
| vpc_id | ID of the VPC used or created. |
