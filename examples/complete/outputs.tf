output "instance_id" {
  value       = module.mysql.instance_id
  description = "Created high-availability MySQL instance ID."
}

output "database_ids" {
  value       = module.mysql.database_ids
  description = "Managed application database IDs."
}

output "account_ids" {
  value       = module.mysql.account_ids
  description = "Managed application database account IDs."
}

output "endpoint" {
  value       = module.mysql.private_addresses
  description = "Provider-returned private connection endpoints."
}
