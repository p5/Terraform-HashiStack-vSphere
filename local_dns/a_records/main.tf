resource "dns_a_record_set" "dns_a_records" {
  count = length(var.hostnames)

  addresses = [var.host_ip_addresses[count.index]]
  zone = var.zone_domain
  name = var.hostnames[count.index]
}