provider "azurerm"{
 features {}
 tenant_id = "d834093e-d255-4be5-acc8-e4b90caeb624"
}
terraform {
 required_providers {
        azurerm = {
         source = "hashicorp/azurerm"
         version = ">= 3.54.0"
         }
}
required_version = ">= 1.4.6"
}


