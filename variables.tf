variable "instance" {
  description = "describes logic app standard configuration"
  type = object({
    name                                     = string
    resource_group_name                      = optional(string)
    location                                 = optional(string)
    app_service_plan_id                      = string
    storage_account_name                     = string
    storage_account_access_key               = string
    app_settings                             = optional(map(string))
    use_extension_bundle                     = optional(bool, true)
    bundle_version                           = optional(string, "[1.*, 2.0.0)")
    client_affinity_enabled                  = optional(bool)
    client_certificate_mode                  = optional(string)
    enabled                                  = optional(bool, true)
    ftp_publish_basic_authentication_enabled = optional(bool, true)
    https_only                               = optional(bool, false)
    public_network_access                    = optional(string, "Enabled")
    scm_publish_basic_authentication_enabled = optional(bool, true)
    storage_account_share_name               = optional(string)
    version                                  = optional(string, "~4")
    virtual_network_subnet_id                = optional(string)
    vnet_content_share_enabled               = optional(bool, false)
    tags                                     = optional(map(string))
    connection_strings = optional(map(object({
      name  = string
      type  = string
      value = string
    })), {})
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    site_config = optional(object({
      always_on                         = optional(bool, false)
      app_scale_limit                   = optional(number)
      auto_swap_slot_name               = optional(string)
      dotnet_framework_version          = optional(string, "v4.0")
      elastic_instance_minimum          = optional(number)
      ftps_state                        = optional(string, "AllAllowed")
      health_check_path                 = optional(string)
      http2_enabled                     = optional(bool, false)
      ip_restriction_default_action     = optional(string)
      linux_fx_version                  = optional(string)
      min_tls_version                   = optional(string, "1.2")
      pre_warmed_instance_count         = optional(number)
      runtime_scale_monitoring_enabled  = optional(bool, false)
      scm_ip_restriction_default_action = optional(string)
      scm_min_tls_version               = optional(string, "1.2")
      scm_type                          = optional(string, "None")
      scm_use_main_ip_restriction       = optional(bool, false)
      use_32_bit_worker_process         = optional(bool, true)
      vnet_route_all_enabled            = optional(bool)
      websockets_enabled                = optional(bool)
      cors = optional(object({
        allowed_origins     = optional(list(string), [])
        support_credentials = optional(bool, false)
      }))
      ip_restrictions = optional(map(object({
        ip_address                = optional(string)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        name                      = optional(string)
        priority                  = optional(number, 65000)
        action                    = optional(string, "Allow")
        description               = optional(string)
        headers = optional(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(string))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        }))
      })), {})
      scm_ip_restrictions = optional(map(object({
        ip_address                = optional(string)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        name                      = optional(string)
        priority                  = optional(number, 65000)
        action                    = optional(string, "Allow")
        description               = optional(string)
        headers = optional(object({
          x_azure_fdid      = optional(list(string))
          x_fd_health_probe = optional(list(string))
          x_forwarded_for   = optional(list(string))
          x_forwarded_host  = optional(list(string))
        }))
      })), {})
    }))
  })
}

variable "location" {
  description = "default azure region to be used."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "default resource group to be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}
