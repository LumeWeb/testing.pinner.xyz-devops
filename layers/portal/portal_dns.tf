resource "cloudns_dns_record" "portal" {
  count = length(module.portal)
  name  = "@"
  zone  = var.domain_zone
  type  = "A"
  value = module.portal[count.index].ip_address
  ttl   = "600"
}