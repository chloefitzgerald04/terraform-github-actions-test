default_import = {
    "content_type"           = "import"
    "node"                   = "SA-MS01"
    "datastore"              = "local"

}

import_disks = {
    "flatcar-proxmox2.qcow2" = {
        "name"               = "debian-12-generic-amd64-20231228-1609.qcow2"
        "url"                = "https://stable.release.flatcar-linux.net/amd64-usr/current/flatcar_production_proxmoxve_image.img"
    }
}


