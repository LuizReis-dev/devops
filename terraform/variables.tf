variable "resource_group_name" {
  type        = string
  description = "Nome do resource group"
  default     = "rg-exercicio1"
}

variable "location" {
  type        = string
  description = "Região do Azure onde os recursos serão criados"
  default     = "centralus"
}

variable "admin_username" {
  type        = string
  description = "Usuário administrador da VM"
  default     = "adminuser"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Caminho para a chave pública SSH"
  default     = "~/.ssh/id_rsa.pub"
}

variable "vm_sizes" {
  type        = list(string)
  description = "Lista de tamanhos de VM disponíveis"
  default = [
    "Standard_D2s_v3",
    "Standard_D2s_v3",
    "Standard_D2as_v4",
  ]
}

variable "vm_size_index" {
  type        = number
  description = "Índice da lista vm_sizes a ser usado"
  default     = 0
}
