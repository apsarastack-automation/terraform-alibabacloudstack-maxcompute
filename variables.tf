variable "project_name" {
  description = "The name of the MaxCompute project."
  type        = string
}

variable "user_id" {
  description = "The ID of the MaxCompute user."
  type        = string
  default     = ""
}

variable "user_pk" {
  description = "The PK of the MaxCompute user."
  type        = string
  default     = ""
}

variable "create_cu" {
  description = "Whether to create a new MaxCompute CU."
  type        = bool
  default     = true
}

variable "cu_name" {
  description = "The name of the MaxCompute CU."
  type        = string
  default     = ""
}

variable "cu_num" {
  description = "The number of CUs for the MaxCompute CU."
  type        = number
  default     = 2
}

variable "cluster_name" {
  description = "The cluster name for the MaxCompute CU."
  type        = string
  default     = ""
}

variable "disk_size" {
  description = "The disk size of the MaxCompute project."
  type        = string
  default     = "50"
}

variable "enable_external_table" {
  description = "Whether to enable external table (joint computing)."
  type        = bool
  default     = true
}

variable "attach_vpc" {
  description = "Whether to attach a VPC to the MaxCompute project."
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "The ID of an existing VPC to attach (when attach_vpc=true)."
  type        = string
  default     = ""
}

variable "core_arch" {
  description = "The core architecture of the MaxCompute project."
  type        = string
  default     = ""
}

variable "cpu_type" {
  description = "The CPU type of the MaxCompute project."
  type        = string
  default     = ""
}
