resource "null_resource" "test" {
  
}

data "azurerm_resource_group" "tfworkshops" {
  name = "Terraform-workshops"
}