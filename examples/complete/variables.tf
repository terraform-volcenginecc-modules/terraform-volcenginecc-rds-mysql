variable "instance_name" {
  type        = string
  description = "Name of the production high-availability MySQL instance."
  default     = "example-mysql-production"
}

variable "vpc_id" {
  type        = string
  description = "Existing VPC ID."
}

variable "subnet_id" {
  type        = string
  description = "Existing database subnet ID."
}

variable "primary_zone_id" {
  type        = string
  description = "Available zone ID for the primary and read-only nodes."
}

variable "secondary_zone_id" {
  type        = string
  description = "Available zone ID for the secondary node."
}

variable "node_spec" {
  type        = string
  description = "MySQL node specification available in both selected zones."
}

variable "application_security_group_id" {
  type        = string
  description = "Optional existing application security group ID bound to the RDS allowlist."
  default     = null
}

variable "application_cidrs" {
  type        = set(string)
  description = "Private application CIDRs permitted by the RDS allowlist."
}

variable "database_name" {
  type        = string
  description = "Application database name."
  default     = "appdb"
}

variable "account_name" {
  type        = string
  description = "Application database account name."
  default     = "appuser"
}

variable "account_password" {
  type        = string
  description = "Application database account password."
  sensitive   = true
}

variable "project_name" {
  type        = string
  description = "Volcengine project name."
  default     = null
}

variable "deletion_protection" {
  type        = string
  description = "Whether to prevent instance deletion. Keep Enabled outside disposable validation."
  default     = "Enabled"

  validation {
    condition     = contains(["Enabled", "Disabled"], var.deletion_protection)
    error_message = "deletion_protection must be Enabled or Disabled."
  }
}
