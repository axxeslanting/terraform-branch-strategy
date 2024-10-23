data "azurerm_resource_group" "rg-tfworkshops" {
  name = "Terraform-workshops"
}

resource "azurerm_virtual_network" "vn" {
  resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name
  location = data.azurerm_resource_group.rg-tfworkshops.location

  name = "${var.prefix}-${var.env_prefix}-vn"
  address_space = [ "10.0.0.0/24" ]
}