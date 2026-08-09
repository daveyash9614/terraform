locals {
  frontend_ip_name   = "appgw-frontend-ip"
  frontend_port_name = "port-80"
}

resource "azurerm_application_gateway" "appgw" {
  name                = var.application_gateway.name
  resource_group_name = var.application_gateway.resource_group_name
  location            = var.application_gateway.location

  sku {
    name     = var.application_gateway.sku_name
    tier     = var.application_gateway.sku_tier
    capacity = var.application_gateway.capacity
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = data.azurerm_subnet.appgw_subnet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_name
    public_ip_address_id = data.azurerm_public_ip.appgw_pip.id
  }

  dynamic "backend_address_pool" {
    for_each = var.application_gateway.sites
    content {
      name         = "${backend_address_pool.key}-pool"
      ip_addresses = backend_address_pool.value.backend_ip_addresses
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.application_gateway.sites
    content {
      name                  = "${backend_http_settings.key}-http-settings"
      cookie_based_affinity = "Disabled"
      port                  = backend_http_settings.value.backend_port
      protocol              = "Http"
      request_timeout       = 30
    }
  }

  dynamic "http_listener" {
    for_each = var.application_gateway.sites
    content {
      name                           = "${http_listener.key}-listener"
      frontend_ip_configuration_name = local.frontend_ip_name
      frontend_port_name             = local.frontend_port_name
      protocol                       = "Http"
      host_name                      = http_listener.value.host_name
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.application_gateway.sites
    content {
      name                       = "${request_routing_rule.key}-rule"
      rule_type                  = "Basic"
      http_listener_name         = "${request_routing_rule.key}-listener"
      backend_address_pool_name  = "${request_routing_rule.key}-pool"
      backend_http_settings_name = "${request_routing_rule.key}-http-settings"
      priority                   = request_routing_rule.value.priority
    }
  }
}
