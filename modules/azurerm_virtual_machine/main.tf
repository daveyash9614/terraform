resource "azurerm_network_interface" "nics" {
  for_each            = var.virtual_machines
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.ip_config_name
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = each.value.private_ip_address_allocation
    private_ip_address            = each.value.private_ip_address_allocation == "Static" ? each.value.private_ip_address : null
    public_ip_address_id          = try(data.azurerm_public_ip.public_ip[each.key].id, null)
  }
}

resource "azurerm_linux_virtual_machine" "linux_vms" {
  for_each = { for k, v in var.virtual_machines : k => v if v.os_type == "linux" }

  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = each.value.disable_password_authentication
  network_interface_ids           = [azurerm_network_interface.nics[each.key].id]

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }
}

resource "azurerm_windows_virtual_machine" "windows_vms" {
  for_each = { for k, v in var.virtual_machines : k => v if v.os_type == "windows" }

  name                  = each.value.name
  computer_name         = each.value.computer_name
  resource_group_name   = each.value.resource_group_name
  location              = each.value.location
  size                  = each.value.size
  admin_username        = each.value.admin_username
  admin_password        = each.value.admin_password
  network_interface_ids = [azurerm_network_interface.nics[each.key].id]

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }
}
