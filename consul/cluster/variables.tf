variable "datacenter" {
  description = "Name of the datacenter you want to deploy the VM to."
  type = string
}
variable "datastore" {
  description = "Datastore to deploy the VM."
  type = string
}
variable "resource_pool" {
  description = "Resource pool that VM will be deployed to."
  type = string
}
variable "networks" {
  description = "Define PortGroup and IPs for each VM"
  type        = map(list(string))
  default     = {}
}
variable "template" {
  description = "Name of the template to base the VM off."
  type = string
}

variable "instances" {
  type = number
  description = "The number of machines in the cluster"
}
variable "name_start" {
  description = "The name of the machines (excluding the identifier)"
  type = string
}
variable "name_format" {
  description = "VM name format"
  type = string
  default     = "%02d"
}
variable "folder" {
  description = "The folder to store the virtual machines in"
  type = string
  default = ""
}
variable "domain" {
  type = string
  description = "Default VM domain."
}
variable "dns_servers" {
  description = "DNS Servers for the VM to use."
  type    = list(string)
}
variable "gateway" {
  description = "VM gateway to set during provisioning."
  type = string
}
variable "resources" {
  type = object({
    cpu = number
    ram = number
  })
  default = {
    cpu = 2
    ram = 4096
  }
}
variable "dns_options" {
  default = {
    register_local_dns = false
    local_dns_server_hostname = ""
    register_external_dns = false
    local_dns_domain = ""
    external_dns_domain = ""
  }
  type = object({
    register_local_dns = bool
    local_dns_server_hostname = string
    local_dns_domain = string
    external_dns_domain = string
    register_external_dns = bool
  })
}