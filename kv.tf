locals {
  certificate-name = "${var.root_cert_path}/caCert.pem"
}

resource "azurerm_resource_group" "sharedRG" {
  name     = "shared"
  location = "West Europe"
}

resource "azurerm_key_vault" "keyvault" {
  name                        = "${var.prefix}-kv"
  location                    = azurerm_resource_group.sharedRG.location
  resource_group_name         = azurerm_resource_group.sharedRG.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get", "Set", "List", "Delete"
    ]

    storage_permissions = [
      "Get"
    ]
  }
}


# Create a Secret for the VPN Root certificate
resource "azurerm_key_vault_secret" "vpn-root-certificate" {
  depends_on=[azurerm_key_vault.keyvault]

  name         = "vpn-p2s-root-certificate"
  value        = filebase64(local.certificate-name)
  key_vault_id = azurerm_key_vault.keyvault.id

  tags = {
    environment = "staging"
  }
}
