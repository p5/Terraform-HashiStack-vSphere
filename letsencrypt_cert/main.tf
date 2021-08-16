resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "registration" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = var.email_address
}

resource "acme_certificate" "certificate" {
  account_key_pem = acme_registration.registration.account_key_pem
  common_name = var.domain
  subject_alternative_names = var.alternate_names
  dns_challenge {
    provider = "cloudflare"
    config = {
      CLOUDFLARE_EMAIL = var.email_address
      CLOUDFLARE_API_KEY = var.api_key
    }
  }
}