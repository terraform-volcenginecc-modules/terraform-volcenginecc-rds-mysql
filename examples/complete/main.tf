module "mysql" {
  source  = "terraform-volcenginecc-modules/rds-mysql/volcenginecc"
  version = "~> 1.0"

  instance_name     = var.instance_name
  vpc_id            = var.vpc_id
  subnet_id         = var.subnet_id
  db_engine_version = "MySQL_8_0"
  instance_type     = "DoubleNode"
  storage_type      = "CloudESSD_PL0"
  storage_space_gb  = 500
  project_name      = var.project_name

  nodes = [
    {
      zone_id   = var.primary_zone_id
      node_spec = var.node_spec
      node_type = "Primary"
    },
    {
      zone_id   = var.secondary_zone_id
      node_spec = var.node_spec
      node_type = "Secondary"
    },
    {
      zone_id   = var.primary_zone_id
      node_spec = var.node_spec
      node_type = "ReadOnly"
    }
  ]

  charge_detail = {
    charge_type = "PostPaid"
  }

  deletion_protection = var.deletion_protection
  sync_mode           = "SemiSync"
  tags                = [{ key = "environment", value = "production" }]

  backup_policy = {
    backup_policy_base = {
      binlog_backup_enabled                 = true
      data_backup_retention_day             = 14
      data_full_backup_periods              = ["Monday", "Wednesday", "Friday", "Sunday"]
      data_full_backup_time                 = "18:00Z-19:00Z"
      high_frequency_snapshot_backup_enable = false
      log_backup_retention_day              = 14
      retention_policy_synced               = true
    }
  }

  parameter_template = {
    name        = "${var.instance_name}-parameters"
    description = "Production MySQL parameter template"
    parameters = [
      { name = "auto_increment_increment", running_value = "2" },
      { name = "slow_query_log", running_value = "ON" }
    ]
  }

  allow_lists = {
    application = {
      name               = "${var.instance_name}-application"
      description        = "Application database access"
      ip_addresses       = var.application_cidrs
      security_group_ids = var.application_security_group_id == null ? [] : [var.application_security_group_id]
    }
  }

  databases = {
    application = {
      name               = var.database_name
      character_set_name = "utf8mb4"
      description        = "Application primary database"
    }
  }

  accounts = {
    application = {
      name = var.account_name
      host = "%"
      privileges = [
        {
          account_privilege = "ReadWrite"
          db_name           = var.database_name
        },
        {
          account_privilege_detail = ["PROCESS", "REPLICATION CLIENT", "REPLICATION SLAVE"]
          account_privilege        = "Global"
          db_name                  = ""
        }
      ]
    }
  }

  account_passwords = {
    application = var.account_password
  }

  # A manual backup must be created only after the instance has no active
  # service-side backup job, so it is intentionally managed outside this
  # initial instance provisioning example.
  manual_backups = {}
}
