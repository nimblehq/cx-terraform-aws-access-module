module "iam_groups" {
  source = "./modules/iam_groups"
}

module "iam_admin_users" {
  source = "./modules/iam_users"

  usernames = var.admins_emails
}

module "iam_developer_users" {
  source = "./modules/iam_users"

  usernames = var.developers_emails
}

module "iam_infra_service_account_users" {
  source = "./modules/iam_users"

  usernames = var.infra_service_accounts_emails
  has_login = false
}

module "iam_group_membership" {
  source = "./modules/iam_group_membership"

  for_each = {
    admin                 = { group = module.iam_groups.admin_group, users = var.admins_emails },
    infra_service_account = { group = module.iam_groups.infra_service_account_group, users = var.infra_service_accounts_emails },
    developer             = { group = module.iam_groups.developer_group, users = var.developers_emails }
  }

  name  = "${each.key}-group-membership"
  group = each.value.group
  users = each.value.users

  depends_on = [
    module.iam_groups,
    module.iam_admin_users,
    module.iam_developer_users,
    module.iam_infra_service_account_users,
  ]
}
