variable "location" {
  default = "north europe"
}
data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "ommichelsen"
  location = var.location
}

resource "random_id" "suffix" {
  byte_length = 4
}

module "aks" {
  source     = "./modules/aks"
  rg_name    = azurerm_resource_group.rg.name
  location   = azurerm_resource_group.rg.location
  dns_prefix = "aks-${random_id.suffix.hex}"
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
}

module "key_vault" {
  source    = "./modules/key_vault"
  location  = azurerm_resource_group.rg.location
  name = "main-vault-${random_id.suffix.hex}"
  rg_name   = azurerm_resource_group.rg.name
  tenant_id = data.azurerm_client_config.current.tenant_id
}

module "pg_username" {
  source       = "./modules/key_vault_secret"
  name         = "pg-username"
  value        = var.pg_flex_username
  key_vault_id = module.key_vault.id
}
module "pg_password" {
  source       = "./modules/key_vault_secret"
  name         = "pg-password"
  value        = var.pg_flex_password
  key_vault_id = module.key_vault.id
}





