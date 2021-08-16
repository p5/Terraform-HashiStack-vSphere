output "names" {
  description = "VM Names"
  value = vsphere_virtual_machine.virtual_machines.*.name
}
output "default_ip_addresses" {
  description = "default ip address of the deployed VM"
  value = vsphere_virtual_machine.virtual_machines.*.default_ip_address
}
output "uuids" {
  description = "UUID of the VM in vSphere"
  value       = vsphere_virtual_machine.virtual_machines.*.uuid
}