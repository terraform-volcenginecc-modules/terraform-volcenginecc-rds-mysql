# terraform-volcenginecc-rds-mysql

## 概述

基于 `volcenginecc` Provider 管理火山引擎 RDS MYSQL 资源的 Terraform 模块。调用方负责 Provider 凭据、地域配置，以及通过 ID 传入的外部资源。

## 用法

```hcl
module "rds_mysql" {
  source  = "terraform-volcenginecc-modules/rds-mysql/volcenginecc"
  version = "~> 1.0"

  # 请设置适用于当前环境的必填模块输入。
}
```

## 依赖要求

| 名称 | 版本 |
|---|---|
| Terraform | `>= 1.5.7` |
| OpenTofu | `>= 1.11.8` |

## Providers

| 名称 | 来源 |
|---|---|
| `volcenginecc` | `volcengine/volcenginecc` |

## 资源

| 名称 | 说明 |
|---|---|
| `volcenginecc_rdsmysql_parameter_template` | 模块定义的 volcenginecc_rdsmysql_parameter_template。 |
| `volcenginecc_rdsmysql_allow_list` | 模块定义的 volcenginecc_rdsmysql_allow_list。 |
| `volcenginecc_rdsmysql_instance` | 模块定义的 volcenginecc_rdsmysql_instance。 |
| `volcenginecc_rdsmysql_database` | 模块定义的 volcenginecc_rdsmysql_database。 |
| `volcenginecc_rdsmysql_db_account` | 模块定义的 volcenginecc_rdsmysql_db_account。 |
| `volcenginecc_rdsmysql_backup` | 模块定义的 volcenginecc_rdsmysql_backup。 |

## 输入

| 名称 | 说明 |
|---|---|
| `instance_name` | 模块定义的 instance_name。 |
| `vpc_id` | 模块定义的 vpc_id。 |
| `subnet_id` | 模块定义的 subnet_id。 |
| `db_engine_version` | 模块定义的 db_engine_version。 |
| `engine_type` | 模块定义的 engine_type。 |
| `instance_type` | 模块定义的 instance_type。 |
| `nodes` | 模块定义的 nodes。 |
| `storage_type` | 模块定义的 storage_type。 |
| `storage_space_gb` | 模块定义的 storage_space_gb。 |
| `charge_detail` | 模块定义的 charge_detail。 |
| `project_name` | 模块定义的 project_name。 |
| `deletion_protection` | 模块定义的 deletion_protection。 |
| `lower_case_table_names` | 模块定义的 lower_case_table_names。 |
| `db_time_zone` | 模块定义的 db_time_zone。 |
| `sync_mode` | 模块定义的 sync_mode。 |
| `port` | 模块定义的 port。 |
| `maintenance_window` | 模块定义的 maintenance_window。 |
| `auto_storage_scaling_config` | 模块定义的 auto_storage_scaling_config。 |
| `backup_policy` | 模块定义的 backup_policy。 |
| `db_param_group_id` | 模块定义的 db_param_group_id。 |
| `parameter_template` | 模块定义的 parameter_template。 |
| `super_account_name` | 模块定义的 super_account_name。 |
| `super_account_password` | 模块定义的 super_account_password。 |
| `tags` | 模块定义的 tags。 |
| `allow_list_ids` | 模块定义的 allow_list_ids。 |
| `allow_lists` | 模块定义的 allow_lists。 |
| `databases` | 模块定义的 databases。 |
| `accounts` | 模块定义的 accounts。 |
| `account_passwords` | 模块定义的 account_passwords。 |
| `manual_backups` | 模块定义的 manual_backups。 |

## 输出

| 名称 | 说明 |
|---|---|
| `instance_id` | 模块定义的 instance_id。 |
| `instance_name` | 模块定义的 instance_name。 |
| `private_addresses` | 模块定义的 private_addresses。 |
| `allow_list_ids` | 模块定义的 allow_list_ids。 |
| `database_ids` | 模块定义的 database_ids。 |
| `account_ids` | 模块定义的 account_ids。 |
| `parameter_template_id` | 模块定义的 parameter_template_id。 |

## 示例

- `basic`：可独立运行的 basic 配置。
- `complete`：可独立运行的 complete 配置。

## 说明

- 请通过 Provider 支持的方式配置凭据，不要将访问密钥写入模块文件。
- 执行变更前请审阅替换行为及 Provider 限制。
- apply 后请再次执行 `terraform plan`，并确认第二次 plan 无变更。
