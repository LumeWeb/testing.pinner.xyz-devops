# Redis
module "redis" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/db/valkey?ref=develop"

  name = "redis"

  image = "ghcr.io/lumeweb/akash-valkey:develop"

  resources = {
    cpu = {
      cores = 2
    }
    memory = {
      size = 4
      unit = "Gi"
    }
    storage = {
      size = 1
      unit = "Gi"
    }
  }

  valkey_config = {
    port             = 6379
    bind             = "0.0.0.0"
    maxmemory        = 0
    maxmemory_policy = "noeviction"
    appendonly       = false
    requirepass      = var.redis_password
  }

  backup_config = {
    enabled = false
  }

  environment          = local.environment
  placement_attributes = local.placement_attributes
  allowed_providers    = var.allowed_providers
  tags = {
    service = "redis"
    environment = local.environment
  }
}
