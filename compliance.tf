resource "prismacloud_compliance_standard" "standard" {
  name        = var.complianceStandardName
  description = "Created with Terraform"
}


resource "prismacloud_compliance_standard_requirement" "requ" {
  cs_id          = prismacloud_compliance_standard.standard.cs_id
  name           = "My first req"
  description    = "Created with Terraform"
  requirement_id = "1.007"
}

resource "prismacloud_compliance_standard_requirement_section" "section" {
  csr_id      = prismacloud_compliance_standard_requirement.requ.csr_id
  section_id  = "Section 1"
  description = "Section description"
}
