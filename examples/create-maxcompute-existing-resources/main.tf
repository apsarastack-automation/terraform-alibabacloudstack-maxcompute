module "maxcompute_project" {
  source       = "../../modules/maxcompute_project"
  project_name = var.project_name
  create_cu    = false
  cu_id        = var.cu_id
  user_id      = var.user_id
  user_pk      = var.user_pk
}
