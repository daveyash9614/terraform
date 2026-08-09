data "azurerm_subnet" "subnet" {
  for_each             = var.virtual_machines
  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
}

data "azurerm_public_ip" "public_ip" {
  for_each            = { for k, v in var.virtual_machines : k => v if try(v.pip_name, "") != "" }
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}
