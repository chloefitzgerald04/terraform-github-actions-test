default_vm = {
         "node" = "pve-01"
         "os" = "l26"
         "agent" = false
         "reboot_after_update"          = true
         "cpu_cores" = 2
         "cpu_arch"         = "x86-64-v2-AES"
         "mem_dedicated" = 4096
         "mem_floating" = 4096
         "pxe" = true
         "tpm" = "disabled"
         "stop_on_destroy" = true
         "startup" = false
         "bios" = "ovmf"
         "boot_order"                = ["scsi0", "ide2", "net0"]
         "cdrom" = {
             "iso" = "NAS:iso/archlinux-2024.06.01-x86_64.iso" 
             "interface" = "ide0"
         }
         "scsi" = {
            "0" = {
                "size" = 32
                "datastore_id" = "Ceph"
            }
         }
        
}

iso_vms= {
     "VM1" = {
         "name" = "01"
         "node" = "pve-01"
         "procs" = 1
         "mem" = 4096
         "network_name" = "vmbr2"
       
         "pxe" = true
         "startup" = false
         "bios" = "ovmf"
         "cdrom" = {
             "iso" = "NAS:iso/archlinux-2024.06.01-x86_64.iso" 
         }
         "scsi" = {
            "0" = {
                "size" = 32
                "datastore_id" = "Ceph"
            }
            "1" = {
                "size" = 35
                "datastore_id" = "Ceph"
            }
         }
       
     }
}
