resource "prismacloud_policy" "cost_center_tag_policy" {
  name            = "Ensure Azure resource group have a cost center"
  policy_type     = "config"
  cloud_type      = "aws"
  policy_subtypes = ["run", "build"]
  severity        = "high"
  labels          = ["smelotte-custom"]
  description     = "Ensure Azure resource group have a cost center"
  enabled         = true
  rule {
    name      = "Ensure Azure resource group have a cost center"
    rule_type = "Config"
    parameters = {
      savedSearch = true
      withIac     = true
    }
    criteria = prismacloud_saved_search.cost_center_tag_saved_search.id
    children {
      type           = "build"
      recommendation = "fix it"
      metadata = {
        "code" : file("build_policies/azure_rg_with_cost_center.yaml"),
      }
    }
  }
  compliance_metadata {
    compliance_id = prismacloud_compliance_standard_requirement_section.section.csrs_id
  }
}

resource "prismacloud_saved_search" "cost_center_tag_saved_search" {
  name        = "Ensure Azure resource group have a cost center"
  description = "Ensure Azure resource group have a cost center"
  search_id   = prismacloud_rql_search.cost_center_tag_rql.search_id
  query       = prismacloud_rql_search.cost_center_tag_rql.query
  time_range {
    relative {
      unit   = prismacloud_rql_search.cost_center_tag_rql.time_range.0.relative.0.unit
      amount = prismacloud_rql_search.cost_center_tag_rql.time_range.0.relative.0.amount
    }
  }
}


resource "prismacloud_rql_search" "cost_center_tag_rql" {
  search_type = "config"
  skip_result = true
  query       = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-resource-group' AND json.rule = tags does not contain cost-center"
  time_range {
    relative {
      unit   = "hour"
      amount = 24
    }
  }
}
