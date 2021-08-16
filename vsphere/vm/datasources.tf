
data "vsphere_datacenter" "dc" {
  name = var.datacenter
}
data "vsphere_datastore" "datastore" {
  name = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_resource_pool" "pool"{
  name = var.resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_virtual_machine" "template" {
  name = var.template
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_network" "networks" {
  count         = length(var.networks)
  name          = keys(var.networks)[count.index]
  datacenter_id = data.vsphere_datacenter.dc.id
}
