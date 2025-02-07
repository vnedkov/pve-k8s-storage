resource "proxmox_virtual_environment_vm" "data_vm" {
  for_each  = var.nodes
  node_name = each.key
  started   = false
  on_boot   = false
  vm_id     = each.value.vm_id
  tags      = ["storage", "k8s", "terraform"]

  dynamic "disk" {
    # each additional_disk is an object with a "key" that is its index within the list and a "value" being the object in the list
    for_each = { for idx, volume in each.value.volumes: idx => volume}
    iterator = volume
      content {
        datastore_id = volume.value.datastore_id
        interface    = "scsi${volume.key + 1}"
        iothread     = volume.value.iothread
        cache        = volume.value.cache
        discard      = volume.value.discard
        ssd          = volume.value.ssd
        file_format  = volume.value.format
        size         = volume.value.size
      }
  }
}
