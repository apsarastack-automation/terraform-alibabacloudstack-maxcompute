module "default" {
  source = "./modules/maxcompute_project"

  project_name          = var.project_name
  create_user           = var.create_user
  user_name             = var.user_name
  user_description      = var.user_description
  create_cu             = var.create_cu
  cu_name               = var.cu_name
  cu_num                = var.cu_num
  cluster_name          = var.cluster_name
  disk_size             = var.disk_size
  enable_external_table = var.enable_external_table
  attach_vpc            = var.attach_vpc
  vpc_id                = var.vpc_id
  core_arch             = var.core_arch
  cpu_type              = var.cpu_type
}
