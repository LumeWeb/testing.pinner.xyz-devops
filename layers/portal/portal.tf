# Portal
module "portal" {
  source = "../terraform-modules/modules/service/portal"

  count = 1

  name = "portal"

  domain = local.base_domain
  portal_name = "portal"
  port = 80

  image = "ghcr.io/lumeweb/akash-portal:base-latest"

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
  }

  mail = {
    host     = "mail.example.com"
    username = "username"
    password = "password"
    from     = "from@example.com"
  }

  storage = {
    s3 = {
      buffer_bucket = "buffer-bucket"
      endpoint     = "https://s3.example.com"
      region       = "region"
      access_key   = "access-key"
      secret_key   = "secret-key"
    }
    sia = {
      key     = "sia-key"
      cluster = false
      url     = "https://sia.example.com"
    }
  }

  database = {
    type     = "mysql"
    host     = module.mysql.provider_host
    port     = module.mysql.port
    username = "username"
    password = "password"
    name     = "database"
  }

  environment = local.environment
  placement_attributes = local.placement_attributes
  allowed_providers = var.allowed_providers
  tags = {
    service = "portal"
    environment = local.environment
  }
  extra_env_vars = {}
}
