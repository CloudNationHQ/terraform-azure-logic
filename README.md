# Logic App Standard

This terraform module simplifies the creation and management of Azure Logic App Standard resources, providing customizable options for workflow configuration, identity management, networking, and site configuration.

## Features

- Capability to create and manage Logic App Standard instances
- Support for system-assigned and user-assigned managed identities
- Configurable site settings including TLS version, CORS, and IP restrictions
- Virtual network integration support
- App settings and connection string management
- Lifecycle management to prevent configuration drift

Utilization of terratest for robust validation.

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.0)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.6)

- <a name="requirement_tls"></a> [tls](#requirement\_tls) (~> 4.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~> 4.0)

## Resources

The following resources are used by this module:

- [azurerm_logic_app_standard.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_standard) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_instance"></a> [instance](#input\_instance)

Description: describes logic app standard configuration

Type:

```hcl
object({
    name                       = string
    resource_group_name        = optional(string)
    location                   = optional(string)
    app_service_plan_id        = string
    storage_account_name       = string
    storage_account_access_key = string

    # optional settings
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
      always_on                        = optional(bool, false)
      app_scale_limit                  = optional(number)
      auto_swap_slot_name              = optional(string)
      dotnet_framework_version         = optional(string, "v4.0")
      elastic_instance_minimum         = optional(number)
      ftps_state                       = optional(string, "AllAllowed")
      health_check_path                = optional(string)
      http2_enabled                    = optional(bool, false)
      linux_fx_version                 = optional(string)
      min_tls_version                  = optional(string, "1.2")
      pre_warmed_instance_count        = optional(number)
      runtime_scale_monitoring_enabled = optional(bool, false)
      scm_min_tls_version              = optional(string, "1.2")
      scm_type                         = optional(string, "None")
      scm_use_main_ip_restriction      = optional(bool, false)
      use_32_bit_worker_process        = optional(bool, true)
      vnet_route_all_enabled           = optional(bool)
      websockets_enabled               = optional(bool)

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
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_location"></a> [location](#input\_location)

Description: default azure region to be used.

Type: `string`

Default: `null`

### <a name="input_naming"></a> [naming](#input\_naming)

Description: contains naming convention

Type: `map(string)`

Default: `{}`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: default resource group to be used.

Type: `string`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: tags to be added to the resources

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_instance"></a> [instance](#output\_instance)

Description: contains all logic app standard configuration
<!-- END_TF_DOCS -->

## Goals

For more information, please see our [goals and non-goals](./GOALS.md).

## Testing

For more information, please see our testing [guidelines](./TESTING.md)

## Notes

Using a dedicated module, we've developed a naming convention for resources that's based on specific regular expressions for each type, ensuring correct abbreviations and offering flexibility with multiple prefixes and suffixes.

Full examples detailing all usages, along with integrations with dependency modules, are located in the examples directory.

To update the module's documentation run `make doc`

## Authors

Module is maintained by [these awesome contributors](https://github.com/cloudnationhq/terraform-azure-logic/graphs/contributors).

## Contributors

We welcome contributions from the community! Whether it's reporting a bug, suggesting a new feature, or submitting a pull request, your input is highly valued.

For more information, please see our contribution [guidelines](./CONTRIBUTING.md). <br><br>

<a href="https://github.com/cloudnationhq/terraform-azure-logic/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudnationhq/terraform-azure-logic" />
</a>

## License

MIT Licensed. See [LICENSE](./LICENSE) for full details.

## References

- [Documentation](https://learn.microsoft.com/en-us/azure/logic-apps/)
- [Rest Api](https://learn.microsoft.com/en-us/rest/api/logic/)
- [Rest Api Specs](https://github.com/Azure/azure-rest-api-specs/tree/main/specification/web/resource-manager)
