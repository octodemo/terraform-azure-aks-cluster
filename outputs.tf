output "aks_cluster" {
  value = {
    resource_group     = azurerm_resource_group.aks_cluster_resource_group.name
    cluster_name       = azurerm_kubernetes_cluster.aks_cluster.name
    egress_ip          = data.azurerm_public_ip.aks_cluster.ip_address
    client_certificate = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate
    kube_config        = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  }
  sensitive = true
}
