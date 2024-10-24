data "azurerm_resource_group" "rg-tfworkshops" {
  name = "Terraform-workshops"
}

locals {
  location = "germanywestcentral"
}

resource "azurerm_virtual_network" "vn" {
  resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name
  location            = local.location

  name          = "${var.prefix}-${var.env_prefix}-vn"
  address_space = ["10.0.0.0/8"]
}

module "aks" {
  source = "./modules/aks"

  prefix = var.prefix
  env_prefix = var.env_prefix
  resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name
  virtual_network_name = azurerm_virtual_network.vn.name
  location = local.location

  depends_on = [ azurerm_virtual_network.vn ]
}

module "postgres" {
  source = "./modules/postgres"

  prefix = var.prefix
  env_prefix = var.env_prefix
  resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name
  virtual_network_name = azurerm_virtual_network.vn.name

  postgres_admin_password = var.postgres_admin_password
  server_zone = 1

  depends_on = [ azurerm_virtual_network.vn ]
}

module "datahub" {
  source = "./modules/datahub"

  datahub-prerequisites-values-file = var.datahub-prerequisites-values-file
  datahub-values-file               = var.datahub-values-file
  neo4j_username                    = var.neo4j_username
  neo4j_password                    = var.neo4j_password
  postgres_password                 = module.postgres.admin_password
  postgres_flexible_server_id       = module.postgres.server_id
  postgres_db_name                  = var.postgres_db_name
  postgres_fqdn                     = module.postgres.fqdn
  postgres_login                    = module.postgres.admin_login
  datahub_root_user                 = var.datahub_root_user
  datahub_root_user_password        = var.datahub_root_user_password

  depends_on = [module.aks, module.postgres]
}
