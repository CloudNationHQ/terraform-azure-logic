# Default

This example illustrates the default setup, in its simplest form.

## Usage

```hcl
module "logic" {
  source  = "cloudnationhq/logic/azure"
  version = "~> 1.0"

  instance = {
    name                       = "demo-logic-app-wamtest-01"
    location                   = "westeurope"
    resource_group_name        = "rg-demo-dev"
    app_service_plan_id        = "/subscriptions/.../Microsoft.Web/serverfarms/plan-demo-dev"
    storage_account_name       = "stademodev"
    storage_account_access_key = "storage_account_access_key"

    app_settings = {
      "FUNCTIONS_WORKER_RUNTIME"      = "node"
      "WEBSITE_NODE_DEFAULT_VERSION" = "~18"
    }

    identity = {
      type = "SystemAssigned"
    }

    site_config = {
      always_on       = true
      http2_enabled   = true
      min_tls_version = "1.2"

      cors = {
        allowed_origins = ["https://portal.azure.com"]
      }
    }
  }
}
```
