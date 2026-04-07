variable "name" {
  description = "The name of the resource."
  type        = string
}

variable "cu_num" {
  description = "The number of CUs for the MaxCompute CU."
  type        = number
  default     = 2
}