provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  use_oidc        = false
  subscription_id = var.az_sub_id
  environment     = "public"
  use_msi         = false
  use_cli         = true
}
