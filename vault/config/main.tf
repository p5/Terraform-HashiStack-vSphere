locals {
  vault_config_file = templatefile("${path.module}/files/vault.tpl",
  {
      ui_enabled = var.vault_options.ui
  })
}

resource "null_resource" "vault_configuration" {
  count = length(var.ssh_hosts)

  triggers = {
    vault_options = jsonencode(var.vault_options)
  }

  connection {
    host = var.ssh_hosts[count.index]
    user = var.ssh_credentials.username
    password = var.ssh_credentials.password
  }

  provisioner "file" {
    content = templatefile("${path.module}/files/vault.tpl",
    {
      ui_enabled = var.vault_options.ui
    })
    destination = "/tmp/vault.hcl"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/vault.hcl /etc/vault.d/vault.hcl",
      "sudo systemctl restart vault"
    ]
  }
}

resource "null_resource" "vault_certificate" {
  depends_on = [
    null_resource.vault_configuration
  ]

  count = length(var.ssh_hosts)

  connection {
    host = var.ssh_hosts[count.index]
    user = var.ssh_credentials.username
    password = var.ssh_credentials.password
  }

  provisioner "file" {
    content = var.tls_certificates.cert
    destination = "/tmp/vault-crt-public.crt"
  }
  provisioner "file" {
    content = var.tls_certificates.key
    destination = "/tmp/vault-crt-private.key"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/vault-crt-public.crt /etc/ssl/vault.crt",
      "sudo mv /tmp/vault-crt-private.key /etc/ssl/vault.key",
      "sudo systemctl restart vault"
    ]
  }
}

