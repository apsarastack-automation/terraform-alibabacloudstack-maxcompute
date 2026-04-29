module "maxcompute_project" {
  source       = "../../modules/maxcompute_project"
  project_name = var.project_name
  cu_num       = var.cu_num
  attach_vpc   = true
  vpc_id       = var.vpc_id
  user_id      = var.user_id
  user_pk      = var.user_pk
}
