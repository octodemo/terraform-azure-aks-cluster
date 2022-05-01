variable "resource_group_name" {
  type        = string
  description = "The Azure resource group name to create to contain the AKS cluster"

  validation {
    condition     = length(trimspace(var.resource_group_name)) > 0
    error_message = "A valid resource group name must be provided."
  }
}

variable "region" {
  type        = string
  default     = "East US"
  description = "The Azure region for the Resource Group where instances will be created"

  validation {
    condition     = contains(["East US", "East US 2"], var.region)
    error_message = "The Azure region needs to be one of the approved choices."
  }
}

variable "resource_tags" {
  type        = map(string)
  default     = {}
  description = "Common resource tags to be added to any created Azure resources"
}

variable "cluster_name" {
  type        = string
  description = "The Azure Kubernetes cluster name"

  validation {
    condition     = length(trimspace(var.cluster_name)) > 0
    error_message = "A valid AKS cluster name must be provided."
  }
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS cluster"
  default     = null
  nullable    = true
}

variable "environment_name" {
  type        = string
  description = "The environment name"
  default     = "test"
}

variable "aks_default_node_pool_vm_size" {
  type        = string
  description = "The VM size of the VMs in the default node pool"
  default     = "Standard_DS2_v2"
  #TODO make this a list of options
}

variable "aks_default_node_pool_node_count" {
  type        = number
  description = "The number of nodes to create in the default node pool"
  default     = 1
}

variable "aks_default_node_pool_zones" {
  type        = list(string)
  description = "The zones to use for the default node pool"
  default     = ["1", "2"]
}

variable "kubernetes_version" {
  type        = string
  description = "The kubernetes version for the cluster"
  default     = "1.23.3"
  #TODO make this a list of options
}
