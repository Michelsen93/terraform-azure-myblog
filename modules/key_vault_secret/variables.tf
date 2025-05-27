variable "value" {
  description = "value of secret"
  type = string
  sensitive = true
}
variable "name" {
  description = "name of secret"
  type = string
}

variable "key_vault_id" {
  description = "id of keyvault to place secret"
  type = string
}

