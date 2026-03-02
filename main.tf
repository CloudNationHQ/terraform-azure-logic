resource "azurerm_logic_app_standard" "this" {
  name                       = var.instance.name
  resource_group_name        = coalesce(lookup(var.instance, "resource_group_name", null), var.resource_group_name)
  location                   = coalesce(lookup(var.instance, "location", null), var.location)
  app_service_plan_id        = var.instance.app_service_plan_id
  storage_account_name       = var.instance.storage_account_name
  storage_account_access_key = var.instance.storage_account_access_key

  app_settings                             = var.instance.app_settings
  use_extension_bundle                     = var.instance.use_extension_bundle
  bundle_version                           = var.instance.bundle_version
  client_affinity_enabled                  = var.instance.client_affinity_enabled
  client_certificate_mode                  = var.instance.client_certificate_mode
  enabled                                  = var.instance.enabled
  ftp_publish_basic_authentication_enabled = var.instance.ftp_publish_basic_authentication_enabled
  https_only                               = var.instance.https_only
  public_network_access                    = var.instance.public_network_access
  scm_publish_basic_authentication_enabled = var.instance.scm_publish_basic_authentication_enabled
  storage_account_share_name               = var.instance.storage_account_share_name
  version                                  = var.instance.version
  virtual_network_subnet_id                = var.instance.virtual_network_subnet_id
  vnet_content_share_enabled               = var.instance.vnet_content_share_enabled
  tags                                     = coalesce(var.instance.tags, var.tags)

  dynamic "connection_string" {
    for_each = try(var.instance.connection_strings, {})
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  dynamic "identity" {
    for_each = lookup(var.instance, "identity", null) != null ? [var.instance.identity] : []
    content {
      type         = identity.value.type
      identity_ids = try(identity.value.identity_ids, null)
    }
  }

  dynamic "site_config" {
    for_each = lookup(var.instance, "site_config", null) != null ? [var.instance.site_config] : []
    content {
      always_on                        = site_config.value.always_on
      app_scale_limit                  = site_config.value.app_scale_limit
      auto_swap_slot_name              = site_config.value.auto_swap_slot_name
      dotnet_framework_version         = site_config.value.dotnet_framework_version
      elastic_instance_minimum         = site_config.value.elastic_instance_minimum
      ftps_state                       = site_config.value.ftps_state
      health_check_path                = site_config.value.health_check_path
      http2_enabled                    = site_config.value.http2_enabled
      linux_fx_version                 = site_config.value.linux_fx_version
      min_tls_version                  = site_config.value.min_tls_version
      pre_warmed_instance_count        = site_config.value.pre_warmed_instance_count
      runtime_scale_monitoring_enabled = site_config.value.runtime_scale_monitoring_enabled
      scm_min_tls_version              = site_config.value.scm_min_tls_version
      scm_type                         = site_config.value.scm_type
      scm_use_main_ip_restriction      = site_config.value.scm_use_main_ip_restriction
      use_32_bit_worker_process        = site_config.value.use_32_bit_worker_process
      vnet_route_all_enabled           = site_config.value.vnet_route_all_enabled
      websockets_enabled               = site_config.value.websockets_enabled

      dynamic "cors" {
        for_each = lookup(site_config.value, "cors", null) != null ? [site_config.value.cors] : []
        content {
          allowed_origins     = cors.value.allowed_origins
          support_credentials = cors.value.support_credentials
        }
      }

      dynamic "ip_restriction" {
        for_each = try(site_config.value.ip_restrictions, {})
        content {
          ip_address                = ip_restriction.value.ip_address
          service_tag               = ip_restriction.value.service_tag
          virtual_network_subnet_id = ip_restriction.value.virtual_network_subnet_id
          name                      = ip_restriction.value.name
          priority                  = ip_restriction.value.priority
          action                    = ip_restriction.value.action
          description               = ip_restriction.value.description

          dynamic "headers" {
            for_each = lookup(ip_restriction.value, "headers", null) != null ? [ip_restriction.value.headers] : []
            content {
              x_azure_fdid      = headers.value.x_azure_fdid
              x_fd_health_probe = headers.value.x_fd_health_probe
              x_forwarded_for   = headers.value.x_forwarded_for
              x_forwarded_host  = headers.value.x_forwarded_host
            }
          }
        }
      }

      dynamic "scm_ip_restriction" {
        for_each = try(site_config.value.scm_ip_restrictions, {})
        content {
          ip_address                = scm_ip_restriction.value.ip_address
          service_tag               = scm_ip_restriction.value.service_tag
          virtual_network_subnet_id = scm_ip_restriction.value.virtual_network_subnet_id
          name                      = scm_ip_restriction.value.name
          priority                  = scm_ip_restriction.value.priority
          action                    = scm_ip_restriction.value.action
          description               = scm_ip_restriction.value.description

          dynamic "headers" {
            for_each = lookup(scm_ip_restriction.value, "headers", null) != null ? [scm_ip_restriction.value.headers] : []
            content {
              x_azure_fdid      = headers.value.x_azure_fdid
              x_fd_health_probe = headers.value.x_fd_health_probe
              x_forwarded_for   = headers.value.x_forwarded_for
              x_forwarded_host  = headers.value.x_forwarded_host
            }
          }
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_CONTENTSHARE"],
      app_settings["WEBSITE_CONTENTAZUREFILECONNECTIONSTRING"]
    ]
  }

}
