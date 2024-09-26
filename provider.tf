provider "azurerm" {
  features {
  }
  use_oidc                   = false
  skip_provider_registration = true
  subscription_id            = var.az_sub_id
  environment                = "public"
  use_msi                    = false
  use_cli                    = true
}
