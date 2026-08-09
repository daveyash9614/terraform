resource_groups = {
  resource_group1 = {
    name     = "dev-insiders-rg"
    location = "uksouth"
  }
}

virtual_networks = {
  virtual_network1 = {
    name                = "dev-insiders-vnet"
    resource_group_name = "dev-insiders-rg"
    location            = "uksouth"
    address_space       = ["10.0.0.0/16"]
  }
}

subnets = {
  appgw = {
    name                 = "dev-insiders-appgw-snet"
    resource_group_name  = "dev-insiders-rg"
    virtual_network_name = "dev-insiders-vnet"
    address_prefixes     = ["10.0.1.0/24"]
  }
  netflix = {
    name                 = "dev-insiders-netflix-snet"
    resource_group_name  = "dev-insiders-rg"
    virtual_network_name = "dev-insiders-vnet"
    address_prefixes     = ["10.0.2.0/24"]
  }
  starbucks = {
    name                 = "dev-insiders-starbucks-snet"
    resource_group_name  = "dev-insiders-rg"
    virtual_network_name = "dev-insiders-vnet"
    address_prefixes     = ["10.0.3.0/24"]
  }
  bastion = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "dev-insiders-rg"
    virtual_network_name = "dev-insiders-vnet"
    address_prefixes     = ["10.0.4.0/26"]
  }
}

public_ips = {
  appgw_pip = {
    name                = "dev-insiders-appgw-pip"
    location            = "uksouth"
    resource_group_name = "dev-insiders-rg"
    allocation_method   = "Static"
    sku_name            = "Standard"
  }
  bastion_pip = {
    name                = "dev-insiders-bastion-pip"
    location            = "uksouth"
    resource_group_name = "dev-insiders-rg"
    allocation_method   = "Static"
    sku_name            = "Standard"
  }
}

virtual_machines = {
  netflix_vm1 = {
    os_type                         = "linux"
    name                            = "Netflix-VM-01"
    nic_name                        = "netflix-vm-01-nic"
    location                        = "uksouth"
    resource_group_name             = "dev-insiders-rg"
    subnet_name                     = "dev-insiders-netflix-snet"
    virtual_network_name            = "dev-insiders-vnet"
    ip_config_name                  = "internal"
    private_ip_address_allocation   = "Static"
    private_ip_address              = "10.0.2.4"
    size                            = "Standard_B1s"
    admin_username                  = "azureuser"
    admin_password                  = "P@ssw0rd1234!"
    disable_password_authentication = false
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
  netflix_vm2 = {
    os_type                         = "linux"
    name                            = "Netflix-VM-02"
    nic_name                        = "netflix-vm-02-nic"
    location                        = "uksouth"
    resource_group_name             = "dev-insiders-rg"
    subnet_name                     = "dev-insiders-netflix-snet"
    virtual_network_name            = "dev-insiders-vnet"
    ip_config_name                  = "internal"
    private_ip_address_allocation   = "Static"
    private_ip_address              = "10.0.2.5"
    size                            = "Standard_B1s"
    admin_username                  = "azureuser"
    admin_password                  = "P@ssw0rd1234!"
    disable_password_authentication = false
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
  starbucks_vm1 = {
    os_type                         = "linux"
    name                            = "Starbucks-VM-01"
    nic_name                        = "starbucks-vm-01-nic"
    location                        = "uksouth"
    resource_group_name             = "dev-insiders-rg"
    subnet_name                     = "dev-insiders-starbucks-snet"
    virtual_network_name            = "dev-insiders-vnet"
    ip_config_name                  = "internal"
    private_ip_address_allocation   = "Static"
    private_ip_address              = "10.0.3.4"
    size                            = "Standard_B1s"
    admin_username                  = "azureuser"
    admin_password                  = "P@ssw0rd1234!"
    disable_password_authentication = false
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
  starbucks_vm2 = {
    os_type                         = "linux"
    name                            = "Starbucks-VM-02"
    nic_name                        = "starbucks-vm-02-nic"
    location                        = "uksouth"
    resource_group_name             = "dev-insiders-rg"
    subnet_name                     = "dev-insiders-starbucks-snet"
    virtual_network_name            = "dev-insiders-vnet"
    ip_config_name                  = "internal"
    private_ip_address_allocation   = "Static"
    private_ip_address              = "10.0.3.5"
    size                            = "Standard_B1s"
    admin_username                  = "azureuser"
    admin_password                  = "P@ssw0rd1234!"
    disable_password_authentication = false
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
}

bastion = {
  name                 = "dev-insiders-bastion"
  location             = "uksouth"
  resource_group_name  = "dev-insiders-rg"
  subnet_name          = "AzureBastionSubnet"
  virtual_network_name = "dev-insiders-vnet"
  pip_name             = "dev-insiders-bastion-pip"
}

application_gateway = {
  name                 = "dev-insiders-appgw"
  location             = "uksouth"
  resource_group_name  = "dev-insiders-rg"
  subnet_name          = "dev-insiders-appgw-snet"
  virtual_network_name = "dev-insiders-vnet"
  pip_name             = "dev-insiders-appgw-pip"
  sku_name             = "Standard_v2"
  sku_tier             = "Standard_v2"
  capacity             = 2
  sites = {
    netflix = {
      host_name            = "netflix.test.online"
      backend_ip_addresses = ["10.0.2.4", "10.0.2.5"]
      backend_port         = 80
      priority             = 100
    }
    starbucks = {
      host_name            = "starbucks.test.online"
      backend_ip_addresses = ["10.0.3.4", "10.0.3.5"]
      backend_port         = 80
      priority             = 110
    }
  }
}
