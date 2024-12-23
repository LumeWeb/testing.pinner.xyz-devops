module "mysql" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/db/mysql?ref=develop"

  name              = "mysql"
  allowed_providers = var.allowed_providers
  root_password     = var.mysql_root_password
  environment       = var.environment
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

  placement_attributes = local.placement_attributes
}