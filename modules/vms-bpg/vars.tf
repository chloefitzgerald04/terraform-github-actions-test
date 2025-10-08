variable "default_vm"{
    default = {}
}

variable "iso_vms" {
#     default = {
#         "VM1" = {
#             "name" = "01"
#             "node" = "pve-01"
#             "procs" = 1
#             "mem" = 4096
#             "network_name" = "vmbr2"
#             "iso" = "NAS:iso/archlinux-2024.06.01-x86_64.iso"
#             "pxe" = true
#             "startup" = false
#             "bios" = "ovmf"
#             "disk_size" = 16
#         }
#         "VM2" = {
#             "name" = "02"
#             "node" = "pve-02"
#             "procs" = 1
#             "mem" = 4096
#             "network_name" = "vmbr2"
#             "iso" = "NAS:iso/archlinux-2024.06.01-x86_64.iso"
#             "disk_size" = 32
            
            
#         }
#         "VM3" = {
#             "name" = "03"
#             "node" = "pve-03"
#             "procs" = 1
#             "mem" = 4096
#             "network_name" = "vmbr2"
#             "iso" = "NAS:iso/archlinux-2024.06.01-x86_64.iso"
#             "nic_model" = "vmxnet3"
#             "disk_size" = 16
#         }
#   }
    default = {}
}



variable "clone_vms" {
    # default = {
    #     "VM4" = {
    #         "name" = "04"
    #         "node" = "pve-02"
    #         "procs" = 2
    #         "mem" = 4096
    #         "network_name" = "vmbr2"
    #         "vlan" = 20
    #         "clone" = "flatcar-qemu"
    #         "startup" = false
    #         "bios" = "seabios"
    #         "disk_size" = 16
    #     }
    # }
    default = {}
}

variable "token_secret" {
    default = "123abc"
}
variable "token_id" {
    default = "test@pve!test"
}