output "hostnames" {
  value = cloudflare_record.records.*.hostname
}