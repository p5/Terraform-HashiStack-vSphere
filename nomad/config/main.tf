resource "null_resource" "nomad_configuration" {
  count = length(var.ssh_hosts)

  triggers = {
    nomad_config = templatefile("/home/sturlar/Documents/IaC/Terraform/Modules/nomad/config/files/nomad.tpl",
    {
      is_server = var.nomad_options.is_server,
      datacenter = var.nomad_options.datacenter,
      is_client = var.nomad_options.is_client,
      enable_ssl = var.nomad_options.ssl,
      bootstrap_expect = length(var.nomad_retry_join),
      encryption_key = var.nomad_options.encryption_key,
      retry_join_nodes = "[\"${join("\", \"", var.nomad_retry_join)}\"]",
    })
  }

  connection {
    host = var.ssh_hosts[count.index]
    user = var.ssh_credentials.username
    password = var.ssh_credentials.password
  }

  provisioner "file" {
    content = templatefile("/home/sturlar/Documents/IaC/Terraform/Modules/nomad/config/files/nomad.tpl",
    {
      is_server = var.nomad_options.is_server,
      datacenter = var.nomad_options.datacenter,
      is_client = var.nomad_options.is_client,
      enable_ssl = var.nomad_options.ssl,
      bootstrap_expect = length(var.nomad_retry_join),
      encryption_key = var.nomad_options.encryption_key,
      retry_join_nodes = "[\"${join("\", \"", var.nomad_retry_join)}\"]",
    })
    destination = "/tmp/nomad.hcl"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/nomad.hcl /etc/nomad.d/nomad.hcl",
      "sudo systemctl restart nomad"
    ]
  }
}

resource "null_resource" "nomad_certificate" {
  depends_on = [
    null_resource.nomad_configuration
  ]

  count = length(var.ssh_hosts)

  connection {
    host = var.ssh_hosts[count.index]
    user = var.ssh_credentials.username
    password = var.ssh_credentials.password
  }

  provisioner "file" {
    content = var.tls_certificates.cert
    destination = "/tmp/nomad-crt-public.crt"
  }
  provisioner "file" {
    content = var.tls_certificates.key
    destination = "/tmp/nomad-crt-private.key"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/nomad-crt-public.crt /etc/ssl/nomad.crt",
      "sudo mv /tmp/nomad-crt-private.key /etc/ssl/nomad.key",
      "sudo systemctl restart nomad"
    ]
  }
}