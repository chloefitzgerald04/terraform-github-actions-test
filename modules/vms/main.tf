terraform {
  required_providers {
    telmate = {
      source = "telmate/proxmox"
      version = "3.0.2-rc05"
    }
  }
}
resource "proxmox_vm_qemu" "iso_vms" {
    provider = telmate
    for_each                  = var.iso_vms
    name                      = each.value.name
    pxe                       = try(each.value.pxe, false)
    agent                     = 1
    automatic_reboot          = true
    bios                      = try(each.value.bios, "seabios")
    boot                      = "order=scsi0;ide2;net0"
    hotplug                   = "network,disk,usb"
    kvm                       = true
    memory                    = try(each.value.mem, "4096")
    onboot                    = try(each.value.startup, true)
    scsihw                    = "virtio-scsi-pci"
    target_node               = each.value.node
    cores                     = 2
    sockets                   = 1
    full_clone = true
    clone_wait = 0

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
    disk {
        slot    = "scsi0"
        size    = "32G"
        type    = "disk"
        storage = "local-lvm"
    }
    network {
        bridge    = try(each.value.network_name, "vmbr2")
        firewall  = false
        link_down = false
        model     = try(each.value.nic_model, "virtio")
    }
}

resource "proxmox_vm_qemu" "clone_vms" {
    provider = telmate
    for_each                  = var.clone_vms
    name                      = each.value.name
    agent                     = 1
    automatic_reboot          = true
    bios                      = try(each.value.bios, "seabios")
    hotplug                   = "network,disk,usb"
    kvm                       = true
    memory                    = try(each.value.mem, "4096")
    onboot                    = try(each.value.startup, true)
    scsihw                    = "virtio-scsi-pci"
    target_node               = each.value.node
    cores                     = 2
    sockets                   = 1
    full_clone                = true
    clone_wait                = 0
    clone                     = try(each.value.clone, null)

    disks {
        scsi {
            scsi0 {
                disk {
                    discard            = true
                    emulatessd         = true
                    size               = try(each.value.disk_size, "32")
                    storage            = "Ceph"
                }
            }
        }
    }

    network {
        bridge    = try(each.value.network_name, "vmbr2")
        model     = try(each.value.nic_model, "virtio")
        tag       = try(each.value.vlan, 10)
    }
}