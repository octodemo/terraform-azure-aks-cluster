# terraform-azure-aks-cluster

A terraform module for creating an Azure AKS cluster.

## Variables

The variables for the module can be found in the [variables.tf](./variables.tf) file.

* `resource_group_name`
* `region`
* `resource_tags`: Default tags to apply to the resources (will be merged with predefined tags in the module for each resource)
* `cluster_name`: The name of the AKS cluster
* `dns_prefix`: Optional DNS prffix fo the cluster, if not specified the `cluster_name` will be used
* `environment_name`:Optional name of the environment for the cluster defaults to `test`
* `aks_default_node_pool_vm_size`: Optional Azure VM size for the nodes in node pool, defaults to `Standard_DS2_v2`
* `aks_default_node_pool_node_count`: Optional number of nodes in the pool, defaults to `1`
* `aks_default_node_pool_zones`: Optional list of zones for the node pool, defaults to `["1", "2"]`
* `kubernetes_version`: Optional version of kubernetes for the cluster, defaults to `1.23.3`