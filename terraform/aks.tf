resource "azurerm_kubernetes_cluster" "aks" {

  name                = var.aks_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  dns_prefix = "devsecopsaks"

  default_node_pool {

    name       = "nodepool"
    node_count = var.node_count
    vm_size    = var.node_vm_size

    vnet_subnet_id = azurerm_subnet.aks_subnet.id

  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }

}
