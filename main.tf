import {
  to = azurerm_resource_group.ommichelsen-rg
  id = "/subscriptions/${var.az_sub_id}/resourceGroups/ommichelsen"
}


resource "azurerm_resource_group" "ommichelsen-rg" {
  name     = "ommichelsen"
  location = "norwayeast"
}

resource "azurerm_container_group" "ommichelsen-cg" {
  dns_name_label      = "ommichelsen6"
  location            = azurerm_resource_group.ommichelsen-rg.location
  name                = "my-blog"
  os_type             = "Linux"
  resource_group_name = azurerm_resource_group.ommichelsen-rg.name
  container {
    cpu    = 1
    image  = "myblogregistry.azurecr.io/my-blog:${var.image_tag}"
    memory = 1.5
    name   = "my-blog"
    ports {
      port = 80
    }
  }
  image_registry_credential {
    server   = "myblogregistry.azurecr.io"
    username = var.registry_username
    password = var.registry_password
  }
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

resource "azurerm_log_analytics_workspace" "ommichelsen-aw" {
  location            = azurerm_resource_group.ommichelsen-rg.location
  name                = "workspace-ommichelsen"
  resource_group_name = azurerm_resource_group.ommichelsen-rg.name
}

resource "azurerm_storage_account" "ommichelsen-sa" {
  account_replication_type         = "LRS"
  account_tier                     = "Standard"
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false
  default_to_oauth_authentication  = true
  location                         = "norwayeast"
  min_tls_version                  = "TLS1_2"
  name                             = var.storage_account_name
  resource_group_name              = azurerm_resource_group.ommichelsen-rg.name
}

resource "azurerm_service_plan" "ommichelsen-sp" {
  location            = azurerm_resource_group.ommichelsen-rg.location
  name                = "ASP-ommichelsen-a712"
  os_type             = "Linux"
  resource_group_name = azurerm_resource_group.ommichelsen-rg.name
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "ommichelsen-wa" {
  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY                  = var.my_blog_instrumentation_key
    APPINSIGHTS_PROFILERFEATURE_VERSION             = "1.0.0"
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION             = "1.0.0"
    APPLICATIONINSIGHTS_CONFIGURATION_CONTENT       = ""
    APPLICATIONINSIGHTS_CONNECTION_STRING           = azurerm_application_insights.ommichelsen-ai.connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION      = "~3"
    DiagnosticServices_EXTENSION_VERSION            = "~3"
    InstrumentationEngine_EXTENSION_VERSION         = "disabled"
    SnapshotDebugger_EXTENSION_VERSION              = "disabled"
    WEBSITES_ENABLE_APP_SERVICE_STORAGE             = "false"
    XDT_MicrosoftApplicationInsights_BaseExtensions = "disabled"
    XDT_MicrosoftApplicationInsights_Mode           = "recommended"
    XDT_MicrosoftApplicationInsights_PreemptSdk     = "disabled"
  }
  client_certificate_mode = "OptionalInteractiveUser"
  https_only              = true
  location                = azurerm_resource_group.ommichelsen-rg.location
  name                    = "michelsen-blog"
  resource_group_name     = azurerm_resource_group.ommichelsen-rg.name
  service_plan_id         = azurerm_service_plan.ommichelsen-sp.id
  identity {
    type = "SystemAssigned"
  }
  site_config {
    ftps_state = "FtpsOnly"
  }
  sticky_settings {
    app_setting_names = ["APPINSIGHTS_INSTRUMENTATIONKEY", "APPLICATIONINSIGHTS_CONNECTION_STRING", "APPINSIGHTS_PROFILERFEATURE_VERSION", "APPINSIGHTS_SNAPSHOTFEATURE_VERSION", "ApplicationInsightsAgent_EXTENSION_VERSION", "XDT_MicrosoftApplicationInsights_BaseExtensions", "DiagnosticServices_EXTENSION_VERSION", "InstrumentationEngine_EXTENSION_VERSION", "SnapshotDebugger_EXTENSION_VERSION", "XDT_MicrosoftApplicationInsights_Mode", "XDT_MicrosoftApplicationInsights_PreemptSdk", "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT", "XDT_MicrosoftApplicationInsightsJava", "XDT_MicrosoftApplicationInsights_NodeJS"]
  }
}
resource "azurerm_app_service_custom_hostname_binding" "ommichelsen-schb" {
  resource_group_name = azurerm_resource_group.ommichelsen-rg.name
  hostname            = "michelsen.dev"
  app_service_name    = azurerm_linux_web_app.ommichelsen-wa.name

}
resource "azurerm_monitor_action_group" "ommichelsen-ag" {
  name                = "Application Insights Smart Detection"
  resource_group_name = azurerm_resource_group.ommichelsen-rg.name
  short_name          = "SmartDetect"
  arm_role_receiver {
    name                    = "Monitoring Contributor"
    role_id                 = "749f88d5-cbae-40b8-bcfc-e573ddc772fa"
    use_common_alert_schema = true
  }
  arm_role_receiver {
    name                    = "Monitoring Reader"
    role_id                 = "43d0d8ad-25c7-4714-9337-8ba259a9fe05"
    use_common_alert_schema = true
  }
}
resource "azurerm_application_insights" "ommichelsen-ai" {
  application_type    = "web"
  location            = azurerm_resource_group.ommichelsen-rg.location
  name                = "michelsen-blog"
  resource_group_name = azurerm_resource_group.ommichelsen-rg.name
  sampling_percentage = 10
}
