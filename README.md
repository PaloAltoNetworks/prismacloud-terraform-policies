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

# Contributions

Contributions to this repository are welcome. Please fork the repository and create a pull request with your changes.

# Documentation

See provier documentation for more details:
https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs