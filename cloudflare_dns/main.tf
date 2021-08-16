data "cloudflare_zones" "zones" {
  filter {
    name = var.zone_domain
  }
}

resource "cloudflare_record" "records" {
  count = length(var.hostnames)
  name = var.hostnames[count.index]
  value = var.host_ip_addresses[count.index]
  type = "A"
  zone_id = data.cloudflare_zones.zones.zones[0].id
}