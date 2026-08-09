resource "azurerm_bastion_host" "bastion" {
  name                = var.bastion.name
  location            = var.bastion.location
  resource_group_name = var.bastion.resource_group_name

  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = data.azurerm_subnet.bastion_subnet.id
    public_ip_address_id = data.azurerm_public_ip.bastion_pip.id
  }
}
