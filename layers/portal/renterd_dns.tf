resource "cloudns_dns_record" "portal" {
  name  = "@"
  zone  = var.domain_zone
  type  = "A"
  value = module.portal.ip_address
  ttl   = "600"
}