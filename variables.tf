variable "admins_emails" {
  type        = list(string)
  description = "List of emails of the admins"
}

variable "developers_emails" {
  type        = list(string)
  description = "List of emails of the developers"
}

variable "infra_service_accounts_emails" {
  type        = list(string)
  description = "List of emails of the service accounts"
}
