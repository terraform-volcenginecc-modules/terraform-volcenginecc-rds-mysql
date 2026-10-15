output "instance_id" {
  description = "ID of the managed RDS MySQL instance."
  value       = volcenginecc_rdsmysql_instance.this.instance_id
}

output "instance_name" {
  description = "Name of the managed RDS MySQL instance."
  value       = volcenginecc_rdsmysql_instance.this.instance_name
}

output "private_addresses" {
  description = "Provider-returned default endpoint address objects. Treat as computed connection metadata."
  value       = volcenginecc_rdsmysql_instance.this.address_objects
}

output "allow_list_ids" {
  description = "Managed and externally supplied allowlist IDs bound to the instance."
  value       = local.allow_list_ids
}

output "database_ids" {
  description = "Database resource IDs keyed by the caller's stable logical keys."
  value       = { for key, database in volcenginecc_rdsmysql_database.this : key => database.id }
}

output "account_ids" {
  description = "Database account resource IDs keyed by the caller's stable logical keys."
  value       = { for key, account in volcenginecc_rdsmysql_db_account.this : key => account.id }
}

output "parameter_template_id" {
  description = "Managed or externally supplied parameter template ID, if configured."
  value       = local.parameter_template_id
}
