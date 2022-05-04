
provider "azurerm" {
  features {}
}

module "azure" {
  source = "../"

  resource_group_name = "testing-001"
  resource_tags = {
    prototype = "true"
  }
  cluster_name = "aks-testing-001"
}

output "aks_cluster" {
  value     = module.azure.aks_cluster
  sensitive = true
}
