output "project_id" {
  description = "The ID of the MaxCompute project."
  value       = module.maxcompute_project.project_id
}

output "project_name" {
  description = "The name of the MaxCompute project."
  value       = module.maxcompute_project.project_name
}
