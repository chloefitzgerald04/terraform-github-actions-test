output "out_template_id" {
  value = {
        ## Outputs the ID by referencing the name of template in templates.auto.tfvars. NB: Not the name within proxmox!
        id = "${zipmap(values(proxmox_virtual_environment_vm.custom_templates).*.name, values(proxmox_virtual_environment_vm.custom_templates).*.id, )}"
    }
}
