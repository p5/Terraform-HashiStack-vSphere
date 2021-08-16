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

variable "vault_options" {
  type = object({
    ui = bool
  })
  default = {
    ui = true
  }
}
variable "tls_certificates" {
  type = object({
    cert = string
    key = string
  })
  sensitive = true
}