resource "azurerm_virtual_network" "main" {
  name                = "shared-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "aks" {
  name                 = "aks-subnet"
  address_prefixes     = ["10.0.1.0/24"]
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = var.rg_name
}

resource "azurerm_subnet" "postgres" {
  name                 = "postgres-subnet"
  address_prefixes     = ["10.0.2.0/24"]
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = var.rg_name
  delegation {
    name = "fsDelegation"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_private_dns_zone" "postgres" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = var.rg_name
}

output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}

output "postgres_subnet_id" {
  value = azurerm_subnet.postgres.id
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.postgres.id
}
