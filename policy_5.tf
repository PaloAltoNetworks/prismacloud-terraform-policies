data "prismacloud_policies" "all_policies" {}

resource "local_file" "exported_policy_files" {
  #  for_each = data.prismacloud_policies.all_policies.listing
  for_each = {
    for key, value in data.prismacloud_policies.all_policies.listing :
    key => value
  }
  # Determine the folder based on policy type and owner
  filename = "policies/${each.value.policy_type}/${each.value.system_default ? "builtin" : "custom"}/${substr(each.value.name, 0, 60)}.json"
  content  = jsonencode(each.value)
}
