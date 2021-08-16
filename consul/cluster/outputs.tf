output "virtual_machine_hostnames" {
  value = module.virtual_machines.names
}
output "virtual_machine_uuids" {
  value = module.virtual_machines.uuids
}
output "default_ip_addresses" {
  value = module.virtual_machines.default_ip_addresses
}

output "internal_dns" {
  value = var.dns_options.register_local_dns
}
output "internal_dns_domain" {
  value = var.dns_options.local_dns_domain
}
output "external_dns" {
  value = var.dns_options.register_external_dns
}
output "external_dns_domain" {
  value = var.dns_options.external_dns_domain
}