provider "azurerm" {
  features {
  }
  use_oidc        = false
  subscription_id = var.az_sub_id
  environment     = "public"
  use_msi         = false
  use_cli         = true
}
