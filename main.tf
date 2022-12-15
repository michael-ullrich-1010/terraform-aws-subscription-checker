# ---------------------------------------------------------------------------------------------------------------------
# ¦ REQUIREMENTS
# ---------------------------------------------------------------------------------------------------------------------
terraform {
  # This module is only being tested with Terraform 0.15.x and newer.
  required_version = ">= 0.15.0"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 4.00"
      configuration_aliases = []
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# ¦ DATA
# ---------------------------------------------------------------------------------------------------------------------
data "aws_caller_identity" "current" {}
data "aws_organizations_organization" "current" {}
data "aws_region" "current" {}


# ---------------------------------------------------------------------------------------------------------------------
# ¦ SUBSCRIPTION_CKECKER_MEMBER - LAMBDA
# ---------------------------------------------------------------------------------------------------------------------
module "subscription_checker_member" {
  source  = "nuvibit/lambda/aws"
  version = "~> 1.0"

  function_name           = var.lambda_name
  description             = "Test Subscription."
  layers                  = var.nuvibit_lambda_layer_arns
  iam_execution_role_name = format("%s-exec-role", var.lambda_name)

  runtime             = "python3.9"
  package_source_path = "${path.module}/lambda-files/"
  handler             = "main.lambda_handler"
  environment_variables = {
    SUBSCRIPTION_URL       = var.subscription_backend_api_gateway_endpoint_url
    LOG_LEVEL              = "INFO"
    SUBSCRIPTION_TOKEN     = ""
  }
  memory_size           = 512
  timeout               = 60
  log_retention_in_days = 5
  tracing_mode          = "Active"
}


# ---------------------------------------------------------------------------------------------------------------------
# ¦ LAMBDA EXECUTION POLICY
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_iam_role_policy" "subscription_checker_member" {
  name   = replace(module.subscription_checker_member.lambda_execution_role_name, "role", "policy")
  role   = module.subscription_checker_member.lambda_execution_role_name
  policy = data.aws_iam_policy_document.subscription_checker_member.json
}

data "aws_iam_policy_document" "subscription_checker_member" {

  statement {
    sid    = "LicenseManagement"
    effect = "Allow"
    actions = [
      "lambda:GetFunctionConfiguration",
      "lambda:UpdateFunctionConfiguration"
    ]
    resources = [module.subscription_checker_member.lambda_arn]
  }
  statement {
    sid    = "LicenseManagementOrgId"
    effect = "Allow"
    actions = [
      "organizations:DescribeOrganization"
    ]
    resources = ["*"]
  }
}
