locals {
  user_accounts = var.has_login ? aws_iam_user.user_account : {}
}

resource "aws_iam_user" "user_account" {
  for_each = toset(var.usernames)

  name = each.value
  path = var.path

  force_destroy = true

  # If an access key is generated, the account will be tagged automatically with the Key ID 
  # and each TF run will try to remove the tag.
  lifecycle {
    ignore_changes = [
      tags,
      tags_all
    ]
  }
}

resource "aws_iam_user_login_profile" "user_account" {
  for_each = local.user_accounts

  user = each.value.name

  lifecycle {
    ignore_changes = [
      password_reset_required,
    ]
  }
}
