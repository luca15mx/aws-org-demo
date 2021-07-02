# Crear el role en la cuenta invitada
module "organization_access_role" {
  source            = "git::https://github.com/cloudposse/terraform-aws-organization-access-role.git?ref=master"
  master_account_id = var.gv_master_account_id
  role_name         = "OrganizationAccountAccessRole"
  policy_arn        = "arn:aws:iam::aws:policy/AdministratorAccess"
  providers = {
    aws = aws.master
  }
}

module "policy_for_master_account" {
  source                  = "./iam"
  miam_invited_account_id = var.gv_invited_account_id
}

# Crear el role en la cuenta maestra
module "organization_access_group" {
  source     = "git::https://github.com/cloudposse/terraform-aws-organization-access-group.git?ref=master"
  namespace  = "cp"
  stage      = "dev"
  name       = "DelegateAdminMemebeAccounts"
  user_names = ["console_user_mr"]
  role_arns = {
    "cp@dev" = "arn:aws:iam::${var.gv_invited_account_id}:role/OrganizationAccountAccessRole"
  }
  require_mfa = "false"
  providers = {
    aws = aws.invited
  }
}
