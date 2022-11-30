// below is vwan variable

variable "rg_name" {}
variable "rg_location" {}

variable "vwan_id" {}

variable "vwan_hub_name" {}
variable "vwan_hub_address_prefix" {}

variable "vpngw_name" {}
variable "vpngw_asn" {}
variable "vpngw_bgp_custom_ip_0" {}
variable "vpngw_bgp_custom_ip_1" {}

variable "vpn_site_asn" {}
variable "vpn_site_ip_address_1" {}
variable "vpn_site_peering_address_1" {}
variable "vpn_site_ip_address_2" {}
variable "vpn_site_peering_address_2" {}

variable "vpn_connection_name1" {
    default = "vpn_conn1"
}

variable "vpn_connection_name2" {
    default = "vpn_conn2"
}