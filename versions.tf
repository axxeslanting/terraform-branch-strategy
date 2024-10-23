terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.6.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "Terraform-workshops"                  # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "axxesworkshoptfstates"                # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"                             # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    # key                  = "lorenzo-dev.terraform.tfstate"        # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
    use_oidc              = true                                   # Can also be set via `ARM_USE_MSI` environment variable.
  }
}