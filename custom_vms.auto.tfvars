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