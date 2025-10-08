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
    telmate = {
      source = "telmate/proxmox"
      version = "3.0.1-rc3"
    }
    bpg = {
      source = "bpg/proxmox"
      version = "0.84.1"
    }
  }
}



module "proxmox_vm" {
  source           = "./modules/vms-bpg"
  iso_vms          = var.iso_vms

}


module "proxmox_vm_flatcar" {
  source           = "./modules/flatcar"

}