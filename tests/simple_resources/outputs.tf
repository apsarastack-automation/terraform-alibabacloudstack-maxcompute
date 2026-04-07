output "user_id" {
  description = "The ID of the MaxCompute user."
  value       = alibabacloudstack_maxcompute_user.existing.id
}



output "user_pk" {
  description = "The PK of the MaxCompute user."
  value       = alibabacloudstack_maxcompute_user.existing.user_pk
}

output "cu_id" {
  description = "The ID of the MaxCompute CU."
  value       = alibabacloudstack_maxcompute_cu.existing.id
}