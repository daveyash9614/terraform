data "azurerm_subnet" "bastion_subnet" {
  name                 = var.bastion.subnet_name
  resource_group_name  = var.bastion.resource_group_name
  virtual_network_name = var.bastion.virtual_network_name
}

data "azurerm_public_ip" "bastion_pip" {
  name                = var.bastion.pip_name
  resource_group_name = var.bastion.resource_group_name
}
