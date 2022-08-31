# Read Certificate
data "azurerm_key_vault_secret" "vpn-root-certificate" {
  depends_on=[
    azurerm_key_vault.keyvault,
    azurerm_key_vault_secret.vpn-root-certificate
  ]
  
  name         = "vpn-p2s-root-certificate"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# Create a Public IP for the Gateway
resource "azurerm_public_ip" "vpn-gateway-ip" {
  name                = "${var.prefix}-gw-ip"
  location            = data.terraform_remote_state.existing-hub.outputs.hub_rg_location
  resource_group_name = data.terraform_remote_state.existing-hub.outputs.hub_rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create VPN Gateway
resource "azurerm_virtual_network_gateway" "vpn-gateway" {
  name                = "${var.prefix}-vpn-gw"
  location            = data.terraform_remote_state.existing-hub.outputs.hub_rg_location
  resource_group_name = data.terraform_remote_state.existing-hub.outputs.hub_rg_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnet-gateway-config"
    public_ip_address_id          = azurerm_public_ip.vpn-gateway-ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.terraform_remote_state.existing-hub.outputs.hub_gateway_subnet_id
  }

  vpn_client_configuration {
    address_space = ["10.2.0.0/24"]

    root_certificate {
      name = "VPNROOT"

      public_cert_data = data.azurerm_key_vault_secret.vpn-root-certificate.value
    }

  }
}
