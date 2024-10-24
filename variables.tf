variable "prefix" {
  type = string
  description = "prefix value for all resources"
}

variable "env_prefix" {
  type = string
  description = "environment prefix for all resources"
}

variable "postgres_admin_password" {
  type = string
  sensitive = true
}

variable "postgres_server_zone" {
  type = string
  default = "2"
}