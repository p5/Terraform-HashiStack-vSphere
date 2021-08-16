resource "null_resource" "consul_configuration" {
  count = length(var.ssh_hosts)

  triggers = {
    #consul_options = templatefile("/home/sturlar/Documents/IaC/Terraform/Modules/consul/config/files/consul.tpl",
    consul_options = templatefile("${path.module}/files/consul.tpl",
    {
      is_server = var.consul_options.is_server,
      datacenter = var.consul_options.datacenter,
      ui = var.consul_options.ui,
      connect = var.consul_options.connect,
      bootstrap_expect = length(var.consul_retry_join),
      encryption_key = var.consul_options.encryption_key,
      bind_addr = var.consul_options.bind_addr,
      enable_ssl = var.consul_options.ssl,
      retry_join_nodes = "[\"${join("\", \"", var.consul_retry_join)}\"]",
    })
  }

  connection {
    host = var.ssh_hosts[count.index]
    user = var.ssh_credentials.username
    password = var.ssh_credentials.password
  }

  provisioner "file" {
    #content = templatefile("/home/sturlar/Documents/IaC/Terraform/Modules/consul/config/files/consul.tpl",
    consul_options = templatefile("${path.module}/files/consul.tpl",
    {
      is_server = var.consul_options.is_server,
      datacenter = var.consul_options.datacenter,
      ui = var.consul_options.ui,
      connect = var.consul_options.connect,
      bootstrap_expect = length(var.consul_retry_join),
      encryption_key = var.consul_options.encryption_key,
      bind_addr = var.consul_options.bind_addr,
      enable_ssl = var.consul_options.ssl,
      retry_join_nodes = "[\"${join("\", \"", var.consul_retry_join)}\"]",
    })
    destination = "/tmp/consul.hcl"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/consul.hcl /etc/consul.d/consul.hcl",
      "sudo systemctl restart consul"
    ]
  }
}

resource "null_resource" "consul_certificate" {
  depends_on = [
    null_resource.consul_configuration
  ]

  triggers = {
    certificate = var.tls_certificates.cert
  }

  count = var.consul_options.ssl ? length(var.ssh_hosts) : 0

  connection {
    host = var.ssh_hosts[count.index]
    user = var.ssh_credentials.username
    password = var.ssh_credentials.password
  }

  provisioner "file" {
    content = var.tls_certificates.cert
    destination = "/tmp/consul-crt-public.crt"
  }
  provisioner "file" {
    content = var.tls_certificates.key
    destination = "/tmp/consul-crt-private.key"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/consul-crt-public.crt /etc/ssl/consul.crt",
      "sudo mv /tmp/consul-crt-private.key /etc/ssl/consul.key",
      "sudo systemctl restart consul"
    ]
  }
}

