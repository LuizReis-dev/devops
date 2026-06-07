output "ip_publico_vm" {
  description = "IP público da VM"
  value       = azurerm_public_ip.ip.ip_address
}
