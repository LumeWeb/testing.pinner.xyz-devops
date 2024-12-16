resource "cloudns_dns_record" "renterd" {
  name  = module.renterd.dns_fqdn
  zone  = var.domain_zone
  type  = "CNAME"
  value = module.renterd.provider_host
  ttl   = "600"
}

resource "cloudns_dns_record" "renterd_s3" {
  name  = module.renterd.s3_fqdn
  zone  = var.domain_zone
  type  = "CNAME"
  value = module.renterd.provider_host
  ttl   = "600"
}
