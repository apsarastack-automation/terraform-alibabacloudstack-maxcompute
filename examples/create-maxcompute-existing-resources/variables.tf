variable "project_name" {
  description = "The name of the MaxCompute project to create."
  type        = string
}

variable "cu_id" {
  description = "The ID of an existing MaxCompute CU."
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
