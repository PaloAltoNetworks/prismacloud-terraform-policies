resource "prismacloud_policy" "check_ec2_env_tag_policy" {
  name            = "Ensure AWS EC2 instance have all 'environment' tag."
  policy_type     = "config"
  cloud_type      = "aws"
  policy_subtypes = ["run", "build"]
  severity        = "low"
  labels          = ["smelotte-custom"]
  description     = "Ensure AWS EC2 instance have all 'environment' tag."
  enabled         = true
  rule {
    name      = "Ensure AWS EC2 instance have all 'environment' tag."
    rule_type = "Config"
    parameters = {
      savedSearch = true
      withIac     = true
    }
    criteria = prismacloud_saved_search.check_ec2_env_tag_saved_search.id
    children {
      type           = "build"
      recommendation = "fix it"
      metadata = {
        "code" : file("build_policies/aws_env_tag.yaml"),
      }
    }
  }
  compliance_metadata {
    compliance_id = prismacloud_compliance_standard_requirement_section.section.csrs_id
  }
}

resource "prismacloud_saved_search" "check_ec2_env_tag_saved_search" {
  name        = "Ensure AWS EC2 instance have all 'environment' tag."
  description = "Ensure AWS EC2 instance have all 'environment' tag."
  search_id   = prismacloud_rql_search.check_ec2_env_tag_rql.search_id
  query       = prismacloud_rql_search.check_ec2_env_tag_rql.query
  time_range {
    relative {
      unit   = prismacloud_rql_search.check_ec2_env_tag_rql.time_range.0.relative.0.unit
      amount = prismacloud_rql_search.check_ec2_env_tag_rql.time_range.0.relative.0.amount
    }
  }
}


resource "prismacloud_rql_search" "check_ec2_env_tag_rql" {
  search_type = "config"
  skip_result = true
  query       = "config from cloud.resource where api.name = 'aws-ec2-describe-instances' AND json.rule = tags[*].key does not contain environment"
  time_range {
    relative {
      unit   = "hour"
      amount = 24
    }
  }
}
