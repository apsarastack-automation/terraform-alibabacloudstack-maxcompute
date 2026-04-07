output "vpc_id" {
  description = "The ID of the created VPC."
  value       = alibabacloudstack_vpc_vpc.existing.id
}
