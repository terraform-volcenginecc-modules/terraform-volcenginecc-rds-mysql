output "instance_id" {
  value       = module.mysql.instance_id
  description = "Created single-node MySQL instance ID."
}

output "endpoint" {
  value       = module.mysql.private_addresses
  description = "Provider-returned private connection endpoints."
}
