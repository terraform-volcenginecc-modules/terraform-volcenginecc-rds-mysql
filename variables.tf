variable "instance_name" {
  type        = string
  description = "Name of the RDS MySQL instance."
}

variable "vpc_id" {
  type        = string
  description = "Existing VPC ID. The module does not manage the VPC."
}

variable "subnet_id" {
  type        = string
  description = "Existing database subnet ID. Changing it replaces the instance."
}

variable "db_engine_version" {
  type        = string
  description = "MySQL engine version."

  validation {
    condition     = contains(["MySQL_5_7", "MySQL_8_0"], var.db_engine_version)
    error_message = "db_engine_version must be MySQL_5_7 or MySQL_8_0."
  }
}

variable "engine_type" {
  type        = string
  description = "Database storage engine."
  default     = null

  validation {
    condition     = var.engine_type == null ? true : contains(["InnoDB", "RocksDB"], var.engine_type)
    error_message = "engine_type must be InnoDB or RocksDB when set."
  }
}

variable "instance_type" {
  type        = string
  description = "Topology: SingleNode, DoubleNode, or MultiNode. Changing it replaces the instance."
  default     = "DoubleNode"

  validation {
    condition     = contains(["SingleNode", "DoubleNode", "MultiNode"], var.instance_type)
    error_message = "instance_type must be SingleNode, DoubleNode, or MultiNode."
  }
}

variable "nodes" {
  type = set(object({
    zone_id   = string
    node_spec = string
    node_type = string
  }))
  description = "Node topology. Each item must fully specify zone_id, node_spec, and node_type; changes replace the instance."

  validation {
    condition     = alltrue([for node in var.nodes : contains(["Primary", "Secondary", "ReadOnly"], node.node_type)])
    error_message = "Each node_type must be Primary, Secondary, or ReadOnly."
  }
}

variable "storage_type" {
  type        = string
  description = "Storage type. Changing it replaces the instance."

  validation {
    condition     = contains(["LocalSSD", "CloudESSD_FlexPL", "CloudESSD_PL0"], var.storage_type)
    error_message = "storage_type must be LocalSSD, CloudESSD_FlexPL, or CloudESSD_PL0."
  }
}

variable "storage_space_gb" {
  type        = number
  description = "Purchased storage capacity in GB. Changing it replaces the instance."

  validation {
    condition     = var.storage_space_gb > 0
    error_message = "storage_space_gb must be greater than zero."
  }
}

variable "charge_detail" {
  type = object({
    charge_type = string
    auto_renew  = optional(bool)
    number      = optional(number)
    period      = optional(number)
    period_unit = optional(string)
  })
  description = "Billing configuration."

  validation {
    condition     = contains(["PrePaid", "PostPaid"], var.charge_detail.charge_type)
    error_message = "charge_detail.charge_type must be PrePaid or PostPaid."
  }
}

variable "project_name" {
  type        = string
  description = "Volcengine project name."
  default     = null
}

variable "deletion_protection" {
  type        = string
  description = "Whether to prevent instance deletion."
  default     = "Enabled"

  validation {
    condition     = contains(["Enabled", "Disabled"], var.deletion_protection)
    error_message = "deletion_protection must be Enabled or Disabled."
  }
}

variable "lower_case_table_names" {
  type        = string
  description = "Whether table names are case-insensitive."
  default     = null
}

variable "db_time_zone" {
  type        = string
  description = "Database time zone."
  default     = null
}

variable "sync_mode" {
  type        = string
  description = "Replication synchronization mode."
  default     = null

  validation {
    condition     = var.sync_mode == null ? true : contains(["SemiSync", "Async"], var.sync_mode)
    error_message = "sync_mode must be SemiSync or Async when set."
  }
}

variable "port" {
  type        = number
  description = "Private endpoint port."
  default     = null

  validation {
    condition     = var.port == null ? true : (var.port >= 1000 && var.port <= 65534)
    error_message = "port must be between 1000 and 65534."
  }
}

variable "maintenance_window" {
  type = object({
    day_kind         = optional(string)
    day_of_week      = optional(set(string))
    maintenance_time = optional(string)
  })
  description = "Optional instance maintenance window."
  default     = null
}

variable "auto_storage_scaling_config" {
  type = object({
    enable_storage_auto_scale = optional(bool)
    scaling_detect_node       = optional(string)
    storage_threshold         = optional(number)
    storage_upper_bound       = optional(number)
  })
  description = "Optional storage auto-scaling configuration."
  default     = null
}

variable "backup_policy" {
  type = object({
    backup_policy_base = optional(object({
      binlog_backup_enabled                        = optional(bool)
      data_backup_retention_day                    = optional(number)
      data_full_backup_periods                     = optional(set(string))
      data_full_backup_time                        = optional(string)
      high_frequency_snapshot_backup_enable        = optional(bool)
      high_frequency_snapshot_backup_second_period = optional(number)
      log_backup_retention_day                     = optional(number)
      retention_policy_synced                      = optional(bool)
    }))
    cross_backup_policy = optional(object({
      backup_enabled      = optional(bool)
      cross_backup_region = optional(string)
      log_backup_enabled  = optional(bool)
      retention           = optional(number)
    }))
  })
  description = "Optional automatic backup policy."
  default     = null
}

variable "db_param_group_id" {
  type        = string
  description = "Existing parameter template ID. Mutually exclusive with parameter_template."
  default     = null

}

variable "parameter_template" {
  type = object({
    name        = string
    parameters  = set(object({ name = string, running_value = string }))
    description = optional(string)
    engine_type = optional(string)
  })
  description = "Optional parameter template managed by this module."
  default     = null
}

variable "super_account_name" {
  type        = string
  description = "Optional initial high-privilege account name."
  default     = null
}

variable "super_account_password" {
  type        = string
  description = "Optional initial high-privilege account password."
  default     = null
  sensitive   = true
}

variable "tags" {
  type        = set(object({ key = string, value = string }))
  description = "Tags applied to the instance."
  default     = []
}

variable "allow_list_ids" {
  type        = set(string)
  description = "Existing allowlist IDs to bind to the instance."
  default     = []
}

variable "allow_lists" {
  type = map(object({
    name               = optional(string)
    category           = optional(string)
    description        = optional(string)
    ip_addresses       = optional(set(string), [])
    security_group_ids = optional(set(string), [])
    security_group_bind_infos = optional(set(object({
      bind_mode           = string
      security_group_id   = string
      security_group_name = optional(string)
    })), [])
  }))
  description = "Allowlists managed by stable logical key. Security groups must already exist."
  default     = {}

  validation {
    condition = alltrue([
      for allow_list in values(var.allow_lists) :
      !(length(allow_list.security_group_ids) > 0 && length(allow_list.security_group_bind_infos) > 0)
    ])
    error_message = "An allowlist cannot set both security_group_ids and security_group_bind_infos."
  }
}

variable "databases" {
  type = map(object({
    name               = string
    character_set_name = optional(string)
    description        = optional(string)
  }))
  description = "Databases managed by stable logical key. Database privileges are owned by accounts, not database resources."
  default     = {}
}

variable "accounts" {
  type = map(object({
    name        = string
    type        = optional(string, "Normal")
    description = optional(string)
    host        = optional(string, "%")
    privileges = optional(set(object({
      account_privilege        = string
      account_privilege_detail = optional(set(string))
      db_name                  = string
    })), [])
    table_column_privileges = optional(set(object({
      db_name = string
      column_privileges = optional(set(object({
        account_privilege_detail = set(string)
        column_name              = string
        table_name               = string
      })), [])
      table_privileges = optional(set(object({
        account_privilege_detail = set(string)
        table_name               = string
      })), [])
    })), [])
  }))
  description = "Accounts managed by stable logical key. Supply passwords through account_passwords."
  default     = {}
}

variable "account_passwords" {
  type        = map(string)
  description = "Sensitive database account passwords keyed identically to accounts. Passwords are stored in Terraform state by the provider."
  default     = {}
  sensitive   = true

}

variable "manual_backups" {
  type = map(object({
    method = optional(string)
    type   = optional(string)
    meta = optional(set(object({
      database = string
      tables   = set(string)
    })), [])
  }))
  description = "On-demand backups managed by stable logical key. Removing a key deletes the managed backup resource."
  default     = {}
}
