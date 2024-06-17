resource "prismacloud_policy" "aks_check_rbac_policy" {
  name            = "AKS With Enable RBAC Properties set to False"
  policy_type     = "config"
  cloud_type      = "azure"
  severity        = "high"
  labels          = ["TERRAFORM-TEST2"]
  policy_subtypes = ["run"]
  description     = "CREATED WITH TERRAFORM"
  enabled         = true
  rule {
    name      = "AKS With Enable RBAC Properties set to False"
    rule_type = "Config"
    parameters = {
      savedSearch = true
    }
    criteria = prismacloud_saved_search.aks_check_rbac_saved_search.search_id
  }
  compliance_metadata {
    compliance_id = prismacloud_compliance_standard_requirement_section.section.csrs_id
  }
}

resource "prismacloud_saved_search" "aks_check_rbac_saved_search" {
  name        = "AKS With Enable RBAC Properties set to False"
  description = "TERRAFORM saved RQL search"
  search_id   = prismacloud_rql_search.aks_check_rbac_rql.search_id
  query       = prismacloud_rql_search.aks_check_rbac_rql.query
  time_range {
    relative {
      unit   = prismacloud_rql_search.aks_check_rbac_rql.time_range.0.relative.0.unit
      amount = prismacloud_rql_search.aks_check_rbac_rql.time_range.0.relative.0.amount
    }
  }
}

resource "prismacloud_rql_search" "aks_check_rbac_rql" {
  search_type = "config"
  query       = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-kubernetes-cluster' AND json.rule = properties.enableRBAC is false"
  time_range {
    relative {
      unit   = "hour"
      amount = 24
    }
  }

}
