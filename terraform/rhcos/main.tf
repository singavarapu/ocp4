output "debug" {
  value = var.guest_id
}

resource "vsphere_virtual_machine" "vm" {
  
  name                = var.name
  resource_pool_id    = var.resource_pool_id
  datastore_id        = var.datastore
  num_cpus            = var.num_cpu
  memory              = var.memory
  memory_reservation  = var.memory
  guest_id            = var.guest_id
  folder              = var.folder
  enable_disk_uuid    = "true"

  wait_for_guest_net_timeout  = "0"
  wait_for_guest_net_routable = "false"

  network_interface {
    network_id = var.network
  }

  disk {
    label            = "disk0"
    size             = 16
    thin_provisioned = "false"
  }

  clone {
    template_uuid = var.template
  }

  # vapp {
  #   properties = {
  #     "guestinfo.ignition.config.data"          = "${base64encode(data.ignition_config.ign.*.rendered[count.index])}"
  #     "guestinfo.ignition.config.data.encoding" = "base64"
  #   }
  # }
}