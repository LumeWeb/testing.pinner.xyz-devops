# Infrastructure Config Variables
variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "testing"
}

variable "base_domain" {
  description = "Base domain for DNS records"
  type        = string
  default     = "testing.pinner.xyz"
}

variable "allowed_providers" {
  description = "List of allowed providers"
  type        = list(string)
  default     = []
}

# All sensitive credentials - no defaults
variable "cloudflare_api_token" {
  description = "Cloudflare API token for DNS management"
  type        = string
  sensitive   = true
}

variable "domain_zone_id" {
  description = "Cloudflare zone ID for DNS records"
  type        = string
}

# Database credentials
variable "etcd_root_password" {
  description = "Root password for etcd"
  type        = string
  sensitive   = true
}

variable "mysql_root_password" {
  description = "Root password for MySQL"
  type        = string
  sensitive   = true
}

# Renterd specific
variable "renterd_api_password" {
  description = "API password for Renterd"
  type        = string
  sensitive   = true
}

variable "renterd_seed" {
  description = "Seed for Renterd wallet"
  type        = string
  sensitive   = true
}

# Monitoring
variable "metrics_password" {
  description = "Password for metrics access"
  type        = string
  sensitive   = true
}