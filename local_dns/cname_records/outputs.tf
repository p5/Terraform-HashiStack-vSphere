output "zone" {
  value = dns_cname_record.dns_cname_record.zone
}
output "cname_record" {
  value = format("%s.%s", dns_cname_record.dns_cname_record.name, dns_cname_record.dns_cname_record.zone)
}
output "cname_destination" {
  value = dns_cname_record.dns_cname_record.cname
}