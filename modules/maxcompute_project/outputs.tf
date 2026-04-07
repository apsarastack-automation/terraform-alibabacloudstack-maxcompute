output "project_id" {
  description = "The ID of the MaxCompute project."
  value       = alibabacloudstack_maxcompute_project.default.id
}

output "project_name" {
  description = "The name of the MaxCompute project."
  value       = alibabacloudstack_maxcompute_project.default.name
}

output "user_id" {
  description = "The ID of the MaxCompute user."
  value       = local.user_id
}

output "user_pk" {
  description = "The PK of the MaxCompute user."
  value       = local.user_pk
}

output "cu_id" {
  description = "The ID of the MaxCompute CU."
  value       = local.cu_id
}

output "vpc_id" {
  description = "The ID of the created or used VPC."
  value       = local.maxcompute_vpc_id
}
