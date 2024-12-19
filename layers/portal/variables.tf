variable "allowed_providers" {
  description = "List of allowed Akash provider addresses"
  type = list(string)
}


variable "mysql_database" {
  description = "MySQL database"
  type        = string

  default = "portal"
}

variable "aws_bucket" {
  description = "AWS S3 bucket for backups"
  type        = string
}

# All sensitive credentials - no defaults
# Database credentials

# MySQL Configuration
variable "mysql_root_password" {
  description = "MySQL root password"
  type        = string
  sensitive   = true
}

variable "mysql_repl_password" {
  description = "MySQL replication password"
  type        = string
  sensitive   = true
}

# ProxySQL Configuration
variable "proxysql_admin_password" {
  description = "ProxySQL admin password"
  type        = string
  sensitive   = true
}


# Renterd Configuration
variable "renterd_seed" {
  description = "Seed for renterd instances"
  type        = string
  sensitive   = true
}

variable "renterd_api_password" {
  description = "API password for renterd instances"
  type        = string
  sensitive   = true
}

variable "renterd_metrics_password" {
  description = "Password for renterd metrics"
  type        = string
  sensitive   = true
}

# DNS Configuration
variable "domain_zone" {
  description = "ClouDNS zone for DNS records"
  type        = string
  default     = "pinner.xyz"
}

# Portal Configuration
variable "portal_name" {
  description = "Portal name"
  type        = string
}

variable "portal_domain" {
  description = "Portal domain"
  type        = string
  default     = "testing.pinner.xyz"
}

variable "portal_port" {
  description = "Portal core port"
  type        = number
  default     = 80
}

variable "portal_buffer_bucket" {
  description = "Portal buffer bucket"
  type        = string
  sensitive   = true
}

variable "portal_buffer_region" {
  description = "Portal buffer region"
  type        = string
  default       = "us-east-1"
}

variable "portal_buffer_access_key" {
  description = "Portal buffer access key"
  type        = string
  sensitive   = true
}

variable "portal_buffer_secret_key" {
  description = "Portal buffer secret key"
  type        = string
  sensitive   = true
}

variable "portal_mail_host" {
  description = "Portal mail host"
  type        = string
  sensitive   = true
}

variable "portal_mail_ssl" {
  description = "Portal mail SSL"
  type        = bool
  default     = true
}

variable "portal_mail_username" {
  description = "Portal mail username"
  type        = string
  sensitive   = true
}

variable "portal_mail_password" {
  description = "Portal mail password"
  type        = string
  sensitive   = true
}

variable "portal_mail_from" {
  description = "Portal mail from"
  type        = string
  sensitive   = true
}