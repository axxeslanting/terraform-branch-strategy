output "admin_login" {
  value = var.postgres_admin_login
}

output "admin_password" {
  sensitive = true
  value = var.postgres_admin_password
}

output "fqdn" {
  value = azurerm_postgresql_flexible_server.postgres.fqdn
}

output "server_id" {
  value = azurerm_postgresql_flexible_server.postgres.id
}
