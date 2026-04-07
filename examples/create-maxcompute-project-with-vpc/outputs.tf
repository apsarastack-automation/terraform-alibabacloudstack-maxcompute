output "project_id" {
  description = "The ID of the MaxCompute project."
  value       = module.maxcompute_project.project_id
}

output "project_name" {
  description = "The name of the MaxCompute project."
  value       = module.maxcompute_project.project_name
}

output "user_id" {
  description = "The ID of the MaxCompute user."
  value       = module.maxcompute_project.user_id
}

output "cu_id" {
  description = "The ID of the MaxCompute CU."
  value       = module.maxcompute_project.cu_id
}

output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.maxcompute_project.vpc_id
}
