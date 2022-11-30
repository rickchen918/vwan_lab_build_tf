terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.79.1"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.arm_subscription_id
  tenant_id       = var.arm_directory_id
  client_id       = var.arm_application_id
  client_secret   = var.arm_application_key
}

resource "azurerm_resource_group" "vWAN_RG" {
  name     = "vWAN_RG"
  location = "Australia Southeast"
}

resource "azurerm_virtual_wan" "vwan-ause" {
    location            = azurerm_resource_group.vWAN_RG.location
    resource_group_name = azurerm_resource_group.vWAN_RG.name
    name                = "vwan-ause"
    lifecycle {
    ignore_changes = [
      tags["CreatedDate"]
    ]
  }
}

module "vwan_aue1" {
    source = "./modules/vwan_building"
    rg_name = "vwan-aue1" // additiional rg
    rg_location = "Australia East"
    vwan_id = azurerm_virtual_wan.vwan-ause.id
    vwan_hub_name = "aue1-vwan-hub"
    vwan_hub_address_prefix = "10.254.21.0/24"
    vpngw_name = "aue1-vpngw"
    vpngw_asn = "65515" // vwan local asn 
    vpngw_bgp_custom_ip_0 = "169.254.21.9"
    vpngw_bgp_custom_ip_1 = "169.254.21.13"
    vpn_site_asn = "64793" // remote device asn
    vpn_site_ip_address_1 = "20.53.178.60"
    vpn_site_peering_address_1 = "169.254.21.10"
    vpn_site_ip_address_2 = "20.53.178.238"
    vpn_site_peering_address_2 = "169.254.21.14"
}

module "vwan_ause" {
    source = "./modules/vwan_building"
    rg_name = "vwan-ause"
    rg_location = "Australia Southeast"
    vwan_id = azurerm_virtual_wan.vwan-ause.id
    vwan_hub_name = "ause-vwan-hub"
    vwan_hub_address_prefix = "10.254.22.0/24"
    vpngw_name = "ause-1-vpngw"
    vpngw_asn = "65515" // vwan local asn 
    vpngw_bgp_custom_ip_0 = "169.254.21.9"
    vpngw_bgp_custom_ip_1 = "169.254.21.13"
    vpn_site_asn = "64792" // remote device asn
    vpn_site_ip_address_1 = "13.73.102.31"
    vpn_site_peering_address_1 = "169.254.21.10"
    vpn_site_ip_address_2 = "20.190.117.140"
    vpn_site_peering_address_2 = "169.254.21.14"
}

module "vwan_use1" {
    source = "./modules/vwan_building"
    rg_name = "vwan-use1"
    rg_location = "East US"
    vwan_id = azurerm_virtual_wan.vwan-ause.id
    vwan_hub_name = "use1-vwan-hub"
    vwan_hub_address_prefix = "10.254.23.0/24"
    vpngw_name = "use1-vpngw"
    vpngw_asn = "65515" // vwan local asn 
    vpngw_bgp_custom_ip_0 = "169.254.21.9"
    vpngw_bgp_custom_ip_1 = "169.254.21.13"
    vpn_site_asn = "64794" // remote device asn
    vpn_site_ip_address_1 = "40.76.135.15"
    vpn_site_peering_address_1 = "169.254.21.10"
    vpn_site_ip_address_2 = "40.88.218.25"
    vpn_site_peering_address_2 = "169.254.21.14"
}

module "vwan_usnc" {
    source = "./modules/vwan_building"
    rg_name = "vwan-usnc"
    rg_location = "North Central US"
    vwan_id = azurerm_virtual_wan.vwan-ause.id
    vwan_hub_name = "usnc-vwan-hub"
    vwan_hub_address_prefix = "10.254.26.0/24"
    vpngw_name = "usnc-vpngw"
    vpngw_asn = "65515" // vwan local asn 
    vpngw_bgp_custom_ip_0 = "169.254.21.9"
    vpngw_bgp_custom_ip_1 = "169.254.21.13"
    vpn_site_asn = "64796" // remote device asn
    vpn_site_ip_address_1 = "20.98.41.36"
    vpn_site_peering_address_1 = "169.254.21.10"
    vpn_site_ip_address_2 = "20.88.18.214"
    vpn_site_peering_address_2 = "169.254.21.14"
}

module "vwan_ussc" {
    source = "./modules/vwan_building"
    rg_name = "vwan-ussc"
    rg_location = "South Central US"
    vwan_id = azurerm_virtual_wan.vwan-ause.id
    vwan_hub_name = "ussc-vwan-hub"
    vwan_hub_address_prefix = "10.254.24.0/24"
    vpngw_name = "ussc-vpngw"
    vpngw_asn = "65515" // vwan local asn 
    vpngw_bgp_custom_ip_0 = "169.254.21.9"
    vpngw_bgp_custom_ip_1 = "169.254.21.13"
    vpn_site_asn = "64795" // remote device asn
    vpn_site_ip_address_1 = "13.85.193.173"
    vpn_site_peering_address_1 = "169.254.21.10"
    vpn_site_ip_address_2 = "52.153.222.28"
    vpn_site_peering_address_2 = "169.254.21.14"
}

module "vwan_usw2" {
    source = "./modules/vwan_building"
    rg_name = "vwan-usw2"
    rg_location = "West US 2"
    vwan_id = azurerm_virtual_wan.vwan-ause.id
    vwan_hub_name = "usw2-vwan-hub"
    vwan_hub_address_prefix = "10.254.25.0/24"
    vpngw_name = "usw2-vpngw"
    vpngw_asn = "65515" // vwan local asn 
    vpngw_bgp_custom_ip_0 = "169.254.21.9"
    vpngw_bgp_custom_ip_1 = "169.254.21.13"
    vpn_site_asn = "64798" // remote device asn
    vpn_site_ip_address_1 = "20.72.218.149"
    vpn_site_peering_address_1 = "169.254.21.10"
    vpn_site_ip_address_2 = "40.91.75.9"
    vpn_site_peering_address_2 = "169.254.21.14"
}