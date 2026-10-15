variable "instance_name" {
  type        = string
  description = "Name of the single-node test instance."
  default     = "example-mysql-basic"
}

variable "vpc_id" {
  type        = string
  description = "Existing VPC ID."
}

variable "subnet_id" {
  type        = string
  description = "Existing database subnet ID."
}

variable "zone_id" {
  type        = string
  description = "Available zone ID for the primary node."
}

variable "node_spec" {
  type        = string
  description = "MySQL node specification available in the selected zone."
}

variable "project_name" {
  type        = string
  description = "Volcengine project name."
  default     = null
}
