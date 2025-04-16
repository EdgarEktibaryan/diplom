# Description: This file contains variables for AKS cluster and its Resources 

### Azure

variable "region" {
  description = "Azure region to use"
  type        = string
  default     = "East US 2"
}

variable "resource_group" {
  description = "Azure region to use"
  type        = string
  default     = "diplom-aks-rg"
}

variable "tags" {
  description = "Tags to add"
  type        = map(string)
  default = {
    Environment = "Diplom",
    IAC         = "Terraform"
  }
}

## Provider

variable "azure_subscription_id" {
  description = "Azure portal subscription id"
  type        = string
}

variable "azure_tenant_id" {
  description = "Azure portal tenant id"
  type        = string
}

### VNET

# Public IP

variable "domain_name_label" {
  description = "domain name label to use"
  type        = string
  default     = "diplom-aks"
}

variable "tags_pubip" {
  description = "Tags to add to lb"
  type        = map(string)
  default = {
    Environment              = "Diplom",
    IAC                      = "Terraform",
    "aks-managed-cluster-name" = "diplom-aks"
    "aks-managed-cluster-rg"   = "diplom-aks-rg"
    "k8s-azure-cluster-name" = "kubernetes",
    "k8s-azure-service"      = "nginx/nginx-ingress-nginx-controller"
  }
}

### AKS

variable "identity_type" {
  description = "(Optional) The type of identity used for the managed cluster. Conflict with `client_id` and `client_secret`. Possible values are `SystemAssigned` and `UserAssigned`. If `UserAssigned` is set, a `user_assigned_identity_id` must be set as well."
  type        = string
  default     = "UserAssigned"
}

# CF

variable "cf_api_token" {
  description = "CF token to Authenticate and Authorize in CloudFlare to make changes in DNS zone"
  type        = string
}

variable "cf_zone_id" {
  description = "Cloudflare zone ID"
  type        = string
}

variable "cf_zone_name" {
  description = "Cloudflare zone name"
  type        = string
}

variable "cf_record_type" {
  description = "Cloudflare record type"
  type        = string
  default     = "CNAME"
}

variable "cf_record_ttl" {
  description = "Cloudflare record TTL"
  type        = number
  default     = 1
}

variable "cf_proxy_status" {
  type        = bool
  description = "Cloudflare proxy status"
  default     = true
}

variable "cf_dns_records_list" {
  type = list(string)
  default = [
    "argocd",
    "node-app-v1",
    "node-app-v2"
  ]
}

variable "argocd_webhook_secret" {
  description = "Secret for Argo and Github communication to send webhooks"
  type        = string
}