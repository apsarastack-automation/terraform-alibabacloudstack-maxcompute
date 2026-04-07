resource "alibabacloudstack_vpc_vpc" "existing" {
  cidr_block = "172.16.0.0/16"
  vpc_name   = "${var.name}-vpc"
}
