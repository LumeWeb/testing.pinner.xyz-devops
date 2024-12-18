# MySQL

module "mysql" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/db/mysql?ref=develop"

  name              = "mysql"

  root_password     = var.mysql_root_password
  environment  = local.environment
  backups_enabled   =  false

  resources = {
    cpu = {
      cores = 2
    }
    memory = {
      size = 4
      unit = "Gi"
    }
    storage = {
      size = 10
      unit = "Gi"
    }
    persistent_storage = {
      size  = 20
      unit  = "Gi"
      class = "beta3"
    }
  }

  allowed_providers = var.allowed_providers
  placement_attributes = local.placement_attributes
}

# Renterd Cluster
module "renterd_cluster" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/compute/renterd-cluster?ref=develop"

  name = "portal-renterd"

  environment = local.environment
  base_domain = local.renterd_base_domain

  # Authentication
  seed                = var.renterd_seed
  bus_api_password    = var.renterd_api_password
  worker_api_password = var.renterd_api_password
  metrics_password = var.renterd_metrics_password

  # MySQL Configuration via ProxySQL
  database = {
    type           = "mysql"
    uri = format("%s:%d", module.mysql.provider_host, module.mysql.port)
    password = var.mysql_root_password
  }

  # Resource Configuration
  bus_cpu_cores    = 2
  bus_memory_size  = 4
  bus_storage_size = 100

  autopilot_cpu_cores    = 2
  autopilot_memory_size  = 4

  worker_cpu_cores   = 2
  worker_memory_size = 4
  worker_count       = 1

  allowed_providers = var.allowed_providers
  placement_attributes = local.placement_attributes

  depends_on = [module.mysql]
}