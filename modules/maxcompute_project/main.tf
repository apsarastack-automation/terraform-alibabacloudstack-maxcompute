# --- Data Sources ---

data "alibabacloudstack_maxcompute_clusters" "default" {
  name_regex = "HYBRIDODPSCLUSTER-.*"
}

data "alibabacloudstack_vpc_vpcs" "default" {
  ids = [coalesce(var.vpc_id, "fake_id")]
}

locals {
  _validate_vpc = (
    var.vpc_id != "" &&
    length(data.alibabacloudstack_vpc_vpcs.default[*].ids) == 0
  ) ? error("VPC '${var.vpc_id}' not found.") : ""
}

# --- Control flags ---

locals {
  # Controls whether to create VPC
  vpc_create = var.vpc_id == "" && var.attach_vpc ? 1 : 0

  # Use provided cluster name or auto-detect
  actual_cluster_name = var.cluster_name != "" ? var.cluster_name : (
    length(data.alibabacloudstack_maxcompute_clusters.default.clusters) > 0 ?
    data.alibabacloudstack_maxcompute_clusters.default.clusters[0].cluster : ""
  )

  # Use provided CU name or default to project name
  actual_cu_name = var.cu_name != "" ? var.cu_name : var.project_name
}

# --- VPC Resource ---

resource "alibabacloudstack_vpc_vpc" "default" {
  count      = local.vpc_create
  cidr_block = "172.16.0.0/16"
  vpc_name   = "${var.project_name}-vpc"
}

# --- VPC derived locals ---

locals {
  maxcompute_vpc_id = var.attach_vpc ? (
    var.vpc_id != "" ? var.vpc_id : one(alibabacloudstack_vpc_vpc.default).id
  ) : null

  vpc_ids = var.attach_vpc ? [local.maxcompute_vpc_id] : []
}

# --- MaxCompute CU Resource ---
data "alibabacloudstack_maxcompute_cus" "default" {
  ids = [coalesce(var.cu_id, "fake_id")]
}

locals {
  create_cu = var.cu_id != "" ? 0 : 1
}

resource "alibabacloudstack_maxcompute_cu" "default" {
  count        = var.create_cu ? 1 : 0
  cu_name      = local.actual_cu_name
  cu_num       = var.cu_num
  cluster_name = local.actual_cluster_name
}

# --- CU derived locals ---

locals {
  cu_id    = var.create_cu ? one(alibabacloudstack_maxcompute_cu.default).id : data.alibabacloudstack_maxcompute_cus.default.cus[0].id
  cu_quota = var.create_cu ? one(alibabacloudstack_maxcompute_cu.default).id : data.alibabacloudstack_maxcompute_cus.default.cus[0].id
}

# --- MaxCompute Project Resource ---

resource "alibabacloudstack_maxcompute_project" "default" {
  name           = var.project_name
  account_pk     = var.user_pk
  quota_id       = local.cu_quota
  external_table = var.enable_external_table ? "true" : "false"
  vpc_ids        = length(local.vpc_ids) > 0 ? local.vpc_ids : null
  disk           = var.disk_size
  account        = var.user_id
  core_arch      = var.core_arch != "" ? var.core_arch : null
  cpu_type       = var.cpu_type != "" ? var.cpu_type : null
}
