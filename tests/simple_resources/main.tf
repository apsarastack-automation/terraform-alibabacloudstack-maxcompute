data "alibabacloudstack_maxcompute_clusters" "existing" {
  name_regex = "HYBRIDODPSCLUSTER-.*"
}

resource "alibabacloudstack_maxcompute_user" "existing" {
  user_name   = "${var.name}_user"
  description = "${var.name} description"
}

# --- MaxCompute CU Resource ---

resource "alibabacloudstack_maxcompute_cu" "existing" {
  cu_name      = "${var.name}_cu"
  cu_num       = var.cu_num
  cluster_name = data.alibabacloudstack_maxcompute_clusters.existing.clusters[0].cluster
}