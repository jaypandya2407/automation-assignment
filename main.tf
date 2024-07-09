module "rgroup-n01649257" {
  source = "./modules/rgroup-n01649257"

  rg_name = "n01649257-RG"
  location        = "Canada Central"
  common_tags     = var.common_tags
}

module "network-n01649257" {
  source = "./modules/network-n01649257"

  rg_name                       = module.rgroup-n01649257.rg_name
  location                      = module.rgroup-n01649257.location
  virtual_network_name          = "n01649257-VNET"
  virtual_network_address_space = ["10.0.0.0/16"]
  subnet_name                   = "n01649257-SUBNET"
  subnet_address                = ["10.0.0.0/24"]
  network_security_group_name   = "n01649257-NSG"
  common_tags                   = var.common_tags
}

module "common_services-n01649257" {
  source = "./modules/common_services-n01649257"

  location                     = module.rgroup-n01649257.location
  rg_name              	       = module.rgroup-n01649257.rg_name
  log_analytics_workspace_name = "n01649257-log-analytics-workspace"
  recovery_services_vault_name = "n01649257-recovery-service-vault"
  storage_account_name         = "n01649257sa"
  common_tags                  = var.common_tags
}

module "vmlinux-n01649257" {
  source = "./modules/vmlinux-n01649257"

  linux_name = { "n01649257-c-vm1" : "Standard_B1ms",
    "n01649257-c-vm2" : "Standard_B1ms",
    "n01649257-c-vm3" : "Standard_B1ms" }
  vm_size                      = "Standard_B1ms"
  admin_username               = "n01649257"
  public_key_path              = "/home/n01649257/.ssh/id_rsa.pub"
  private_key_path             = "/home/n01649257/.ssh/id_rsa"
  os_disk_storage_account_type = "Standard_LRS"
  os_disk_size                 = 32
  os_disk_caching              = "ReadWrite"
  os_publisher                 = "OpenLogic"
  os_offer                     = "CentOS"
  os_sku                       = "8_2"
  os_version                   = "latest"
  linux_avs                    = "n01649257-linux-avs"
  location                     = module.rgroup-n01649257.location
  rg_name                      = module.rgroup-n01649257.rg_name
  subnet_id                    = module.network-n01649257.subnet_id
  storage_account_uri          = module.common_services-n01649257.storage_account_uri
  common_tags                  = var.common_tags
}

module "vmwindows-n01649257" {
  source = "./modules/vmwindows-n01649257"

  windows_admin_username               = "n01649257"
  windows_admin_password               = "N@01649257"
  windows_os_disk_storage_account_type = "StandardSSD_LRS"
  windows_os_disk_size                 = 128
  windows_os_disk_caching              = "ReadWrite"
  windows_os_publisher                 = "MicrosoftWindowsServer"
  windows_os_offer                     = "WindowsServer"
  windows_os_sku                       = "2016-Datacenter"
  windows_os_version                   = "latest"
  windows_avs                          = "n01649257-windows-avs"
  windows_name                         = "n01649257-w-vm"
  windows_size                         = "Standard_B1ms"
  rg_name                              = module.rgroup-n01649257.rg_name
  location                             = module.rgroup-n01649257.location
  subnet_id                            = module.network-n01649257.subnet_id
  nb_count                             = 1
  common_tags                          = var.common_tags
}

module "datadisk-n01649257" {
  source = "./modules/datadisk-n01649257"

  vm_ids          = concat(module.vmlinux-n01649257.linux_id, module.vmwindows-n01649257.windows_id)
  rg_name         = module.rgroup-n01649257.rg_name
  location        = module.rgroup-n01649257.location
  common_tags     = var.common_tags
}

module "loadbalancer-n01649257" {
  source = "./modules/loadbalancer-n01649257"

  linux_vm_ids   = module.vmlinux-n01649257.linux_id
  linux_nic_ids  = module.vmlinux-n01649257.linux_nic_id
  linux_hostname = module.vmlinux-n01649257.linux_hostname
  resource_group = module.rgroup-n01649257.rg_name
  location       = module.rgroup-n01649257.location
  common_tags    = var.common_tags
}

module "database-n01649257" {
  source = "./modules/database-n01649257"

  rg_name         = module.rgroup-n01649257.rg_name
  location        = module.rgroup-n01649257.location
  server_name     = "n01649257-postgresql-server"
  admin_username  = "psqladmin"
  admin_password  = "N@01649257"
  database_name   = "n01649257-database"
  common_tags     = var.common_tags
}

variable "common_tags" {
  type = map(string)
  default = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Jay.Pandya"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

