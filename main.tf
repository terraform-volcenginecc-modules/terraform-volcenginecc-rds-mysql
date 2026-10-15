locals {
  managed_allow_list_ids = toset([
    for allow_list in volcenginecc_rdsmysql_allow_list.this : allow_list.allow_list_id
  ])
  allow_list_ids = setunion(var.allow_list_ids, local.managed_allow_list_ids)

  parameter_template_id = var.parameter_template == null ? var.db_param_group_id : volcenginecc_rdsmysql_parameter_template.this[0].template_id
}

resource "volcenginecc_rdsmysql_parameter_template" "this" {
  count = var.parameter_template == null ? 0 : 1

  template_name         = var.parameter_template.name
  template_params       = var.parameter_template.parameters
  engine_type           = var.parameter_template.engine_type
  project_name          = var.project_name
  template_desc         = var.parameter_template.description
  template_type         = "Mysql"
  template_type_version = var.db_engine_version
}

resource "volcenginecc_rdsmysql_allow_list" "this" {
  for_each = var.allow_lists

  allow_list_category       = each.value.category
  allow_list_desc           = each.value.description
  allow_list_name           = each.value.name
  allow_list_type           = "IPv4"
  project_name              = var.project_name
  security_group_bind_infos = length(each.value.security_group_bind_infos) == 0 ? null : each.value.security_group_bind_infos
  security_group_ids        = length(each.value.security_group_ids) == 0 ? null : each.value.security_group_ids
  user_allow_list           = each.value.ip_addresses
}

resource "volcenginecc_rdsmysql_instance" "this" {
  db_engine_version           = var.db_engine_version
  nodes                       = var.nodes
  storage_space               = var.storage_space_gb
  storage_type                = var.storage_type
  subnet_id                   = var.subnet_id
  vpc_id                      = var.vpc_id
  charge_detail               = var.charge_detail
  allow_list_ids              = local.allow_list_ids
  auto_storage_scaling_config = var.auto_storage_scaling_config
  backup_policy               = var.backup_policy
  db_param_group_id           = local.parameter_template_id
  db_time_zone                = var.db_time_zone
  deletion_protection         = var.deletion_protection
  engine_type                 = var.engine_type
  instance_name               = var.instance_name
  instance_type               = var.instance_type
  lower_case_table_names      = var.lower_case_table_names
  maintenance_window          = var.maintenance_window
  port                        = var.port
  project_name                = var.project_name
  super_account_name          = var.super_account_name
  super_account_password      = var.super_account_password
  sync_mode                   = var.sync_mode
  tags                        = length(var.tags) == 0 ? null : var.tags

  # The provider returns Optional+Computed billing fields (for example,
  # number and temporary-modification timestamps) that are not supplied by
  # callers, which otherwise produces a perpetual PostPaid update.
  lifecycle {
    ignore_changes = [charge_detail]

    precondition {
      condition     = var.db_param_group_id == null || var.parameter_template == null
      error_message = "Set either db_param_group_id or parameter_template, not both."
    }
  }
}

resource "volcenginecc_rdsmysql_database" "this" {
  for_each = var.databases

  instance_id        = volcenginecc_rdsmysql_instance.this.instance_id
  name               = each.value.name
  character_set_name = each.value.character_set_name
  description        = each.value.description
}

resource "volcenginecc_rdsmysql_db_account" "this" {
  for_each = var.accounts

  account_name            = each.value.name
  account_password        = var.account_passwords[each.key]
  account_type            = each.value.type
  instance_id             = volcenginecc_rdsmysql_instance.this.instance_id
  account_desc            = each.value.description
  account_privileges      = each.value.privileges
  host                    = each.value.host
  table_column_privileges = length(each.value.table_column_privileges) == 0 ? null : each.value.table_column_privileges

  depends_on = [volcenginecc_rdsmysql_database.this]

  lifecycle {
    precondition {
      condition     = contains(keys(var.account_passwords), each.key)
      error_message = "account_passwords must contain a password for every accounts key."
    }
  }
}

resource "volcenginecc_rdsmysql_backup" "this" {
  for_each = var.manual_backups

  instance_id   = volcenginecc_rdsmysql_instance.this.instance_id
  backup_meta   = each.value.meta
  backup_method = each.value.method
  backup_type   = each.value.type
}
