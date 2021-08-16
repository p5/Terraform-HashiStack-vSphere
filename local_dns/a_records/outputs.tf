output "zone" {
  value = dns_a_record_set.dns_a_records[0].zone
}
output "fqdn" {
  value = formatlist("%s.%s", dns_a_record_set.dns_a_records.*.name, dns_a_record_set.dns_a_records[0].zone)
}
output "addresses" {
  value = dns_a_record_set.dns_a_records.*.addresses
}