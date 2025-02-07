variable "proxmox" {
  type = object({
    name         = string
    cluster_name = string
    endpoint     = string
    insecure     = bool
    username     = string
    api_token    = string
  })
  sensitive = true
}

# variable "volumes" {
#   type = map(object({
#     node = string # PVE cluster node name. i.e pve1
#     size = string # i.e 20G
#     storage_id = optional(string, "local-lvm")
#     format = optional(string, "raw")
#     vm_id = optional(number, 9999)
#   }))
# }

variable "nodes" {
  type = map(object({
    volumes = list(object({
      size         = number # size in GB
      datastore_id = optional(string, "local-lvm")
      format       = optional(string, "raw")
      iothread     = optional(bool, true)
      cache        = optional(string, "writethrough")
      discard      = optional(string, "on")
      ssd          = optional(bool, true)
    })),
    vm_id = optional(number, 9999)
  }))
}