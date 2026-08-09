module "resource_groups" {
  source          = "../../modules/azurerm_resource_group"
  resource_groups = var.resource_groups
}

module "subnets" {
  depends_on = [module.virtual_networks]
  source     = "../../modules/azurerm_subnets"
  subnets    = var.subnets
}

module "virtual_networks" {
  depends_on       = [module.resource_groups]
  source           = "../../modules/azurerm_virtual_network"
  virtual_networks = var.virtual_networks
}

module "public_ips" {
  depends_on = [module.resource_groups]
  source     = "../../modules/azurerm_public_ip"
  public_ips = var.public_ips
}

module "virtual_machines" {
  depends_on       = [module.subnets, module.public_ips]
  source           = "../../modules/azurerm_virtual_machine"
  virtual_machines = var.virtual_machines
}

module "bastion" {
  depends_on = [module.subnets, module.public_ips]
  source     = "../../modules/azurerm_bastion_host"
  bastion    = var.bastion
}

module "application_gateway" {
  depends_on          = [module.subnets, module.public_ips, module.virtual_machines]
  source              = "../../modules/azurerm_application_gateway"
  application_gateway = var.application_gateway
}
