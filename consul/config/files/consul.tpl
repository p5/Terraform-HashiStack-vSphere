datacenter = "${datacenter}"

data_dir = "/opt/consul"

client_addr = "0.0.0.0"
bind_addr = "${bind_addr}"

encrypt = "${encryption_key}"

retry_join = ${retry_join_nodes}

%{ if is_server }
ui = ${ui}
server = true
bootstrap_expect = ${bootstrap_expect}
%{ if enable_ssl }
cert_file = "/etc/ssl/consul.crt"
key_file = "/etc/ssl/consul.key"
%{ endif }

autopilot {
    cleanup_dead_servers = true
    last_contact_threshold = "200ms"
    max_trailing_logs = 250
}

%{ endif }

ports {
    %{ if enable_ssl }
    https = 8501
    %{ endif }
    grpc = 8502
}

connect {
    enabled = ${connect}
}

enable_script_checks = true

