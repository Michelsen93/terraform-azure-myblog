import {
  to = azurerm_resource_group.ommichelsen-rg
  id = "/subscriptions/${var.az_sub_id}/resourceGroups/ommichelsen"
}


resource "azurerm_resource_group" "ommichelsen-rg" {
  name     = "ommichelsen"
  location = "norwayeast"
}

resource "azurerm_container_registry" "ommichelsen-cr" {
  location            = azurerm_resource_group.ommichelsen-rg.location
  name                = "myblogregistry"
  resource_group_name = azurerm_resource_group.ommichelsen-rg.name
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_dns_zone" "ommichelsen-dz" {
  name                = "olemichelsen.com"
  resource_group_name = azurerm_resource_group.ommichelsen-rg.name
}

