
### azure variables ###

variable "arm_subscription_id" {
    type = string
    description = "azure subscription id for onboarding"
}

variable "arm_directory_id" {
    type = string
    description = "azure directory id for onboarding"
}

variable "arm_application_id" {
    type = string
    description = "azure application id for onboarding"
}

variable "arm_application_key" {
    type = string
    description = "azure application key for onboarding"
}

// below is vwan variable

variable "rg" {
    default = {
      name = "vWAN-RG"
      location = "West US 2"
  }
}
# variable "vwan_name" {
#     type = string
# }

variable "vwan_hub" {
    default = {
        name = "vwan_hub_us_west2"
        address_prefix = "10.252.0.0/24"
    }
}

variable "vpngw" {
    default = {
        name = "us_west_vpngw"
        asn = "65515"
    }
}

variable "vpn_site" {
    default = {
        asn = "64790"
        ip_address_1 = "1.2.3.4"
        ip_address_2 = "1.2.3.5"
        peering_address_1 = "169.254.254.1"
        peering_address_2 = "169.254.254.2"
    }
}

variable "vpn_connection" {
    default = {
    name1 = "vpn_conn1"
    name2 = "vpn_conn2"
    }
}

### aviatrix variables ###

# variable "ctr_ip" {
#     type = string
#     description = "controller ip address" 
# }

# variable "ctr_username" {
#     type = string 
#     description = "controller login username"
# }

# variable "ctr_password" {
#     type = string
#     description = "controller login password"
# }

# variable "arm_access_account_name" {
#     type = string
#     description = "aviatrix access account name on azure type"
# }

