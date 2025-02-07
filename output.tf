output "volumes" {
  value = proxmox_virtual_environment_vm.data_vm[*]
}

resource "local_file" "kube_config" {
  content         = jsonencode(proxmox_virtual_environment_vm.data_vm)
  filename        = "output/data_vms.json"
  file_permission = "0600"
}