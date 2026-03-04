variable "location" {
  description = "Azure region"
  default     = "Central India"
}

variable "resource_group_name" {
  description = "Resource group name"
  default     = "devsecops-rg"
}

variable "aks_cluster_name" {
  description = "AKS cluster name"
  default     = "devsecops-aks"
}

variable "acr_name" {
  description = "Azure container registry name"
  default     = "devsecopsacrganesh217"
}

variable "node_count" {
  default = 2
}

variable "node_vm_size" {
  default = "Standard_B2s"
}
