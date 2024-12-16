resource "cloudns_dns_record" "renterd_bus" {
  name  =module.renterd_cluster.bus.dns_fqdn
  zone  = var.domain_zone
  type  = "CNAME"
  value = module.renterd_cluster.bus.host
  ttl   = "600"
}

resource "cloudns_dns_record" "renterd_autopilot" {
  name  = module.renterd_cluster.autopilot.dns_fqdn
  zone  = var.domain_zone
  type  = "CNAME"
  value = module.renterd_cluster.autopilot.host
  ttl   = "600"
}

resource "cloudns_dns_record" "renterd_workers" {
  count = length(module.renterd_cluster.workers)
  name  = module.renterd_cluster.workers[count.index].dns_fqdn
  zone  = var.domain_zone
  type  = "CNAME"
  value = module.renterd_cluster.workers[count.index].host
  ttl   = "600"
}