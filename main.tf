variable "location" {
  default = "north europe"
}

resource "azurerm_resource_group" "rg" {
  name     = "ommichelsen"
  location = var.location
}

resource "random_id" "suffix" {
  byte_length = 4
}

module "network" {
  source   = "./modules/network"
  rg_name  = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
}

module "aks" {
  source     = "./modules/aks"
  rg_name    = azurerm_resource_group.rg.name
  location   = azurerm_resource_group.rg.location
  dns_prefix = "aks-${random_id.suffix.hex}"
  subnet_id  = module.network.aks_subnet_id
}

module "container_registry" {
  source   = "./modules/container_registry"
  rg_name  = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  name     = "myblogregistry${random_id.suffix.hex}"
}

module "pg_server" {
  source           = "./modules/postgres"
  name             = "pg-flex-${random_id.suffix.hex}"
  rg_name          = azurerm_resource_group.rg.name
  location         = azurerm_resource_group.rg.location
  pg_flex_username = var.pg_flex_username
  pg_flex_password = var.pg_flex_password
  subnet_id        = module.network.postgres_subnet_id
  dns_zone_id      = module.network.private_dns_zone_id
}
