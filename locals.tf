locals {
  # Common default resource tags
  default_tags = {
    github_demo_resource = "true"
    environment          = var.environment_name
  }

  # Kubernetes Cluster
  aks_cluster_dns_prefix = var.dns_prefix == null ? var.cluster_name : var.dns_prefix

  # Application Gateway
  backend_address_pool_name      = "${azurerm_virtual_network.application_gateway.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.application_gateway.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.application_gateway.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.application_gateway.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.application_gateway.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.application_gateway.name}-rqrt"
}