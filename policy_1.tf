resource "prismacloud_policy" "iam_access_to_keyvault_policy" {
  name            = "Service Principal with wildcard permissions to KeyVault"
  policy_type     = "iam"
  cloud_type      = "azure"
  severity        = "high"
  labels          = ["TERRAFORM-TEST"]
  policy_subtypes = ["run"]
  description     = "CREATED WITH TERRAFORM"
  enabled         = true
  rule {
    name      = "Service Principal with wildcard permissions to KeyVault"
    rule_type = "Config"
    parameters = {
      savedSearch = true
    }
    criteria = prismacloud_saved_search.iam_access_to_keyvault_saved_search.search_id
  }
}

resource "prismacloud_saved_search" "iam_access_to_keyvault_saved_search" {
  name        = "Service Principal with wildcard permissions to KeyVault"
  description = "TERRAFORM saved RQL search"
  search_id   = prismacloud_rql_search.iam_access_to_keyvault_rql.search_id
  query       = prismacloud_rql_search.iam_access_to_keyvault_rql.query
  time_range {
    relative {
      unit   = prismacloud_rql_search.check_ec2_env_tag_rql.time_range.0.relative.0.unit
      amount = prismacloud_rql_search.check_ec2_env_tag_rql.time_range.0.relative.0.amount
    }
  }

}

resource "prismacloud_rql_search" "iam_access_to_keyvault_rql" {
  search_type = "iam"
  query       = "config from iam where source.cloud.type = 'Azure' AND grantedby.cloud.entity.type = 'Service Principal' AND grantedby.cloud.policy.type = 'Built-in Role' AND grantedby.cloud.policy.name IN( 'Key Vault Administrator','Key Vault Certificates Officer','Key Vault Crypto Officer','Key Vault Crypto Service Encryption User','Key Vault Crypto User','Key Vault Reader','Key Vault Secrets Officer','Key Vault Secrets User') AND dest.cloud.service.name = 'Microsoft.KeyVault' AND dest.cloud.resource.name = '*'"

  time_range {
    to_now {
      unit = "epoch"
    }
  }

}
