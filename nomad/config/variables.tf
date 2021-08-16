variable "ssh_hosts" {
  default = []
  type = list(string)
}

variable "ssh_credentials" {
  type = object({
    username = string
    password = string
  })
  sensitive = true
}

variable "nomad_options" {
  type = object({
    datacenter = string
    is_client = bool
    is_server = bool
    encryption_key = string
    ssl = bool
  })
}

variable "nomad_retry_join" {
  type = list(string)
  default = []
}
variable "tls_certificates" {
  type = object({
    cert = string
    key = string
  })
  sensitive = true
}