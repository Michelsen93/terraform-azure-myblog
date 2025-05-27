variable "rg_name" {
  description = "Resource group name"
  type        = string
}
variable "name" {
  description = "name of server"
  type        = string
}
variable "location" {
  description = "location"
  type        = string
}
variable "pg_flex_username" {
  description = "username PG database"
  type        = string
  sensitive   = true
}
variable "pg_flex_password" {
  description = "password PG database"
  type        = string
  sensitive   = true
}
