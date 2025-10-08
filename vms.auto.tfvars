default_vm = {
         "node"                                                 = "pve-01"
         "os"                                                   = "l26"
         "description"                                          = "Default config for vm"
         "agent"                                                = false
         "startup" = {
             "order"                                            = "3"
             "up_delay"                                         = "60"
             "down_delay"                                       = "60"
         }
         "cpu" = {
            "cores"                                             = 2
            "type"                                              = "x86-64-v2-AES" 
         }
         "memory" = {
            "dedicated"                                         = 4096
            "floating"                                          = 4096
         }
         "scsi" = {
            "0" = {
                "size"                                          = 32
                "datastore_id"                                  = "Ceph"
                "discard"                                       = "on"
            }
         }
         "bios"                                                 = "ovmf" # or seabios
         "efi_disk" = { # Required if bios set to omvf
            "datastore_id"                                      = "Ceph"
         }
         "reboot_after_update"                                  = true
         "tpm"                                                  = "disabled"
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
         "procs" = 1
         "mem" = 4096
         "pxe" = true
         "startup" = false
         "bios" = "ovmf"
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
