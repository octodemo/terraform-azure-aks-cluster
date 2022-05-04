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

variable "aks_default_os_disk_size_gb" {
  type        = number
  description = "The VM OS disk size"
  default     = 40
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

variable "aks_dns_service_ip" {
  type        = string
  description = "DNS server IP address"
  default     = "10.0.0.10"
}

variable "aks_service_cidr" {
  type        = string
  description = "CIDR notation IP range from which to assign service cluster IPs"
  default     = "10.0.0.0/16"
}

variable "aks_docker_bridge_cidr" {
  type        = string
  description = "CIDR notation IP for Docker bridge."
  default     = "172.17.0.1/16"
}

variable "kubernetes_version" {
  type        = string
  description = "The kubernetes version for the cluster"
  default     = "1.23.3"
  #TODO make this a list of options
}


variable "app_gateway_vnet_address_prefix" {
  type    = string
  default = "10.100.0.0/16"
}

variable "app_gateway_aks_subnet_address_prefix" {
  type    = string
  default = "10.100.0.0/17"
}

variable "app_gateway_gateway_subnet_address_prefix" {
  type    = string
  default = "10.100.128.0/17"
}

variable "app_gateway_sku" {
  type    = string
  default = "Standard_v2"
  #options: [Standard_Small Standard_Medium Standard_Large Standard_v2 WAF_Large WAF_Medium WAF_v2]
}

variable "app_gateway_sku_tier" {
  type    = string
  default = "Standard_v2"
}

variable "app_gateway_static_ip_sku" {
  type = string
  default = "Standard"
}
