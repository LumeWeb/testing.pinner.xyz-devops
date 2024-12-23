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

variable "domain_zone" {
  description = "ClouDNS zone for DNS records"
  type        = string
  default = "pinner.xyz"
}

# All sensitive credentials - no defaults
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
# Monitoring
variable "admin_password" {
  description = "Password for admin access"
  type        = string
  sensitive   = true
}

variable "metrics_password" {
  description = "Password for metrics access"
  type        = string
  sensitive   = true
}