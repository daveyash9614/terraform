data "azurerm_subnet" "appgw_subnet" {
  name                 = var.application_gateway.subnet_name
  resource_group_name  = var.application_gateway.resource_group_name
  virtual_network_name = var.application_gateway.virtual_network_name
}

data "azurerm_public_ip" "appgw_pip" {
  name                = var.application_gateway.pip_name
  resource_group_name = var.application_gateway.resource_group_name
}
