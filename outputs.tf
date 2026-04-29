output "project_id" {
  description = "The ID of the MaxCompute project."
  value       = module.default.project_id
}

output "project_name" {
  description = "The name of the MaxCompute project."
  value       = module.default.project_name
}

output "cu_id" {
  description = "The ID of the MaxCompute CU."
  value       = module.default.cu_id
}

output "vpc_id" {
  description = "The ID of the attached or created VPC."
  value       = module.default.vpc_id
}
