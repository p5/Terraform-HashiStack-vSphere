variable "email_address" {
  type = string
}
variable "api_key" {
  sensitive = true
  type = string
}
variable "alternate_names" {
  default = []
  type = list(string)
}
variable "domain" {
  type = string
}