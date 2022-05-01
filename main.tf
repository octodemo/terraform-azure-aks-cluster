terraform {
  required_version = "~>1.1.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  default_tags = {
    github_demo_resource = "true"
    environment          = var.environment_name
  }

  dns_prefix = var.dns_prefix == null ? var.cluster_name : var.dns_prefix
}

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
  dns_prefix          = local.dns_prefix

  kubernetes_version = var.kubernetes_version

  default_node_pool {
    name = "default"

    enable_auto_scaling = true
    node_count          = var.aks_default_node_pool_node_count
    min_count           = 1
    max_count           = 3

    vm_size = var.aks_default_node_pool_vm_size

    type  = "VirtualMachineScaleSets"
    zones = var.aks_default_node_pool_zones
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
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
