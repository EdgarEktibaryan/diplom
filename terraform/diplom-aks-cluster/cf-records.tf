# Description: This file contains the cloudflare DNS record Resources for the AKS cluster

# DNS Records for AKS
# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record
resource "cloudflare_dns_record" "cf_aks_dns_records" {
  for_each = toset(var.cf_dns_records_list)
  name    = "${each.key}.${var.cf_zone_name}"
  content = "${var.domain_name_label}.${azurerm_public_ip.diplom_aks_pip.location}.cloudapp.azure.com"
  proxied = var.cf_proxy_status
  zone_id = var.cf_zone_id
  type    = var.cf_record_type
  ttl     = var.cf_record_ttl
}