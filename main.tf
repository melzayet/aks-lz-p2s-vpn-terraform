data "azurerm_client_config" "current" {
}

output "account_id" {
  value = data.azurerm_client_config.current.client_id
}

output "subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
}

output "object_id" {
  value = data.azurerm_client_config.current.object_id
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

data "terraform_remote_state" "existing-hub" {
  backend = "azurerm"

  config = {
    storage_account_name = var.state_sa_name
    container_name       = var.container_name
    key                  = "hub-net"
    access_key = var.access_key
  }
}

