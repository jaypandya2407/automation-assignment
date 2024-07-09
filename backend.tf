terraform {
  backend "azurerm" {
    resource_group_name   = "tfstaten01649257RG"
    storage_account_name  = "tfstaten01649257sa"
    container_name        = "tfstatefiles"
    key                   = "terraform.tfstate"
    access_key		  = ""
  }
}

