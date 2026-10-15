# COMPLETE RDS MYSQL Example

## Overview

Runnable complete configuration for the RDS MYSQL module. It configures the provider from input variables and calls the published Registry module.

## Usage

```shell
terraform init
terraform plan
terraform apply
terraform plan
terraform destroy
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
| `terraform-volcenginecc-modules/rds-mysql/volcenginecc` | Published RDS MYSQL module. |

## Inputs

| Name | Description |
|---|---|
| `instance_name` | Module-defined instance_name. |
| `vpc_id` | Module-defined vpc_id. |
| `subnet_id` | Module-defined subnet_id. |
| `primary_zone_id` | Module-defined primary_zone_id. |
| `secondary_zone_id` | Module-defined secondary_zone_id. |
| `node_spec` | Module-defined node_spec. |
| `application_security_group_id` | Module-defined application_security_group_id. |
| `application_cidrs` | Module-defined application_cidrs. |
| `database_name` | Module-defined database_name. |
| `account_name` | Module-defined account_name. |
| `account_password` | Module-defined account_password. |
| `project_name` | Module-defined project_name. |
| `deletion_protection` | Module-defined deletion_protection. |

## Outputs

| Name | Description |
|---|---|
| `instance_id` | Module-defined instance_id. |
| `database_ids` | Module-defined database_ids. |
| `account_ids` | Module-defined account_ids. |
| `endpoint` | Module-defined endpoint. |

## Examples

This directory is the complete example.

## Notes

- Supply credentials through supported provider configuration, never in source files.
- The final plan after apply must report no changes before the configuration is accepted.
