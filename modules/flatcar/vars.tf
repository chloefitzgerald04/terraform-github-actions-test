variable "name" {
  type        = string
  default     = "Flatcar-Linux"
  description = "The base name of the VM"
}

variable "butane_conf" {
  type        = string
  description = "YAML Butane configuration for the VM"
  default     = "config.bu.tftpl"
}
variable "butane_conf_snippets" {
  type        = list(string)
  default     = []
  description = "Additional YAML Butane configuration(s) for the VM"
}

variable "docker-compose-template"{
  description = "Pass through a docker compose template URL to be added into butane"
  type        = string
  default     = "https://raw.githubusercontent.com/chloefitzgerald04/IaC/refs/heads/main/demo/docker-compose.yaml"
}



variable "storage" {
  description = "The name of the storage used for storing VM images"
  type        = string
  default     = "Ceph"
}

variable "vm_count" {
  description = "The number of VMs to provision"
  type        = number
  default     = 0
}
variable "template_name" {
  description = "The name of the Proxmox Flatcar template VM"
  type    = string
  default = "flatcar-qemu"
}
variable "vm_id" {
  type    = number
  default = 0
}

variable "tags" {
  description = "Tags to apply to the VM"
  type        = list(string)
  default     = ["flatcar"]
}

variable "cores" {
  type    = number
  default = 2
}
variable "cpu" {
  type        = string
  default     = "host"
}
variable "memory" {
  type    = number
  default = 4096
}
variable "network_bridge" {
  type    = string
  default = "vmbr2"
}
variable "vlan" {
  type    = number
  default = 0
}


variable "pm_api_url" {
  description = "The FQDN and path to the API of the proxmox server e.g. https://example.com:8006/api2/json"
  type        = string
  default     = "https://10.0.0.102:8006/api2/json"
}

variable "target_node" {
  description = "The name of the target proxmox node"
  type        = string
  default     = "pve-02"
}
variable "token_id" {
  description = "user@pam!token_id in tfvars"
  type        = string
  default     = "user@pam!token_id"
}

variable "token_secret" {
  description = "secret hash in tfvars"
  type        = string
  sensitive   = true
  default     = ""
}


variable "share_password" {
  description = "secret hash in tfvars"
  type        = string
  sensitive   = true
  default     = ""
}
