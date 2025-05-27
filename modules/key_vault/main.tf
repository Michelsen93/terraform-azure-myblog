resource "azurerm_key_vault" "kv" {
  name                = "main-kv"
  location            = var.location
  resource_group_name = var.rg_name
  tenant_id           = var.tenant_id
  sku_name            = "standard"

}

output "id" {
  value = azurerm_key_vault.kv.id
}
