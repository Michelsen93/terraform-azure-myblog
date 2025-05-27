resource "azurerm_postgresql_flexible_server" "pg" {
  name                   = var.name
  location               = var.location
  resource_group_name    = var.rg_name
  administrator_login    = var.pg_flex_username
  administrator_password = var.pg_flex_password
  version                = "16"
  sku_name               = "B_Standard_B1ms"
  storage_mb             = 32768
  zone                   = "1"
  authentication {
    active_directory_auth_enabled = false
    password_auth_enabled         = true
  }
}

resource "azurerm_postgresql_flexible_server_database" "counterdb" {
  name      = "counterdb"
  server_id = azurerm_postgresql_flexible_server.pg.id
}
