resource "dns_cname_record" "dns_cname_record" {
  zone = var.zone_domain
  name = var.name
  cname = var.destination
}