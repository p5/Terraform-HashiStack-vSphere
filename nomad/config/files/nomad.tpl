# Full configuration options can be found at https://www.nomadproject.io/docs/configuration

datacenter = "${datacenter}"

data_dir = "/opt/nomad/data"
bind_addr = "0.0.0.0"

%{ if is_server }

server {
  enabled = true
  bootstrap_expect = ${bootstrap_expect}
  encrypt = "${encryption_key}"

  server_join {
    retry_join = ${retry_join_nodes}
    retry_max = 6
    retry_interval = "15s"
  }
}

autopilot {
    cleanup_dead_servers      = true
    last_contact_threshold    = "200ms"
    max_trailing_logs         = 250
    server_stabilization_time = "10s"
    enable_redundancy_zones   = false
    disable_upgrade_migration = false
    enable_custom_upgrades    = false
  }
%{ endif }

tls {
  http = true
  %{ if enable_ssl }
  cert_file = "/etc/ssl/nomad.crt"
  key_file = "/etc/ssl/nomad.key"
  %{ endif }
}

%{ if is_client }
client {
  enabled = true
}
%{ endif }