terraform {
    backend "s3" {
    endpoints = {
      s3 = "https://s3.eu-central-003.backblazeb2.com"
    }
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    region                      = "eu-central-003"
    bucket                      = "bb-eu-s3-private-terraform"
    key                         = "actions-test/terraform.tfstate"
  }
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

provider "proxmox" {
  pm_api_url = var.api_url
  pm_api_token_id = var.token_id
  pm_api_token_secret = var.token_secret
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "arch" {
    count                     = 1
    name                      = "cf-pve-cl-01-docker-${count.index + 1}"
    #pxe                       = true
    agent                     = 0
    automatic_reboot          = true
    bios                      = "seabios"
    boot                      = "order=scsi0;ide2;net0"
    hotplug                   = "network,disk,usb"
    kvm                       = true
    memory                    = var.mem
    onboot                    = false
    scsihw                    = "virtio-scsi-pci"
    target_node               = var.proxmox_host
    cores       = 2
    sockets     = 1

    disks {
        scsi {
            scsi0 {
                disk {
                    discard            = true
                    emulatessd         = true
                    iothread           = true
                    size               = 32
                    storage            = "Ceph"
                }
            }
        }
        ide {
            ide2 {
                cdrom {
                    iso = var.iso
                 }
            }
        }
    }

    network {
        bridge    = var.nic_name
        firewall  = false
        link_down = false
        model     = "virtio"
    }
}