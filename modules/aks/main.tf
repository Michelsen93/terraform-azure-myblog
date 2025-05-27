
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "test-aks"
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name                        = "default"
    node_count                  = 3
    vm_size                     = "Standard_B2s"
    temporary_name_for_rotation = "rotated"
  }

  network_profile {
    network_plugin = "azure"
  }
  

  identity {
    type = "SystemAssigned"
  }
}

