#
# Defines our resource group and the Kubernetes cluster within it
#

resource "azurerm_resource_group" "aks_cluster_resource_group" {
  name     = var.resource_group_name
  location = var.region

  tags = merge(
    local.default_tags,
    var.resource_tags,
  )
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.cluster_name
  location            = azurerm_resource_group.aks_cluster_resource_group.location
  resource_group_name = azurerm_resource_group.aks_cluster_resource_group.name
  dns_prefix          = local.aks_cluster_dns_prefix

  kubernetes_version = var.kubernetes_version

  http_application_routing_enabled = false

  default_node_pool {
    name = "default"

    enable_auto_scaling = true
    node_count          = var.aks_default_node_pool_node_count
    min_count           = 1
    max_count           = 3

    vm_size = var.aks_default_node_pool_vm_size
    os_disk_size_gb = var.aks_default_os_disk_size_gb
    vnet_subnet_id  = azurerm_subnet.aks_cluster.id

    type  = "VirtualMachineScaleSets"
    zones = var.aks_default_node_pool_zones
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    dns_service_ip     = var.aks_dns_service_ip
    docker_bridge_cidr = var.aks_docker_bridge_cidr
    service_cidr       = var.aks_service_cidr
  }

  tags = merge(
    local.default_tags,
    var.resource_tags,
  )
}


data "azurerm_public_ip" "aks_cluster" {
  name                = reverse(split("/", tolist(azurerm_kubernetes_cluster.aks_cluster.network_profile.0.load_balancer_profile.0.effective_outbound_ips)[0]))[0]
  resource_group_name = azurerm_kubernetes_cluster.aks_cluster.node_resource_group
}
