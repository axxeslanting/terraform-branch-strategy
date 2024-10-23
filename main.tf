data "azurerm_resource_group" "rg-tfworkshops" {
  name = "Terraform-workshops"
}

resource "azurerm_virtual_network" "vn" {
  resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name
  location            = data.azurerm_resource_group.rg-tfworkshops.location

  name          = "${var.prefix}-${var.env_prefix}-vn"
  address_space = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "nodepool-sn" {
  name                 = "nodepool-sn"
  resource_group_name  = data.azurerm_resource_group.rg-tfworkshops.name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = ["10.1.0.0/16"]
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-${var.env_prefix}-aks"
  dns_prefix          = "${var.prefix}-${var.env_prefix}"
  location            = data.azurerm_resource_group.rg-tfworkshops.location
  resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name

  default_node_pool {
    name           = "default"
    node_count     = 3
    vm_size        = "Standard_D2_v3"
    type           = "VirtualMachineScaleSets"
    vnet_subnet_id = azurerm_subnet.nodepool-sn.id
  }

  identity {
    type = "SystemAssigned"
  }
}
