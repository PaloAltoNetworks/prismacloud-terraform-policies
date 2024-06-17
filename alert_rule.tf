
resource "prismacloud_alert_rule" "example" {
  name        = "Terraform-Alert-Rule"
  description = "Made by Terraform"
  policies    = tolist([prismacloud_policy.iam_access_to_keyvault_policy.policy_id, prismacloud_policy.check_ec2_env_tag_policy.policy_id, prismacloud_policy.cost_center_tag_policy.policy_id])
  target {
    account_groups = [data.prismacloud_account_group.aws_payg.group_id]
  }

  notification_config {
    enabled             = false
    include_remediation = false
    config_type         = "email"
    frequency           = "as_it_happens"
    recipients          = var.emailRecipients
  }

}
