variable "project_name" {
  description = "The name of the MaxCompute project to create."
  type        = string
}

variable "vpc_id" {
  description = "The ID of an existing VPC to attach."
  type        = string
  default     = ""
}

variable "cu_num" {
  description = "The number of CUs for the MaxCompute CU."
  type        = number
  default     = 2
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
