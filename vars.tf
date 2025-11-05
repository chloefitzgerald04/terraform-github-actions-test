variable "ssh_key" {
  default = "your_public_ssh_key_here"
}
variable "proxmox_host" {
    default = "SA-MS01"
}
variable "iso" {
    default = "NAS:iso/archlinux-2024.06.01-x86_64.iso"
}
variable "nic_name" {
    default = "vmbr2"
}
variable "vlan_num" {
    default = "10"
}
variable "mem" {
    default = "4096"
}

variable "api_url" {
    default = "https://10.0.10.200:8006/api2/json"
}
variable "token_secret" {
    default = "123abc"
}
variable "token_id" {
    default = "test@pve!test"
}

variable "iso_vms" {
    default = {}
}
variable "default_vm" {
    default = {}
}
