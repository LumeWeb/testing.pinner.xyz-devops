
locals {
  base_domain = data.terraform_remote_state.remote_states.outputs.base_domain
  environment = data.terraform_remote_state.remote_states.outputs.environment
}

# MySQL Cluster
module "mysql_cluster" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/db/mysql-cluster?ref=develop"

  name = "portal-mysql-cluster"

  environment  = local.environment
  node_count = 2

  backups_enabled = false

  root_password = var.mysql_root_password
  repl_password = var.mysql_repl_password

  # ETCD Configuration
  etc_endpoints = [data.terraform_remote_state.remote_states.outputs.etcd_endpoint]

  etc_password = data.terraform_remote_state.remote_states.outputs.etcd_password

  # Resource Configuration
  node_resources = {
    cpu_units    = 2
    memory_size  = 4
    storage_size = 20
  }

  allowed_providers = var.allowed_providers
}

# ProxySQL
module "proxysql" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/db/proxysql?ref=develop"

  name = "portal-proxysql"

  environment = local.environment
  backup_enabled = false

  admin_password = var.proxysql_admin_password

  # Connect to ETCD
  etcd = {
    endpoints = [data.terraform_remote_state.remote_states.outputs.etcd_endpoint]
    password  = data.terraform_remote_state.remote_states.outputs.etcd_password
    prefix = module.mysql_cluster.etc_prefix
  }

  mysql = {
    repl_user = "repl"
    repl_password = var.mysql_repl_password
  }

  # Resource Configuration
  resources = {
    cpu = {
      cores = 1
    }
    memory = {
      size = 1
      unit = "Gi"
    }
    storage = {
      size = 10
      unit = "Gi"
    }
  }

  allowed_providers = var.allowed_providers

  depends_on = [module.mysql_cluster]
}

# Renterd Cluster
module "renterd_cluster" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/compute/renterd-cluster?ref=develop"

  name = "portal-renterd"

  environment = local.environment
  base_domain = local.base_domain

  # Authentication
  seed                = var.renterd_seed
  bus_api_password    = var.renterd_api_password
  worker_api_password = var.renterd_api_password
  metrics_password = var.renterd_metrics_password

  # MySQL Configuration via ProxySQL
  database = {
    type           = "mysql"
    uri = format("%s:%d", module.proxysql.provider_host, module.proxysql.port)
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

  depends_on = [module.proxysql]
}