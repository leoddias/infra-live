# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.
locals {
  account_name   = "infra"
  aws_account_id = "BBBBBBBBBBBB"
  aws_profile    = "infra"
}