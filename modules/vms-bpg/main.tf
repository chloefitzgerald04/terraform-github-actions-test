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
        enabled = true
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
    # disks {
    #     scsi {
    #         scsi0 {
    #             disk {
    #                 discard            = true
    #                 emulatessd         = true
    #                 size               = try(each.value.disk_size, "32")
    #                 storage            = "Ceph"
    #             }
    #         }
    #     }    
    #     ide {
    #         ide2 {
    #             cdrom {
    #                 iso = try(each.value.iso, null)
    #             }
    #         }
    #     }
    # }
    # dynamic "disk" {
    #     for_each = each.value.disk[*]
    #     content {
    #         size        = "31"
    #         type        = "disk"
    #         slot        = "scsi1"
    #     }

    # }
    dynamic "disk" {
        for_each = each.value.scsi
        iterator = data_disk
        content {
            datastore_id      = data_disk.value["datastore_id"]
            size              = data_disk.value["size"]
            interface         = "scsi${data_disk.key}"
        }
    }
    # dynamic "disk" {
    #     for_each = each.value.sata
    #     iterator = data_disk
    #     content {
    #         datastore_id      = data_disk.value["datastore_id"]
    #         size              = data_disk.value["size"]
    #         interface         = "sata${data_disk.key}"
    #     }
    # }




    # disk {
    #     datastore_id = "Ceph"
    #     interface    = "scsi0"
    #     size         = 8
    # }
    network_device {
        bridge    = try(each.value.network_name, "vmbr2")
        vlan_id   = try(each.value.vlan_id, 10)
        model     = try(each.value.nic_model, "virtio")
    }
}

