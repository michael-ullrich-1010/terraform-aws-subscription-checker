# terraform-aws-subscription-checker


```hcl
provider "aws" {
  region = "eu-central-1"
}

terraform {
  required_version = ">= 0.15.0"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 4.00"
      configuration_aliases = []
    }
  }
}

module "subscription_backend_consumer" {
  source = "github.com/michael-ullrich-1010/terraform-aws-subscription-checker.git?ref=main"
}

```