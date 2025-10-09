default_vm = {
         "node"                                                 = "pve-01"
         "os"                                                   = "l26"
         "machine"                                              = "pc" # pc (i440FX) or q35
         "description"                                          = "Default config for vm"
         "agent"                                                = false
         "on_boot"                                              = true
         "bootorder"                                            = ["scsi0", "ide0", "net0"]
         "startup" = {
             "order"                                            = "3"
             "up_delay"                                         = "60"
             "down_delay"                                       = "60"
         }
         "cpu" = {
            "vcpus"                                             = 2 
            "sockets"                                           = 1
            "type"                                              = "x86-64-v2-AES"
         }
         "memory" = {
            "dedicated"                                         = 4096
            "floating"                                          = 0
         }
         "scsi_hardware"                                        = "virtio-scsi-pci"
         "scsi" = {
            "0" = {
                "size"                                          = 32
                "datastore_id"                                  = "Ceph"
                "discard"                                       = "on"
            }
         }
         "bios"                                                 = "seabios" # or ovmf
         "efi-disk" = { # Required if bios set to ovmf
            "datastore_id"                                      = "Ceph"
         }
         "rebootafterupdate"                                    = "true"
         "tpm" = {
            "enabled"                                           = false
            "version"                                           = "v2.0"
            "datastore_id"                                      = "Ceph"
         }
         "stop_on_destroy"                                      = true
         "startup"                                              = false
         "boot_order"                                           = ["scsi0", "ide2", "net0"]
         #"clone" = 
         "pxe"                                                  = true
         "cdrom" = {
             "iso"                                              = "NAS:iso/archlinux-2024.06.01-x86_64.iso" 
             "interface"                                        = "ide0"
         }
         "network_devices" = {
            "0" = {
                "bridge" = "vmbr2"
                "vlan_id" = "10"
                "model" = "virtio"
            }
         }

        
}

iso_vms= {
     "VM1" = {
         "name" = "01"
         "node" = "pve-01"
         "cpu" = {
            "vcpus" = 2
         }
         "memory" = {
            "dedicated" = 4096
         }
         "pxe" = true
         "bios" = "seabios"
         "cdrom" = {
             "iso" = "NAS:iso/archlinux-2024.06.01-x86_64.iso" 
         }
         "scsi" = {
            "0" = {
                "size" = 33
                "datastore_id" = "Ceph"
            }
         }
         "network_devices" = {
            "1" = {
                "bridge" = "vmbr2"
                "vlan_id" = "10"
                "model" = "e1000e"
            }
         }
         
     }
}
