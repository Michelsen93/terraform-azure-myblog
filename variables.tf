variable "image_tag" {
  description = "Docker --tag name for my-blog"
  type        = string
}

variable "registry_username" {
  description = "Azure Container Registry username"
  type        = string
}

variable "registry_password" {
  description = "Azure Container Registry password"
  type        = string
  sensitive   = true
}

variable "storage_account_access_key" {
  description = "Storage account access key"
  type        = string
  sensitive   = true
}

variable "storage_account_name" {
  description = "Storage account name"
  type        = string
}

variable "my_blog_instrumentation_key" {
  description = "Key for instrumentation for my blog wep app"
  type        = string
  sensitive   = true
}

variable "functions_instrumentation_key" {
  description = "Instrumentation key for hello world function"
  type        = string
  sensitive   = true
}

variable "az_sub_id" {
  description = "ID of azure subscription"
  type        = string
  sensitive   = true
}

variable "storage_account_key" {
  description = "key to storage account"
  type        = string
  sensitive   = true
}
