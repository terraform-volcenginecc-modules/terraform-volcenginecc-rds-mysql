# terraform-volcenginecc-rds-mysql

## Overview

Terraform module for managing Volcengine RDS MYSQL resources with the `volcenginecc` provider. The caller owns provider authentication, region configuration, and external resources passed by ID.

## Usage

```hcl
module "rds_mysql" {
  source  = "terraform-volcenginecc-modules/rds-mysql/volcenginecc"
  version = "~> 1.0"

  # Set the required module inputs for your environment.
}
```

## Requirements

| Name | Version |
|---|---|
| Terraform | `>= 1.5.7` |
| OpenTofu | `>= 1.11.8` |

## Providers

| Name | Source |
|---|---|
| `volcenginecc` | `volcengine/volcenginecc` |

## Resources

| Name | Description |
|---|---|
| `volcenginecc_rdsmysql_parameter_template` | Module-defined volcenginecc_rdsmysql_parameter_template. |
| `volcenginecc_rdsmysql_allow_list` | Module-defined volcenginecc_rdsmysql_allow_list. |
| `volcenginecc_rdsmysql_instance` | Module-defined volcenginecc_rdsmysql_instance. |
| `volcenginecc_rdsmysql_database` | Module-defined volcenginecc_rdsmysql_database. |
| `volcenginecc_rdsmysql_db_account` | Module-defined volcenginecc_rdsmysql_db_account. |
| `volcenginecc_rdsmysql_backup` | Module-defined volcenginecc_rdsmysql_backup. |

## Inputs

| Name | Description |
|---|---|
| `instance_name` | Module-defined instance_name. |
| `vpc_id` | Module-defined vpc_id. |
| `subnet_id` | Module-defined subnet_id. |
| `db_engine_version` | Module-defined db_engine_version. |
| `engine_type` | Module-defined engine_type. |
| `instance_type` | Module-defined instance_type. |
| `nodes` | Module-defined nodes. |
| `storage_type` | Module-defined storage_type. |
| `storage_space_gb` | Module-defined storage_space_gb. |
| `charge_detail` | Module-defined charge_detail. |
| `project_name` | Module-defined project_name. |
| `deletion_protection` | Module-defined deletion_protection. |
| `lower_case_table_names` | Module-defined lower_case_table_names. |
| `db_time_zone` | Module-defined db_time_zone. |
| `sync_mode` | Module-defined sync_mode. |
| `port` | Module-defined port. |
| `maintenance_window` | Module-defined maintenance_window. |
| `auto_storage_scaling_config` | Module-defined auto_storage_scaling_config. |
| `backup_policy` | Module-defined backup_policy. |
| `db_param_group_id` | Module-defined db_param_group_id. |
| `parameter_template` | Module-defined parameter_template. |
| `super_account_name` | Module-defined super_account_name. |
| `super_account_password` | Module-defined super_account_password. |
| `tags` | Module-defined tags. |
| `allow_list_ids` | Module-defined allow_list_ids. |
| `allow_lists` | Module-defined allow_lists. |
| `databases` | Module-defined databases. |
| `accounts` | Module-defined accounts. |
| `account_passwords` | Module-defined account_passwords. |
| `manual_backups` | Module-defined manual_backups. |

## Outputs

| Name | Description |
|---|---|
| `instance_id` | Module-defined instance_id. |
| `instance_name` | Module-defined instance_name. |
| `private_addresses` | Module-defined private_addresses. |
| `allow_list_ids` | Module-defined allow_list_ids. |
| `database_ids` | Module-defined database_ids. |
| `account_ids` | Module-defined account_ids. |
| `parameter_template_id` | Module-defined parameter_template_id. |

## Examples

- `basic`: independently runnable basic configuration.
- `complete`: independently runnable complete configuration.

## Notes

- Configure credentials using supported provider mechanisms; do not put access keys in module files.
- Review replacement behavior and provider constraints before applying changes.
- Run `terraform plan` after apply and confirm that the second plan has no changes.
