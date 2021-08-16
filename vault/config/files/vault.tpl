# Full configuration options can be found at https://www.vaultproject.io/docs/configuration

ui = ${ui_enabled}

disable_mlock = true

storage "consul" {
  address = "127.0.0.1:8500"
  path    = "vault"
}

# HTTPS listener
listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_cert_file = "/etc/ssl/vault.crt"
  tls_key_file  = "/etc/ssl/vault.key"
}
