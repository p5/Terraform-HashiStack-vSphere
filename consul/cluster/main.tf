module "virtual_machines" {
  source = "git::github.com/p5/Terraform-HashiStack-vSphere.git//vsphere/vm"
  instances = var.instances

  datacenter = var.datacenter

  resource_pool = var.resource_pool
  datastore = var.datastore
  folder = var.folder

  template = var.template

  name = var.name_start
  name_format = var.name_format

  networks = var.networks
  domain = var.domain

  resources = var.resources

  gateway = var.gateway
  dns_servers = var.dns_servers
}

module "local_dns_a_records" {
  source = "git::github.com/p5/Terraform-HashiStack-vSphere.git//local_dns/a_records"
  count = var.dns_options.register_local_dns ? 1 : 0

  depends_on = [
    module.virtual_machines
  ]

  host_ip_addresses = module.virtual_machines.default_ip_addresses
  zone_domain = format("%s.", var.dns_options.local_dns_domain)
  hostnames = module.virtual_machines.names
}

module "external_dns_a_records" {
  source = "git::github.com/p5/Terraform-HashiStack-vSphere.git//cloudflare_dns"
  count = var.dns_options.register_external_dns ? 1 : 0

  depends_on = [
    module.virtual_machines.names,
    module.virtual_machines.default_ip_addresses
  ]
  hostnames = module.virtual_machines.names
  host_ip_addresses = module.virtual_machines.default_ip_addresses

  zone_domain = var.dns_options.external_dns_domain
}
