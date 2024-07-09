variable "location" {}

variable "rg_name" {}

variable "log_analytics_workspace_name" {
  default = "log-analytics-workspace-9257"
}

variable "recovery_services_vault_name" {
  default = "recovery-service-vault-9257"
}

variable "storage_account_name" {
  default = "n01649257sa"
}

variable "common_tags" {}
