variable "zone_domain" {
  default = ""
  type = string
}
variable "hostnames" {
  type = list(string)
  default = []
}
variable "host_ip_addresses" {
  default = []
  type = list(string)
}