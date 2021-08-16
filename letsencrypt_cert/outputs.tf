output "tls_public_key_pem" {
  value = acme_certificate.certificate.certificate_pem
}
output "tls_private_key_pem" {
  value = acme_certificate.certificate.private_key_pem
  sensitive = true
}
output "common_name" {
  value = acme_certificate.certificate.common_name
}
output "subject_alternative_names" {
  value = acme_certificate.certificate.subject_alternative_names
}
