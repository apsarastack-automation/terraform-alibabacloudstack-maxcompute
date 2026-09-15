data "alibabacloudstack_maxcompute_clusters" "existing" {
  name_regex = "HYBRIDODPS.*CLUSTER-.*"
}

# Guard against non-deterministic cluster resolution: name_regex may match
# multiple clusters, and picking [0] could drift between plans.
check "single_maxcompute_cluster_match" {
  assert {
    condition     = length(data.alibabacloudstack_maxcompute_clusters.existing.clusters) <= 1
    error_message = "name_regex 'HYBRIDODPS.*CLUSTER-.*' matched ${length(data.alibabacloudstack_maxcompute_clusters.existing.clusters)} clusters; picking [0] is non-deterministic."
  }
}

# --- MaxCompute CU Resource ---

resource "alibabacloudstack_maxcompute_cu" "existing" {
  cu_name      = "${var.name}_cu"
  cu_num       = var.cu_num
  cluster_name = data.alibabacloudstack_maxcompute_clusters.existing.clusters[0].cluster
}
