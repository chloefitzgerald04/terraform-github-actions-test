terraform {
  required_providers {
    bpg = {
      source = "bpg/proxmox"
      version = "0.84.1"
    }
  }
}


resource "proxmox_virtual_environment_vm" "iso_vms" {
    provider = bpg
    for_each                  = var.iso_vms
    name                      = each.value.name
    #pxe                       = try(each.value.pxe, false)
    agent {
        enabled = false
    }
    reboot_after_update          = true
    bios                      = try(each.value.bios, "seabios")
    boot_order                = ["scsi0", "ide2", "net0"]
    memory {
        dedicated = try(each.value.mem, "4096")
    }
    on_boot                    = try(each.value.startup, true)
    #interface                    = "virtio-scsi-pci"
    node_name                 = each.value.node

    cpu {
        cores        = 2
        type         = "x86-64-v2-AES"  # recommended for modern CPUs
    }

    dynamic "cdrom"{
        for_each = lookup(each.value, "cdrom", null) == null ? [] : [each.value.cdrom]
        content {
            file_id = cdrom.value.iso
            interface = try(cdrom.value.interface, var.default_vm.cdrom.interface, null)
        }
    }
    dynamic "disk" {
        for_each = try(each.value.scsi, var.default_vm.scsi, {})
        iterator = data_disk
        content {
            datastore_id      = try( data_disk.value["datastore_id"], var.default_vm.scsi[0].datastore_id, null)
            size              = try( data_disk.value["size"], var.default_vm.scsi[0].size, null)
            file_format       = try( data_disk.value["file_format"], var.default_vm.scsi[0].file_format, null)
            discard           = try( data_disk.value["discard"], var.default_vm.scsi[0].discard, null)
            interface         = "scsi${data_disk.key}"
        }
    }
    dynamic "disk" {
        for_each = try(each.value.virtio, var.default_vm.virtio, {})
        iterator = data_disk
        content {
            datastore_id      = try( data_disk.value["datastore_id"], var.default_vm.virtio[0].datastore_id, null)
            size              = try( data_disk.value["size"], var.default_vm.virtio[0].size, null)
            file_format       = try( data_disk.value["file_format"], var.default_vm.virtio[0].file_format, null)
            discard           = try( data_disk.value["discard"], var.default_vm.virtio[0].discard, null)
            interface         = "virtio${data_disk.key}"
        }
    }
    dynamic "disk" {
        for_each = try(each.value.sata, var.default_vm.sata, {})
        iterator = data_disk
        content {
            datastore_id      = try( data_disk.value["datastore_id"], var.default_vm.sata[0].datastore_id, null)
            size              = try( data_disk.value["size"], var.default_vm.sata[0].size, null)
            file_format       = try( data_disk.value["file_format"], var.default_vm.sata[0].file_format, null)
            discard           = try( data_disk.value["discard"], var.default_vm.sata[0].discard, null)
            interface         = "sata${data_disk.key}"
        }
    }
    dynamic "disk" {
        for_each = try(each.value.ide, var.default_vm.ide, {})
        iterator = data_disk
        content {
            datastore_id      = try( data_disk.value["datastore_id"], var.default_vm.ide[0].datastore_id, null)
            size              = try( data_disk.value["size"], var.default_vm.ide[0].size, null)
            file_format       = try( data_disk.value["file_format"], var.default_vm.ide[0].file_format, null)
            discard           = try( data_disk.value["discard"], var.default_vm.ide[0].discard, null)
            interface         = "ide${data_disk.key + 1}"
        }
    }
    dynamic "network_device"{
        for_each = try(each.value.network_devices, var.default_vm.network_devices[0], {})
        iterator = nic
        content {
            bridge          = try(nic.value["bridge"], var.default_vm.network_devices[0].bridge, null)
            vlan_id         = try(nic.value["vlan_id"], var.default_vm.network_devices[0].vlan_id, null)
            model           = try(nic.value["model"], var.default_vm.network_devices[0].model, null)
            mac_address     = try(nic.value["mac_address"], var.default_vm.network_devices[0].mac_address, null)
            mtu             = try(nic.value["mtu"], var.default_vm.network_devices[0].mtu, null)
        }
    }
}

