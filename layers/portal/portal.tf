# Portal
module "portal" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/service/portal?ref=develop"

  count = 1

  name = "portal"
  image = "ghcr.io/lumeweb/akash-portal:core-next"

  domain      = local.base_domain
  portal_name = var.portal_name
  port        = var.portal_port
  cluster     = true

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

  mail = {
    host     = var.portal_mail_host
    username = var.portal_mail_username
    password = var.portal_mail_password
    from     = var.portal_mail_from
    ssl      = var.portal_mail_ssl
  }

  storage = {
    s3 = {
      buffer_bucket = var.portal_buffer_bucket
      endpoint      = local.s3_endpoint
      region        = var.portal_buffer_region
      access_key    = var.portal_buffer_access_key
      secret_key    = var.portal_buffer_secret_key
    }
    sia = {
      key     = var.renterd_api_password
      cluster = true
      url     = "http://${module.renterd_cluster.bus.dns_fqdn}"
    }
  }

  database = {
    type     = "mysql"
    host     = module.mysql.provider_host
    port     = module.mysql.port
    username = "root"
    password = var.mysql_root_password
    name     = var.mysql_database
  }

  etcd = {
    endpoints = [local.core_state.etcd_endpoint]
    username = "root"
    password = local.core_state.etcd_password
    prefix   = "portal"
  }

  redis = {
    address = module.redis.endpoint
    password = var.redis_password
  }

  environment          = local.environment
  placement_attributes = local.placement_attributes
  allowed_providers    = var.allowed_providers
  extra_env_vars = {
    CLOUDNS_AUTH_ID: var.cloudns_auth_id
    CLOUDNS_AUTH_PASSWORD: var.cloudns_auth_password
  }
}
