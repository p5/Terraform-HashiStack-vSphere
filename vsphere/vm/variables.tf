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
#variable "networks" {
#  type = list(object({
#    name = string,
#    dhcp = bool,
#    ip_address = string,
#    subnet_mask = string
#  }))
#}

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
  default = 1
}
variable "name" {
  description = "The name of the machines (excluding the identifier)"
  type = string
}
variable "name_format" {
  description = "VM name format"
  default     = "%02d"
  type = string
}
variable "folder" {
  description = "The folder to store the virtual machines in"
  type = string
}
variable "domain" {
  type = string
  default = null
  description = "Default VM domain."
}
variable "dns_servers" {
  description = "DNS Servers for the VM to use."
  type    = list(string)
  default = null
}
variable "gateway" {
  description = "VM gateway to set during provisioning."
  default     = null
  type = string
}
variable "resources" {
  type = object({
    cpu = number
    ram = number
  })
}

variable "subnet_mask" {
  description = "ipv4 Subnet mask."
  type        = list(string)
  default     = ["24"]
}