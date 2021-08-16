resource "vsphere_virtual_machine" "virtual_machines" {
  count = var.instances
  name = format("${var.name}${var.name_format}", count.index + 1)
  resource_pool_id = data.vsphere_resource_pool.pool.id

  folder = var.folder
  firmware = "bios"

  datastore_id = data.vsphere_datastore.datastore.id

  annotation = null

  num_cpus = var.resources.cpu
  memory = var.resources.ram

  guest_id = data.vsphere_virtual_machine.template.guest_id

  dynamic "network_interface" {
    for_each = keys(var.networks)
    content {
      network_id   = data.vsphere_network.networks[network_interface.key].id
      adapter_type = "vmxnet3"
    }
  }

  dynamic "disk" {
    for_each = data.vsphere_virtual_machine.template.disks
    iterator = template_disks
    content {
      label = "disk${template_disks.key}"
      size = data.vsphere_virtual_machine.template.disks[template_disks.key].size
      unit_number = template_disks.key
    }
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = format("${var.name}${var.name_format}", count.index + 1)
        domain = var.domain
      }

      dynamic "network_interface" {
        for_each = keys(var.networks)
        content {
          ipv4_address = var.networks[keys(var.networks)[network_interface.key]][count.index]
          ipv4_netmask = length(var.subnet_mask) == 1 ? var.subnet_mask[0] : var.subnet_mask[network_interface.key]
        }
      }

      dns_server_list = var.dns_servers
      ipv4_gateway = var.gateway
    }
  }

  lifecycle {
    ignore_changes = [
      annotation,
      tags
    ]
  }
}
