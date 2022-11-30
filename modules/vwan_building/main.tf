
resource "azurerm_resource_group" "vWAN_RG" {
  name     = var.rg_name
  location = var.rg_location
}

# resource "azurerm_virtual_wan" "default" {
#     location            = azurerm_resource_group.vWAN_RG.location
#     resource_group_name = azurerm_resource_group.vWAN_RG.name
#     name                = var.vwan_id
#     lifecycle {
#     ignore_changes = [
#       tags["CreatedDate"]
#     ]
#   }
# }

resource "azurerm_virtual_hub" "default" {
    location            = azurerm_resource_group.vWAN_RG.location
    resource_group_name = azurerm_resource_group.vWAN_RG.name
    virtual_wan_id      = var.vwan_id
    name                = var.vwan_hub_name
    address_prefix      = var.vwan_hub_address_prefix
    lifecycle {
    ignore_changes = [
      tags["CreatedDate"]
    ]
  }
}

resource "azurerm_vpn_gateway" "default" {
    location            = azurerm_resource_group.vWAN_RG.location
    resource_group_name = azurerm_resource_group.vWAN_RG.name
    virtual_hub_id      = azurerm_virtual_hub.default.id
    name                = var.vpngw_name
    bgp_settings {
        asn             = var.vpngw_asn
        peer_weight     = "0"
        instance_0_bgp_peering_address {
            custom_ips          = [
                var.vpngw_bgp_custom_ip_0,
            ]
        }
        instance_1_bgp_peering_address {
            custom_ips          = [
                var.vpngw_bgp_custom_ip_1,
            ]
        }
    }
    lifecycle {
    ignore_changes = [
      tags["CreatedDate"]
    ]
  }
}

// remore vpn peer address
resource "azurerm_vpn_site" "az_vpnsite_1" {
    location            = azurerm_resource_group.vWAN_RG.location
    resource_group_name = azurerm_resource_group.vWAN_RG.name
    virtual_wan_id      = var.vwan_id
    name                = "vpn_session1"
    link {
        name          = "vpn_link1"
        ip_address    = var.vpn_site_ip_address_1
        provider_name = "aviatrix"
        speed_in_mbps = "500"
        bgp {
            asn             = var.vpn_site_asn
            peering_address = var.vpn_site_peering_address_1
            
        }
    }
    lifecycle {
    ignore_changes = [
      tags["CreatedDate"]
    ]
  }
}

// remore vpn peer address
resource "azurerm_vpn_site" "az_vpnsite_2" {
    location            = azurerm_resource_group.vWAN_RG.location
    resource_group_name = azurerm_resource_group.vWAN_RG.name
    virtual_wan_id      = var.vwan_id
    name                = "vpn_session2"
    link {
        name          = "vpn_link2"
        ip_address    = var.vpn_site_ip_address_2
        provider_name = "aviatrix"
        speed_in_mbps = "500"
        bgp {
            asn             = var.vpn_site_asn
            peering_address = var.vpn_site_peering_address_2
        }
    }
    lifecycle {
    ignore_changes = [
      tags["CreatedDate"]
    ]
  }
}

resource "azurerm_vpn_gateway_connection" "az_vpngw_conn_1" {
    name               = var.vpn_connection_name1
    remote_vpn_site_id = azurerm_vpn_site.az_vpnsite_1.id
    vpn_gateway_id     = azurerm_vpn_gateway.default.id
    vpn_link {
        name = "vpn_conn_1"
        bgp_enabled                           = true
        local_azure_ip_address_enabled        = false
        shared_key                            = "aviatrix"
        vpn_site_link_id                      = azurerm_vpn_site.az_vpnsite_1.link[0].id

        ipsec_policy {
            dh_group                 = "DHGroup14"
            encryption_algorithm     = "AES256"
            ike_encryption_algorithm = "AES256"
            ike_integrity_algorithm  = "SHA256"
            integrity_algorithm      = "SHA256"
            pfs_group                = "PFS14"
            sa_data_size_kb          = "65536"
            sa_lifetime_sec          = "27000"
        }
    }
}

resource "azurerm_vpn_gateway_connection" "az_vpngw_conn_2" {
    name               = var.vpn_connection_name2
    remote_vpn_site_id = azurerm_vpn_site.az_vpnsite_2.id
    vpn_gateway_id     = azurerm_vpn_gateway.default.id
    vpn_link {
        name = "vpn_conn_1"
        bgp_enabled                           = true
        local_azure_ip_address_enabled        = false
        shared_key                            = "aviatrix"
        vpn_site_link_id                      = azurerm_vpn_site.az_vpnsite_2.link[0].id

        ipsec_policy {
            dh_group                 = "DHGroup14"
            encryption_algorithm     = "AES256"
            ike_encryption_algorithm = "AES256"
            ike_integrity_algorithm  = "SHA256"
            integrity_algorithm      = "SHA256"
            pfs_group                = "PFS14"
            sa_data_size_kb          = "65536"
            sa_lifetime_sec          = "27000"
        }
    }
}