output "resource_proxmox_virtual_environment_vm_example_id" {
  value = {
        id = "${zipmap(values(proxmox_virtual_environment_vm.custom_templates).*.name, values(proxmox_virtual_environment_vm.custom_templates).*.id, )}"
        #name = values(proxmox_virtual_environment_vm.custom_templates).*.name
    }
}
