variable "location" {
  type = string
}
variable "rg_name" {
  description = "name of resource group"
  type        = string
}

variable "tenant_id" {
  description = "id of tenant"
  type        = string
}
variable "name" {
  description = "name of vault"
  type        = string
}
