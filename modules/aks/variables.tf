variable "rg_name" {
    description = "Resource group name"
    type = string
}
variable "location" {
    description = "location"
    type = string
}

variable "dns_prefix" {
    description = "prefix of dns"
    type = string
}

variable "subnet_id" {
  description = "subnet"
  type = string
}
