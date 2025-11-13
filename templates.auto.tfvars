proxmox_templates = {
     "flatcar-template" = {
         "name" = "flatcar-template"
         "node" = "SA-MS01"
         "cpu" = {
            "vcpus" = 2
         }
         "memory" = {
            "dedicated" = 4096
         }
         "import" = {
               "import_from" = "https://stable.release.flatcar-linux.net/amd64-usr/current/flatcar_production_proxmoxve_image.img"
               "datastore_id" = "local-lvm"
         }
         "pxe" = true
         "bios" = "seabios"
         "network_devices" = {
            "0" = {
               "model" = "e1000e"
            }
         }
         
     }
}