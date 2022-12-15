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

Steps:

- Provision the terraform module to your AWS Account (Lambda with minimal permission will be provisioned) - please use eu-central-1 as region.
- Test/Execute the provisioned Lambda **subscription-checker-test** with any test-event as payload
- In the first Lambda-run a **Subscription Token** will be pulled from our backend and stored in the env-vars of the Lambda
- In the following Lambda-runs the **Subscription Token** will be taken from the env-vars of the Lambda

Your Task: Attack the subscription mechanism to alter the Subscription Token.

Acceptance criteria:
- **Subscription Token** must be tampered/faked to be valid. Currently, the subscription is expired.
- Python code in Lambda (except [main.py](lambda-files/main.py)) must be unveiled - altering [main.py](lambda-files/main.py) is not a solution
- Description/explanation of your steps

If you would like more clarification, please feel free to contact me.