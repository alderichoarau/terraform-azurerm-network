variable "name" {
  description = "Base name used to build the VNet and NSG resource names (e.g. vnet-<name>, nsg-frontend-<name>)"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,58}[a-z0-9]$", var.name))
    error_message = "name must be lowercase, letters, digits and hyphens only (2-60 chars)."
  }
}

variable "resource_group_name" {
  description = "Name of the Resource Group to deploy into"
  type        = string
}

variable "location" {
  description = "Azure region for the VNet, subnets and NSGs"
  type        = string
}

variable "address_space" {
  description = "Address space of the VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "frontend_subnet_prefix" {
  description = "Address prefix of subnet-frontend"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "backend_subnet_prefix" {
  description = "Address prefix of subnet-backend"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "frontend_allowed_ports" {
  description = "TCP ports allowed inbound from the internet on subnet-frontend"
  type        = list(string)
  default     = ["80", "443"]
}

variable "tags" {
  description = "Tags applied to all resources in this module"
  type        = map(string)
  default     = {}
}
