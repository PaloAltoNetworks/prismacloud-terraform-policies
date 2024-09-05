# Overview

This repository provides a boilerplate for managing Prisma Cloud policies (both build and run) using the Terraform provider. It includes examples of creating sample policies, attaching them to a compliance standard, and setting up an alert rule. This repo is updated on a best-effort basis and should serve as an example and inspiration for utilizing the Prisma Terraform provider.  


# terraform-prismacloud-policies

This repo creates two sample policies, attach them to a compliance standard and create an alert rule attached to it.
This is updated on a best-effort basis, and should be considered as an example for inspiration of using the Prisma terraform provider. 

# Prerequisites

Ensure the following environment variables are configured in your environment:  
```
PRISMACLOUD_URL=
PRISMACLOUD_USERNAME=
PRISMACLOUD_PASSWORD=
PRISMACLOUD_CUSTOMER_NAME=
```

# Configuration
Update Terraform Variables: Modify `terraform.tfvars` with your relevant configuration:

```
emailRecipients = ["YOUR_EMAIL"]
complianceStandardName = "<COMPLIANCE_STANDARD_NAME>"
```

# Usage

Initialize Terraform: Run `terraform init` to initialize the provider.
Apply Configuration: Run `terraform apply` to create the resources.

# Code Explanation

- **policy_5**

This data source fetches all policies from Prisma Cloud.

```hcl
data "prismacloud_policies" "all_policies" {}
```
This resource creates a local file for each policy. The file is named based on the policy type and whether it is a built-in or custom policy. The content of the file is the JSON-encoded policy data.
```hcl
resource "local_file" "exported_policy_files" {
  for_each = {
    for key, value in data.prismacloud_policies.all_policies.listing :
    key => value
  }
  filename = "policies/${each.value.policy_type}/${each.value.system_default ? "builtin" : "custom"}/${substr(each.value.name, 0, 60)}.json"
  content  = jsonencode(each.value)
}
```
The exported policies will be organized in the following directory structure:

```
policies/
  ├── <policy_type>/
  │   ├── builtin/
  │   │   ├── <policy_name>.json
  │   └── custom/
  │       ├── <policy_name>.json
```
- <policy_type>: The type of the policy (e.g., network, config).
- builtin: Built-in policies provided by Prisma Cloud.
- custom: Custom policies created by the user.
- <policy_name>: The name of the policy, truncated to 60 characters.


# Contributions

Contributions to this repository are welcome. Please fork the repository and create a pull request with your changes.

# Documentation

See provier documentation for more details:
https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs