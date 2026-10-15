# BASIC RDS MYSQL Example

## Overview

Runnable basic configuration for the RDS MYSQL module. It configures the provider from input variables and calls the published Registry module.

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
| `zone_id` | Module-defined zone_id. |
| `node_spec` | Module-defined node_spec. |
| `project_name` | Module-defined project_name. |

## Outputs

| Name | Description |
|---|---|
| `instance_id` | Module-defined instance_id. |
| `endpoint` | Module-defined endpoint. |

## Examples

This directory is the basic example.

## Notes

- Supply credentials through supported provider configuration, never in source files.
- The final plan after apply must report no changes before the configuration is accepted.
